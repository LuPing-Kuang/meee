//
//  ZZHttpTool.m
//  yangsheng
//
//  Created by jam on 17/7/6.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "ZZHttpTool.h"
//#import "Reachability.h"

@implementation ZZHttpTool

+(NSInteger)pagesize
{
    return 30;
}

+(NSMutableDictionary*)pageParams
{
    NSMutableDictionary* d=[NSMutableDictionary dictionary];
    [d setValue:@"1" forKey:@"page"];
    [d setValue:[NSNumber numberWithInteger:[self pagesize]] forKey:@"pagesize"];
    return d;
}

+(NSMutableDictionary*)pageParamsWithPage:(NSInteger)page size:(NSInteger)size
{
    NSMutableDictionary* d=[NSMutableDictionary dictionary];
    [d setValue:[NSNumber numberWithInteger:page] forKey:@"page"];
    [d setValue:[NSNumber numberWithInteger:size] forKey:@"pagesize"];
    return d;
}

+(void)get:(NSString *)url params:(NSDictionary *)params usingCache:(BOOL)isCache success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure
{
    [self requestMethod:@"GET" url:url params:params usingCache:isCache success:success failure:failure];
}

+(void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure
{
    [self requestMethod:@"POST" url:url params:params usingCache:NO success:success failure:failure];
}

+(void)requestMethod:(NSString*)method url:(NSString *)url params:(NSDictionary *)params usingCache:(BOOL)isCache success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure
{
//    if (![Reachability reachabilityWithHostName:[ZZUrlTool main]]) {
//        if (failure) {
//            failure([NSError errorWithDomain:@"" code:404 userInfo:nil]);
//        }
//    }
    BOOL isGet=[method isEqualToString:@"GET"];
    BOOL isPost=[method isEqualToString:@"POST"];
    
    NSLog(@"%@",method);
    NSLog(@"%@",url);
    NSLog(@"%@",params);
    if (isGet||isPost) {
        
//        NSString* suburl=[url stringByReplacingOccurrencesOfString:[ZZUrlTool main] withString:@"main/"];
//        NSString* getorpost=[NSString stringWithFormat:@"%@:%@",method,suburl];
//        [MobClick event:@"getorpost" attributes:[NSDictionary dictionaryWithObject:getorpost forKey:@"method:url"]];
        if(params)
        {
            NSMutableDictionary* pararara=[NSMutableDictionary dictionaryWithDictionary:params];
            [pararara setValue:@"1" forKey:@"ios"];
            params=pararara;
        }
        NSArray* keys=[params allKeys];
        NSMutableArray* keysAndValues=[NSMutableArray array];
        for (NSString* key in keys) {
            NSString* value=[params valueForKey:key];
//            if([value isKindOfClass:[NSString class]])
//            {
////                value=[self encodeURL:value];
//                value=[value stringByAddingPercentEncodingWithAllowedCharacters:[[NSCharacterSet URLFragmentAllowedCharacterSet]invertedSet]];
//            }
            NSString* kv=[NSString stringWithFormat:@"%@=%@",key,value];
            [keysAndValues addObject:kv];
        }
        
        NSString* body=[keysAndValues componentsJoinedByString:@"&"];
//        body=[body stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
//        NSLog(@"HTTPBODY:%@",body);
        
        if (isGet&&body.length>0) {
            if ([url containsString:@"?"]) {
                url=[NSString stringWithFormat:@"%@&%@",url,body];
            }
            else
            {
                url=[NSString stringWithFormat:@"%@?%@",url,body];
            }
//            url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            url=[url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
        }
        
        NSURL* _ur=[NSURL URLWithString:url];
        
        NSMutableURLRequest* request=[NSMutableURLRequest requestWithURL:_ur];
        request.HTTPMethod=method;
        
        if (isPost) {
//            body=[body stringByReplacingOccurrencesOfString:@"&" withString:]
            request.HTTPBody=[body dataUsingEncoding:NSUTF8StringEncoding];
        }
        
        if (isGet) {
//            [cache setMemoryCapacity:2048];
//            [cache setDiskCapacity:20480];
            
            request.cachePolicy=isCache?NSURLRequestReturnCacheDataElseLoad:NSURLRequestReloadIgnoringLocalCacheData;
            
            if (isCache) {
                NSURLCache* cache=[NSURLCache sharedURLCache];
                NSCachedURLResponse* cacheResp=[cache cachedResponseForRequest:request];
                NSData* cachedData=cacheResp.data;
                if (cachedData) {
                    
                    NSDictionary* cachedDict=[ZZHttpTool dictionaryWithResponseData:cacheResp.data];
                    if ([cachedDict[@"code"] integerValue]==0) {
                        success(cachedDict);
                    }else{
                        
                        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:cachedDict[@"message"]                                                                      forKey:NSLocalizedDescriptionKey];
                        
                        
                        NSError *error = [NSError errorWithDomain:@"com.bangju.ewei" code:-1000 userInfo:userInfo];
                        
                        failure(error);
                        
                        if ([[NSString stringWithFormat:@"%@",cachedDict[@"code"]] isEqualToString:@"130"] && [cachedDict[@"message"] isEqualToString:@"登录已失效，请重新登录！"]) {
                            [[NSNotificationCenter defaultCenter] postNotificationName:UserNeed_Login_Notification object:nil];
                        }
                        
                    }
                    return;
                }
            }
        }
        
        NSURLSession* session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        NSURLSessionDataTask* dataTast=[session dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
//            NSLog(@"data:\n%@",data);
//            NSLog(@"resp:\n%@",response);
//            NSLog(@"erro:\n%@",error);
            
            NSLog(@"%@",response);
            
            [session finishTasksAndInvalidate];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if([response isKindOfClass:[NSHTTPURLResponse class]])
                {
                    NSHTTPURLResponse* httpRs=(NSHTTPURLResponse*)response;
                    if (httpRs.statusCode!=200) {
                        if (failure) {
                            failure(error);
                            
                        }
                        
                        //                    [dataTast cancel];
                        return;
                    }
                }
                if (data) {
                    if (success) {
                        NSDictionary* result=[ZZHttpTool dictionaryWithResponseData:data];
                        if ([result[@"code"] integerValue]==0) {
                            success(result);
                        }else{
                            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:result[@"message"]                                                                      forKey:NSLocalizedDescriptionKey];
                            
                            NSError *error = [NSError errorWithDomain:@"com.bangju.ewei" code:-1000 userInfo:userInfo];
                            
                            failure(error);
                            
                            if ([[NSString stringWithFormat:@"%@",result[@"code"]] isEqualToString:@"130"] && [result[@"message"] isEqualToString:@"登录已失效，请重新登录！"]) {
                                [[NSNotificationCenter defaultCenter] postNotificationName:UserNeed_Login_Notification object:nil];
                            }
                        }
                        
                        
                        
                    }
//                    [dataTast cancel];
                    return;
                }
                else if(error)
                {
                    if (failure) {
                        failure(error);
                        
                    }
                    
//                    [dataTast cancel];
                    return;
                }
                if (failure) {
                    failure(error);
                }
//                [dataTast cancel];
                return;
            });
            
        }];
        [dataTast resume];
    }
}

