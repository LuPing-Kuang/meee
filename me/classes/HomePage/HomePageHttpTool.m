//
//  HomePageHttpTool.m
//  me
//
//  Created by jam on 2018/1/5.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "HomePageHttpTool.h"

@implementation HomePageHttpTool

+(void)getHomePageDatasCache:(BOOL)cache token:(NSString*)token success:(void(^)(NSArray* banners, NSArray* collections, NSArray* productSections))success failure:(void(^)(NSError* error))failure;
{
    NSString* str=[ZZUrlTool fullUrlWithTail:@"/app/index.php?i=1&c=entry&m=ewei_shopv2&do=api"];
    NSDictionary* paar=nil;
    if (token.length>0) {
        paar=[NSDictionary dictionaryWithObject:token forKey:@"access_token"];
    }
    
    [self get:str params:paar usingCache:cache success:^(NSDictionary *dict) {
        NSDictionary* data=[dict valueForKey:@"data"];
        NSDictionary* items=[data valueForKey:@"items"];
        
        
        NSMutableArray* banners=[NSMutableArray array];
        NSMutableArray* collections=[NSMutableArray array];
        NSMutableArray* productSections=[NSMutableArray array];
        
        ProductSection* lastMetSection=nil;
        for (NSString* key1 in items.allKeys) {
            NSDictionary* dic=[items valueForKey:key1];
            NSString* idd=[dic valueForKey:@"id"];
            NSDictionary* d2=[dic valueForKey:@"data"];
            
            if ([idd isEqualToString:@"banner"]&&banners.count==0) {
                for (NSDictionary* bad in d2.allValues) {
                    BannerModel* banm=[BannerModel yy_modelWithDictionary:bad];
                    [banners addObject:banm];
                }
            }
//            else if([idd isEqualToString:@"menu"])
//            {
//                for (NSDictionary* men in collection) {
//                    statements
//                }
//            }
            else if([idd isEqualToString:@"title"])
            {
                lastMetSection=[[ProductSection alloc]init];
                lastMetSection.title=[dic valueForKeyPath:@"params.title"];
            }
            else if([idd isEqualToString:@"goods"])
            {
                ProductSection* thisMeSection=lastMetSection;
                if (!thisMeSection) {
                    thisMeSection=[[ProductSection alloc]init];
                }
                NSString* liststyle=[dic valueForKeyPath:@"style.liststyle"];
                if ([liststyle respondsToSelector:@selector(length)]) {
                    if (liststyle.length==0) {
                        thisMeSection.style=ProductSectionStyleOne;
                    }
                    else
                    {
                        thisMeSection.style=ProductSectionStyleTwo;
                    }
                }
                
                NSMutableArray* goods=[NSMutableArray array];
                if ([d2 respondsToSelector:@selector(allKeys)]) {
                    for (NSString* key2 in d2.allKeys) {
                        NSDictionary* goo=[d2 valueForKey:key2];
                        ProductModel* prom=[ProductModel yy_modelWithDictionary:goo];
                        [goods addObject:prom];
                    }
                    thisMeSection.products=goods;
                    [productSections addObject:thisMeSection];
                }
                
            }
        }
        
        
        if (success) {
            success(banners,collections,productSections);
        }
    } failure:^(NSError *err) {
        if (failure) {
            failure(err);
        }
    }];
}

@end
