//
//  UIImageView+ZZWebImage.h
//  ZZWebImage
//
//  Created by jam on 17-12-9.
//  Copyright (c) 2017年 jam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZZWebImageTool.h"

@interface UIImageView (ZZWebImage)

@property (nonatomic,strong) NSString* webImageUrl;

-(void)setImageUrl:(NSString*)url;

-(void)setImageUrl:(NSString *)url placeHolder:(UIImage*)placeHolder;

-(void)setImageUrl:(NSString *)url placeHolder:(UIImage *)placeHolder completed:(void(^)(UIImage* image, NSError* error, NSString* imageUrl))completion;

@end