//3rd method, came from stackoverflow.com
+(void)uploadImage:(NSData *)imageData url:(NSString*)url params:(NSDictionary *)params success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure
{
    NSURL* _ur=[NSURL URLWithString:url];
    
    // Dictionary that holds post parameters. You can set your post parameters that your server accepts or programmed to accept.
    NSMutableDictionary* _params = [NSMutableDictionary dictionaryWithDictionary:params];
    // the boundary string : a random string, that will not repeat in post data, to separate post data fields.
    NSString *BoundaryConstant = [NSString stringWithFormat:@"----------V2ymH3ehbqg%ldZCaKO6jy",(long)arc4random()%100];
    
    // string constant for the post parameter 'file'. My server uses this name: `file`. Your's may differ
    NSString* FileParamConstant = @"img";
    
    // the server url to which the image (or the media) is uploaded. Use your server url here
    NSURL* requestURL = _ur;
    
    // create request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:@"POST"];
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", BoundaryConstant];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    // add params (all params are strings)
    for (NSString *param in _params) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", param] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", [_params objectForKey:param]] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    // add image data
//    CGSize size=CGSizeMake(200,200);
//    UIGraphicsBeginImageContext(CGSizeMake(size.width,size.height));
//    [avatar drawInRect:CGRectMake(0, 0, size.width, size.height)];
//    
//    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    NSData *imageData = UIImageJPEGRepresentation(scaledImage, 0.8);\
    
    if (imageData) {
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image.jpg\"\r\n", FileParamConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%ld",(long) [body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    // set URL
    [request setURL:requestURL];
    NSURLSession* session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask* dataTast=[session dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
        //            NSLog(@"data:\n%@",data);
        //            NSLog(@"resp:\n%@",response);
        //            NSLog(@"erro:\n%@",error);
        [session finishTasksAndInvalidate];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary* result=[self dictionaryWithResponseData:data];
//                NSString* d=[result valueForKey:@"data"];
                if (success) {
                    success(result);
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
        });
        
    }];
    [dataTast resume];
}

