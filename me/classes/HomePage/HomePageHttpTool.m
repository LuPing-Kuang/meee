//
//  HomePageHttpTool.m
//  me
//
//  Created by jam on 2018/1/5.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "HomePageHttpTool.h"
#import "SimpleButtonsTableViewCell.h"

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
        NSArray* items=[data valueForKey:@"items"];
        
        
        NSMutableArray* banners=[NSMutableArray array];
        NSMutableArray* collections=[NSMutableArray array];
        NSMutableArray* productSections=[NSMutableArray array];
        
        ProductSection* lastMetSection=nil;
        for (NSDictionary* it in items) {
            NSString* idd=[it valueForKey:@"id"];
            NSArray* d2=[it valueForKey:@"data"];
            
            if ([idd isEqualToString:@"banner"]&&banners.count==0) {
                for (NSDictionary* bad in d2) {
                    BannerModel* banm=[BannerModel yy_modelWithDictionary:bad];
                    [banners addObject:banm];
                }
            }
            else if([idd isEqualToString:@"menu"])
            {
                for (NSDictionary* men in d2) {
                    NSString* text=[men valueForKey:@"text"];
                    NSString* imgurl=[men valueForKey:@"imgurl"];
                    NSString* linkurl=[men valueForKey:@"linkurl"];
                    SimpleButtonModel* btu=[[SimpleButtonModel alloc]initWithTitle:text imageName:imgurl identifier:linkurl type:0 badge:0];
                    [collections addObject:btu];
                }
            }
            else if([idd isEqualToString:@"title"])
            {
                lastMetSection=[[ProductSection alloc]init];
                lastMetSection.title=[it valueForKeyPath:@"params.title"];
            }
            else if([idd isEqualToString:@"goods"])
            {
                ProductSection* thisMeSection=lastMetSection;
                if (!thisMeSection) {
                    thisMeSection=[[ProductSection alloc]init];
                }
                NSString* liststyle=[it valueForKeyPath:@"style.liststyle"];
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
                if ([d2 respondsToSelector:@selector(firstObject)]) {
                    for (NSDictionary* goo in d2) {
                        ProductAdvModel* prom=[ProductAdvModel yy_modelWithDictionary:goo];
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
