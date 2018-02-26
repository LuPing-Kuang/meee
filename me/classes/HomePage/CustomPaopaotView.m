//
//  CustomPaopaotView.m
//  me
//
//  Created by KLP on 2018/2/7.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "CustomPaopaotView.h"

#define kPortraitMargin     5
#define kPortraitWidth      70
#define kPortraitHeight     50
#define kTitleHeight        20
#define kArrorHeight        10

@interface CustomPaopaotView()

@property (nonatomic, strong) UILabel *subtitleLabel;  //地址
@property (nonatomic, strong) UILabel *titleLabel;  //商户名


@end

@implementation CustomPaopaotView


#pragma mark - draw rect

- (void)drawRect:(CGRect)rect
{
    [self drawInContext:UIGraphicsGetCurrentContext()];
    
}

- (void)drawInContext:(CGContextRef)context
{
    CGContextSetLineWidth(context, 2.0);
    CGContextSetFillColorWithColor(context, _redColor.CGColor);
    
    [self getDrawPath:context];
    CGContextFillPath(context);
}
- (void)getDrawPath:(CGContextRef)context
{
    CGRect rrect = self.bounds;
    CGFloat radius = 6.0;
    CGFloat minx = CGRectGetMinX(rrect),
    midx = CGRectGetMidX(rrect),
    maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect),
    maxy = CGRectGetMaxY(rrect)-kArrorHeight;
    
    CGContextMoveToPoint(context, midx+kArrorHeight, maxy);
    CGContextAddLineToPoint(context,midx, maxy+kArrorHeight);
    CGContextAddLineToPoint(context,midx-kArrorHeight, maxy);
    
    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
    CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextClosePath(context);
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)setTitleArr:(NSArray *)titleArr{
    _titleArr = titleArr;
    // 添加标题，即商户名
    
    UIFont *font15 = [UIFont systemFontOfSize:15];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kPortraitMargin, kPortraitMargin, self.bounds.size.width - kPortraitMargin * 2, kTitleHeight)];
    self.titleLabel.font = font15;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.text = _titleArr.firstObject;
    [self addSubview:self.titleLabel];
    
    // 添加副标题，即商户地址
    self.subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kPortraitMargin, kPortraitMargin + CGRectGetMaxY(self.titleLabel.frame), self.bounds.size.width - kPortraitMargin * 2, kTitleHeight)];
    
    self.subtitleLabel.font = font15;
    self.subtitleLabel.textColor = [UIColor whiteColor];
    self.subtitleLabel.text = _titleArr.lastObject;
    [self addSubview:self.subtitleLabel];
}






@end
