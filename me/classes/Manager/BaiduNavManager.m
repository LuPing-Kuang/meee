//
//  BaiduNavManager.m
//  me
//
//  Created by KLP on 2018/2/3.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "BaiduNavManager.h"

@interface BaiduNavManager()<BMKGeneralDelegate>

@property (nonatomic, strong) BMKMapManager *mapManager;


@end

@implementation BaiduNavManager

+ (instancetype)sharedInstance{
    static BaiduNavManager *obj = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        obj = [[BaiduNavManager alloc]init];
        
    });
    return obj;
}



- (void)startWithAppKey:(NSString*)key{
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    
    /**
     *百度地图SDK所有接口均支持百度坐标（BD09）和国测局坐标（GCJ02），用此方法设置您使用的坐标类型.
     *默认是BD09（BMK_COORDTYPE_BD09LL）坐标.
     *如果需要使用GCJ02坐标，需要设置CoordinateType为：BMK_COORDTYPE_COMMON.
     */
    if ([BMKMapManager setCoordinateTypeUsedInBaiduMapSDK:BMK_COORDTYPE_GPS]) {
        NSLog(@"经纬度类型设置成功");
    } else {
        NSLog(@"经纬度类型设置失败");
    }
    BOOL ret = [_mapManager start:key generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
}


@end
