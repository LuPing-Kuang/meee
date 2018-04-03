//
//  UIView+GaosutongExtension.h
//  LNGaosutong
//
//  Created by 罗 建镇 on 15/3/4.
//  Copyright (c) 2015年 URoad. All rights reserved.
//

#import <UIKit/UIKit.h>


#import <objc/runtime.h>

typedef enum {
    YooViewHorizontalAlginModeLeft=0,
    YooViewHorizontalAlginModeRight=1,
    YooViewHorizontalAlginModeNone=2
} YooViewHorizontalAlginMode;//

typedef enum {
    YooViewVerticalAlginModeTop=0,
    YooViewVerticalAlginModeBottom=1,
    YooViewVerticalAlginModeNone=2
} YooViewVerticalAlginMode;//



typedef enum {
    YooViewHorizontalAdjustModeAdjust=1,
    YooViewHorizontalAdjustModeNone=0
} YooViewHorizontalAdjustMode;//



typedef enum {
    YooViewVerticalAdjustModeAdjust=1,
    YooViewVerticalAdjustModeNone=0
} YooViewVerticalAdjustMode;//


@interface UIView (GaosutongExtension)

@property(assign) void(^tapAction)(UITapGestureRecognizer*);

@property(assign) void(^swipeLeftAction)(UISwipeGestureRecognizer*);
@property(assign) void(^swipeRightAction)(UISwipeGestureRecognizer*);
@property(assign) void(^swipeUpAction)(UISwipeGestureRecognizer*);
@property(assign) void(^swipeDownAction)(UISwipeGestureRecognizer*);






@property (assign)float left_gst;
@property (assign)float top_gst;
@property (assign)float width_gst;
@property (assign)float height_gst;
@property(assign,setter=setTop_:,getter=top_)float top;

@property(assign)CGSize size;
@property(assign)CGPoint origin;

@property(assign)YooViewHorizontalAlginMode horizontalAlignMode;
@property(assign)YooViewVerticalAlginMode verticalAlignMode;
@property(assign)YooViewHorizontalAdjustMode horizontalAdjustMode;
@property(assign)YooViewVerticalAdjustMode verticalAdjustMode;




-(void)setFullAdjust;

-(void)addSubviewAtCenter:(UIView *)view;


@end
