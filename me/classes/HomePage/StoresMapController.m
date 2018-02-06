//
//  StoresMapController.m
//  me
//
//  Created by KLP on 2018/2/3.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "StoresMapController.h"
#import "HomePageHttpTool.h"
#import "StoreModel.h"

@interface StoresMapController ()<BMKMapViewDelegate,BMKLocationServiceDelegate>
@property (nonatomic, strong) BMKMapView *mapView;
@property (nonatomic, strong) BMKLocationService *locationService;
@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, assign) BOOL isAlreadyUpdate;



@end

@implementation StoresMapController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"门店地图";
    [self setUpSubViews];
    [self getStoreListData];
}

- (void)setUpSubViews{
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"custom_config_清新蓝" ofType:@""];
    [BMKMapView customMapStyle:path];
    
    self.locationService = [[BMKLocationService alloc]init];
    self.locationService.delegate = self;
    [self.locationService startUserLocationService];
    
    self.mapView = [[BMKMapView alloc]init];
    self.mapView.delegate = self;
    self.mapView.mapType = BMKMapTypeStandard;
    self.mapView.frame = self.view.bounds;
    self.mapView.showMapScaleBar = YES;
    self.mapView.gesturesEnabled = YES;
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = BMKUserTrackingModeFollow;
    [self.view addSubview:self.mapView];
    
}


- (void)getStoreListData{
    MJWeakSelf;
    [HUDManager showLoading:@"加载中..."];
    [HomePageHttpTool getAllStoreListWithType:nil WithCompleted:^(id result, BOOL success) {
        if (success) {
            weakSelf.dataArr = result;
            [HUDManager dismiss];
        }else{
            [HUDManager showErrorMsg:result];
        }
    }];

}


- (void)setDataArr:(NSArray *)dataArr{
    _dataArr = dataArr;
    if (_dataArr.count!=0) {
        
        NSMutableArray *arr= [NSMutableArray array];
        
        double sumLat = 0;
        double sumlon = 0;
        double minlat = 0;
        double minlon = 0;
        double maxlat = 0;
        double maxlon = 0;
        NSMutableArray *latArr = [NSMutableArray array];
        NSMutableArray *lonArr = [NSMutableArray array];
        
        for (NSInteger i=0; i<_dataArr.count; i++) {
            BMKPointAnnotation *anno = [[BMKPointAnnotation alloc]init];
            StoreModel *model = _dataArr[i];
//            anno.title = [NSString stringWithFormat:@"%lu",i+1];
            anno.title = model.storename;
            anno.coordinate = CLLocationCoordinate2DMake(model.lat.doubleValue, model.lng.doubleValue);
            
            sumLat = sumLat + model.lat.doubleValue;
            sumlon = sumlon + model.lng.doubleValue;
            
            [latArr addObject:model.lat];
            [lonArr addObject:model.lng];
            
            [arr addObject:anno];
        }
        
        
        [latArr sortUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
            if (obj1.doubleValue<obj2.doubleValue) {
                return NSOrderedAscending;
            }else{
                return NSOrderedDescending;
            }
        }];
        
        [lonArr sortUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
            if (obj1.doubleValue<obj2.doubleValue) {
                return NSOrderedAscending;
            }else{
                return NSOrderedDescending;
            }
        }];
        minlat = [latArr.firstObject doubleValue];
        maxlat = [latArr.lastObject doubleValue];
        minlon = [lonArr.firstObject doubleValue];
        maxlon = [lonArr.lastObject doubleValue];
        
        CLLocationCoordinate2D center = CLLocationCoordinate2DMake((sumLat/_dataArr.count), (sumlon/_dataArr.count));
        BMKCoordinateSpan span = BMKCoordinateSpanMake((maxlat-minlat)/2.0+0.3, (maxlon-minlon)/2.0+0.3);
        BMKCoordinateRegion region = BMKCoordinateRegionMake(center, span);
        [self.mapView addAnnotations:arr];
        [self.mapView setRegion:region animated:YES];
        
    }
}



#pragma mark -
#pragma mark - BMKMapViewDelegate
- (void)mapViewDidFinishLoading:(BMKMapView *)mapView{
    NSLog(@"初始化完成");
   
}


- (void)mapViewDidFinishRendering:(BMKMapView *)mapView{
    NSLog(@"地图渲染完毕");
}

- (void)mapView:(BMKMapView *)mapView onDrawMapFrame:(BMKMapStatus*)status{
    NSLog(@"又在渲染");
}

- (void)mapView:(BMKMapView *)mapView regionWillChangeAnimated:(BOOL)animated{
    NSLog(@"改变了区域");
}

- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    NSLog(@"地图区域改变完成");
}


- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation{
    NSLog(@"生成大头针");
    
    //如果是注释点
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        
        //根据注释点,创建并初始化注释点视图
        static NSString *reuseIdentifier = @"an";
        BMKPinAnnotationView  *newAnnotation;
        newAnnotation = (BMKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIdentifier];
        
        if (!newAnnotation) {
            newAnnotation = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
        }
        
        //设置大头针的颜色
        newAnnotation.pinColor = BMKPinAnnotationColorRed;
        //设置动画
        newAnnotation.animatesDrop = YES;
        
        return newAnnotation;
        
    }
    
    
    return nil;
}


- (void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views{
    NSLog(@"添加了大头针");
}


- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{
    NSLog(@"选中了某个大头针");
}


- (void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view{
    NSLog(@"取消选中大头针");
}


- (void)mapView:(BMKMapView *)mapView annotationView:(BMKAnnotationView *)view didChangeDragState:(BMKAnnotationViewDragState)newState
   fromOldState:(BMKAnnotationViewDragState)oldState{
    NSLog(@"大头针正在被拖动");
}


- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view{
    NSLog(@"弹出了气泡");
}


- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay{
    NSLog(@"生成了覆盖物");
    return nil;
}


- (void)mapView:(BMKMapView *)mapView didAddOverlayViews:(NSArray *)overlayViews{
    NSLog(@"添加了覆盖物");
}


- (void)mapView:(BMKMapView *)mapView onClickedBMKOverlayView:(BMKOverlayView *)overlayView{
    NSLog(@"点击了覆盖物");
}


- (void)mapView:(BMKMapView *)mapView onClickedMapPoi:(BMKMapPoi*)mapPoi{
    NSLog(@"点击了地图标注");
}


- (void)mapview:(BMKMapView *)mapView onDoubleClick:(CLLocationCoordinate2D)coordinate{
    NSLog(@"双击了地图");
}


- (void)mapview:(BMKMapView *)mapView onLongClick:(CLLocationCoordinate2D)coordinate{
    NSLog(@"长按了地图");
}


#pragma mark -
#pragma mark - BMKLocationServiceDelegate
- (void)didStopLocatingUser{
    NSLog(@"停止了定位");
}

- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation{
    NSLog(@"用户的头像更新了");
}


- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    NSLog(@"用户的位置更新了");
    if (!self.isAlreadyUpdate) {
        self.isAlreadyUpdate = YES;
        //展示定位
        self.mapView.showsUserLocation = YES;
        //更新位置数据
        [self.mapView updateLocationData:userLocation];
        
    }
    

}

- (void)didFailToLocateUserWithError:(NSError *)error{
    NSLog(@"定位失败");
}


@end
