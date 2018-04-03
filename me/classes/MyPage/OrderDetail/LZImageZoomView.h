//
//  LZImageZoomView.h
//  imageDemo
//
//  Created by URoad_MP on 15/5/12.
//  Copyright (c) 2015年 future. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZImageZoomView : UIView

- (id)initWithFrame:(CGRect)frame byUrlString:(NSString *)urlString;

- (id)initWithFrame:(CGRect)frame byImage:(UIImage *)img;

- (void)loadImage:(UIImage *)img;

@end