+(NSDictionary*)dictionaryWithResponseData:(NSData*)data
{
    NSDictionary* nilDictionary=[NSDictionary dictionary];
    if (!data) {
        return nilDictionary;
    }
    NSString *receiveStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    if (receiveStr.length==0) {
        NSLog(@"get null data");
        return nilDictionary;
    }
//    receiveStr=[receiveStr stringByReplacingOccurrencesOfString:@"null" withString:@"nil"];//／／{\"zzz\":\"nillllll!\"}"];
    NSData * data2 = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary* result=[NSJSONSerialization JSONObjectWithData:data2 options:NSJSONReadingMutableLeaves error:nil];
    result=AFJSONObjectByRemovingKeysWithNullValues(result, NSJSONReadingMutableLeaves);
    if(result==nil)
    {
        NSLog(@"get null dictionary");//why nil??
        result=nilDictionary;
    }
    
    //remove useless "data"
    
    NSMutableDictionary* mutaRes=[NSMutableDictionary dictionaryWithDictionary:result];
    
//    id d=[result valueForKey:@"data"];
//    
//    if ([d isKindOfClass:[NSNumber class]]) {
//        NSLog(@"get zero data");
//        [mutaRes removeObjectForKey:@"data"];
//    }
//    if ([d respondsToSelector:@selector(count)]) {
//        NSInteger count=[d count];
//        if (count==0) {
//            [mutaRes removeObjectForKey:@"data"];
//        }
//    }
    
    NSLog(@"%@",mutaRes);
    return mutaRes;
}

//encode
//+(NSString*)encodeURL:(NSString *)string
//{
////    NSString *newString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)string, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8));
//    
//    NSString* newString=[string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
//    if (newString) {
//        return newString;
//    }
//    return @"";
//}

//writen by afnetworking , i dont know
static id AFJSONObjectByRemovingKeysWithNullValues(id JSONObject, NSJSONReadingOptions readingOptions) {
    if ([JSONObject isKindOfClass:[NSArray class]]) {
        NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:[(NSArray *)JSONObject count]];
        for (id value in (NSArray *)JSONObject) {
            [mutableArray addObject:AFJSONObjectByRemovingKeysWithNullValues(value, readingOptions)];
        }
        if(((NSArray*)JSONObject).count==0)
        {
            return nil;
        }
        return (readingOptions & NSJSONReadingMutableContainers) ? mutableArray : [NSArray arrayWithArray:mutableArray];
    } else if ([JSONObject isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionaryWithDictionary:JSONObject];
        for (id <NSCopying> key in [(NSDictionary *)JSONObject allKeys]) {
            id value = (NSDictionary *)JSONObject[key];
            if (!value || [value isEqual:[NSNull null]]) {
                [mutableDictionary removeObjectForKey:key];
            } else if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]]) {
                mutableDictionary[key] = AFJSONObjectByRemovingKeysWithNullValues(value, readingOptions);
            }
        }
        if(((NSDictionary*)JSONObject).count==0)
        {
            return nil;
        }
        return (readingOptions & NSJSONReadingMutableContainers) ? mutableDictionary : [NSDictionary dictionaryWithDictionary:mutableDictionary];
    }
    
    return JSONObject;
}

@end

