//
//  ZZWebImageTool.h
//  ZZWebImage
//
//  Created by jam on 17-12-9.
//  Copyright (c) 2017年 jam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZZWebImageTool : NSObject

+(void)getImageFromUrl:(NSString*)url success:(void(^)(UIImage* image, NSError* error))success;

@end
