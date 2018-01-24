//
//  UIView+Meee.h
//  me
//
//  Created by KLP on 2018/1/22.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Meee)

@property(assign) void(^tapAction)(UITapGestureRecognizer*tap);

-(void)addRoundlineWithColor:(UIColor *)color andWidth:(CGFloat)width;

-(void)addDefaultShadow;

@end
