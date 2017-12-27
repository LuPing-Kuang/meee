//
//  ZZWebImageTool.m
//  ZZWebImage
//
//  Created by jam on 17-12-9.
//  Copyright (c) 2017年 jam. All rights reserved.
//

#import "ZZWebImageTool.h"

//static NSMutableDictionary* sharedCachedImageDictionary;

@implementation ZZWebImageTool

+(void)getImageFromUrl:(NSString *)url success:(void (^)(UIImage *, NSError *))success
{
//    if (sharedCachedImageDictionary==nil) {
//        sharedCachedImageDictionary=[NSMutableDictionary dictionary];
//    }
//    UIImage* cache=[sharedCachedImageDictionary valueForKey:url];
//    if (cache) {
//        if (success) {
//            success(cache,nil);
//        }
//        return;
//    }
    
    [self requestUrl:url success:^(NSData *data) {
        UIImage* img=[UIImage imageWithData:data];
        
//        [sharedCachedImageDictionary setValue:img forKey:url];
        
        if (success) {
            success(img,nil);
        }
    } failure:^(NSError *error) {
        if (success) {
            success(nil,error);
        }
    }];
}

+(void)requestUrl:(NSString *)url success:(void (^)(NSData* successData))success failure:(void (^)(NSError *failureError))failure
{
    NSURL* _ur=[NSURL URLWithString:url];
    
    NSMutableURLRequest* request=[NSMutableURLRequest requestWithURL:_ur];
    request.HTTPMethod=@"GET";

    request.cachePolicy=NSURLRequestReturnCacheDataElseLoad;
    
    NSURLCache* cache=[NSURLCache sharedURLCache];
    [cache setDiskCapacity:512*1024*1024];
    NSCachedURLResponse* cacheResp=[cache cachedResponseForRequest:request];
    NSData* cachedData=cacheResp.data;
    if (cachedData) {
        
        if (success) {
            success(cachedData);
        }
        return;
    }
    
    NSURLSession* session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask* dataTast=[session dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
        
        [session finishTasksAndInvalidate];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                [cache storeCachedResponse:[[NSCachedURLResponse alloc]initWithResponse:response data:data] forRequest:request];
                if (success) {
                    success(data);
                }
                return;
            }
            else if(error)
            {
                if (failure) {
                    failure(error);
                }
                return;
            }
            if (failure) {
                failure(error);
            }
            return;
        });
    }];
    [dataTast resume];

}

@end
