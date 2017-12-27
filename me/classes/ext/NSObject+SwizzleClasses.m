//
//  NSObject+SwizzleClasses.m
//  yangsheng
//
//  Created by Macx on 2017/8/22.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "NSObject+SwizzleClasses.h"

//#import "UIImageView+WebCache.h"

@implementation NSObject (SwizzleClasses)

@end

@implementation UITableView(SwizzleClasses)

+(void)load
{
    NSLog(@"UITableView Class Load");
    NSLog(@"swizzle reloaddata");
    [[self class]jr_swizzleMethod:@selector(reloadData) withMethod:@selector(myReloadData) error:nil];
}

-(void)myReloadData
{
    NSDictionary* dic=[NSDictionary dictionaryWithObject:self forKey:@"tableView"];
    [[NSNotificationCenter defaultCenter]postNotificationName:UITableViewReloadDataNotification object:nil userInfo:dic];
    [self myReloadData];
    self.separatorColor=gray_8;
    self.showsVerticalScrollIndicator=NO;
}

@end

@implementation UICollectionView(SwizzleClasses)

+(void)load
{
    NSLog(@"UICollectionView Class Load");
    NSLog(@"swizzle reloadsections");
    [[self class]jr_swizzleMethod:@selector(reloadSections:) withMethod:@selector(myReloadSections:) error:nil];
    
    [[self class]jr_swizzleMethod:@selector(reloadData) withMethod:@selector(myReloadData) error:nil];

    
}

-(void)myReloadSections:(NSIndexSet*)sections
{
    NSDictionary* dic=[NSDictionary dictionaryWithObject:self forKey:@"collectionView"];
    [[NSNotificationCenter defaultCenter]postNotificationName:UICollectionViewReloadSectionsNotification object:nil userInfo:dic];
    [self myReloadSections:sections];
}

-(void)myReloadData
{
    NSDictionary* dic=[NSDictionary dictionaryWithObject:self forKey:@"collectionView"];
    [[NSNotificationCenter defaultCenter]postNotificationName:UICollectionViewReloadSectionsNotification object:nil userInfo:dic];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self myReloadData];
    });
}

@end

@implementation UIImageView(SwizzleClasses)

+(void)load
{
    NSLog(@"UIImageView Class Load");
    NSLog(@"swizzle sd_setImageWithURL");
    [[self class]jr_swizzleMethod:@selector(sd_setImageWithURL:) withMethod:@selector(my_sd_setImageWithURL:) error:nil];
}

-(void)my_sd_setImageWithURL:(NSURL*)url
{
//    NSString* urlstr=[url absoluteString];
//    NSLog(@"load image: %@",urlstr);
    UIImage* defaultImage=[UIImage imageNamed:@"image_loading"];
    //    CGFloat rate=self.frame.size.width/self.frame.size.height;
    //    if (rate>1.5) {
    //        defaultImage=[UIImage imageNamed:@"default_16_9"];
    //    }
    //    else if(rate<0.75){
    //        defaultImage=[UIImage imageNamed:@"default_9_16"];
    //    }
    [self sd_setImageWithURL:url placeholderImage:defaultImage];
}

@end

@implementation UIScrollView(SwizzleClasses)



@end

