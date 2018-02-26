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
#import "CustomAnnotationView.h"
#import "StoresAddressView.h"
#import "CustomeAnnoPoint.h"

@interface StoresMapController ()<BMKMapViewDelegate,BMKLocationServiceDelegate>
@property (nonatomic, strong) BMKLocationService *locationService;
@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, assign) BOOL isAlreadyUpdate;
@property (weak, nonatomic) IBOutlet UIView *contentV;
@property (weak, nonatomic) IBOutlet UITextField *searchTf;

@property (nonatomic, strong) StoresAddressView *dropDownV;
@property (weak, nonatomic) IBOutlet UIView *titleBgV;

@property (nonatomic, strong) NSArray *allAnno;
@property (weak, nonatomic) IBOutlet BMKMapView *mapView;





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

    self.contentV.frame = CGRectMake(self.contentV.frame.origin.x, self.contentV.frame.origin.y, UIScreenWidth, self.contentV.frame.size.height);
    
    self.locationService = [[BMKLocationService alloc]init];
    [self.locationService startUserLocationService];
    
    self.mapView.mapType = BMKMapTypeStandard;
    self.mapView.frame = self.view.bounds;
    self.mapView.showMapScaleBar = YES;
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = BMKUserTrackingModeFollow;
    self.mapView.buildingsEnabled = YES;
    
    BMKLocationViewDisplayParam* param = [[BMKLocationViewDisplayParam alloc] init];
    param.locationViewOffsetY = 0;//偏移量
    param.locationViewOffsetX = 0;
    param.isAccuracyCircleShow = YES;//设置是否显示定位的那个精度圈
    param.isRotateAngleValid = YES;
    param.canShowCallOut = NO;
    [_mapView updateLocationViewWithParam:param];
    
    [self.contentV insertSubview:self.mapView atIndex:0];
    
    self.searchTf.layer.cornerRadius = 4.0;
    self.searchTf.layer.masksToBounds = YES;
    
    self.searchTf.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 20)];
    self.searchTf.leftViewMode = UITextFieldViewModeAlways;
    
    
}



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locationService.delegate = self;
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    _mapView.delegate = nil; // 不用时，置nil
    _locationService.delegate = nil;
}

- (void)getStoreListData{
    MJWeakSelf;
    [HUDManager showLoading:@"加载中..."];
    [HomePageHttpTool getAllStoreListWithKeyWord:nil WithCompleted:^(id result, BOOL success) {
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
            CustomeAnnoPoint *anno = [[CustomeAnnoPoint alloc]init];
            StoreModel *model = _dataArr[i];
//            anno.title = [NSString stringWithFormat:@"%lu",i+1];
            anno.model = model;
            
            sumLat = sumLat + model.lat.doubleValue;
            sumlon = sumlon + model.lng.doubleValue;
            
            [latArr addObject:model.lat];
            [lonArr addObject:model.lng];
            
            [arr addObject:anno];
        }
        self.allAnno = arr;
        
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
    
    if ([annotation isKindOfClass:[CustomeAnnoPoint class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        CustomAnnotationView *annotationView = (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation
                                                              reuseIdentifier:reuseIndetifier];
            annotationView.canShowCallout = NO;
        }
        
        annotationView.image = [UIImage imageNamed:@"add_me"];
        return annotationView;
    }
    return nil;
    
}


- (void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views{
    NSLog(@"添加了大头针");
}


- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{
    NSLog(@"选中了某个大头针");
    [view setSelected:YES animated:YES];
    [self.mapView setCenterCoordinate:view.annotation.coordinate animated:YES];
}


- (void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view{
    NSLog(@"取消选中大头针");
    [view setSelected:NO animated:YES];
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


#pragma mark -
#pragma mark - action

- (IBAction)zoomInBtnClick:(UIButton *)sender {
    [self.mapView zoomIn];
}

- (IBAction)zoomOutBtnClick:(UIButton *)sender {
    [self.mapView zoomOut];
}

- (IBAction)navBackBtnClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (IBAction)searchBtnClick:(UIButton *)sender {
    
    if (self.searchTf.text.length==0) {
        [HUDManager showErrorMsg:@"请输入搜索门店地址"];
        return;
    }
    
    [self.dropDownV searchWithKeyword:self.searchTf.text];

}


- (IBAction)searchTfEditingDidBegin:(UITextField *)sender {
    
    [self.dropDownV showInView:self.searchTf];
    
}


- (IBAction)searchTfDidEndEditing:(UITextField *)sender {
    
    [self.dropDownV dismiss];
    sender.text = nil;
}

- (IBAction)searchTfDidChange:(UITextField *)sender {
    
    if (sender.text.length!=0) {
        [self.dropDownV searchWithKeyword:sender.text];
    }
    
}


- (IBAction)locateMyselfBtnClick:(UIButton *)sender {
    
    [self.mapView setCenterCoordinate:self.locationService.userLocation.location.coordinate animated:YES];
}




#pragma mark -
#pragma mark - 懒加载
- (StoresAddressView*)dropDownV{
    if (_dropDownV==nil) {
        _dropDownV = LOAD_XIB_CLASS(StoresAddressView);
        
        [self.view insertSubview:_dropDownV belowSubview:self.titleBgV];
        MJWeakSelf;
        _dropDownV.selectblock = ^(StoreModel *model) {
            [weakSelf selectAnnotatonModel:model];
        };
    }
    return _dropDownV;
}


- (void)selectAnnotatonModel:(StoreModel*)model{
    if (model) {
        
        CustomeAnnoPoint *myAnno;
        for (NSInteger i=0; i<self.allAnno.count; i++) {
            CustomeAnnoPoint *anno = self.allAnno[i];
            if ([anno.model.ID isEqualToString:model.ID]) {
                myAnno = anno;
                break;
            }
        }
        
        if (myAnno==nil) {
            myAnno = self.allAnno.firstObject;
        }
        
        [self.mapView selectAnnotation:myAnno animated:YES];
        
        CLLocationCoordinate2D center = myAnno.coordinate;
        BMKCoordinateSpan span = BMKCoordinateSpanMake(0.01, 0.01);
        BMKCoordinateRegion region = BMKCoordinateRegionMake(center, span);
        
        [self.mapView setRegion:region animated:YES];

    }
}


- (void)dealloc{
    self.mapView = nil;
}




@end
