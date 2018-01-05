//
//  HomePageHttpTool.h
//  me
//
//  Created by jam on 2018/1/5.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "ZZHttpTool.h"

#import "ProductModel.h"
#import "BannerModel.h"

@interface HomePageHttpTool : ZZHttpTool

+(void)getHomePageDatasCache:(BOOL)cache token:(NSString*)token success:(void(^)(NSArray* banners, NSArray* collections, NSArray* productSections))success failure:(void(^)(NSError* error))failure;

@end
