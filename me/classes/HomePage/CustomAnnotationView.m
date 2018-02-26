//
//  CustomAnnotationView.m
//  me
//
//  Created by KLP on 2018/2/7.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "CustomAnnotationView.h"

#define kCalloutHeight  65


@interface CustomAnnotationView()

@property (nonatomic, strong, readwrite) CustomPaopaotView *MypaopaoView;


@end

@implementation CustomAnnotationView

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{

    
    if (selected)
    {
        if (self.MypaopaoView == nil)
        {
            
            /* Construct custom callout. */
            
            UIFont *font15 = [UIFont systemFontOfSize:15];
            
            CGFloat titlekCalloutWidth = [self.annotation.title sizeWithFont:font15 maxSize:CGSizeMake(MAXFLOAT, 20)].width + 2*5;
            CGFloat subtitlekCalloutWidth = [self.annotation.subtitle sizeWithFont:font15 maxSize:CGSizeMake(MAXFLOAT, 20)].width + 2*5;
            CGFloat maxWidth = 0;
            
            if (titlekCalloutWidth>subtitlekCalloutWidth) {
                maxWidth = titlekCalloutWidth;
            }else{
                maxWidth = subtitlekCalloutWidth;
            }
            
            if (maxWidth>UIScreenWidth-20) {
                maxWidth = UIScreenWidth - 20;
            }
            
            
            self.MypaopaoView = [[CustomPaopaotView alloc] initWithFrame:CGRectMake(0, 0, maxWidth, kCalloutHeight)];
            self.MypaopaoView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
                                                 -CGRectGetHeight(self.MypaopaoView.bounds) / 2.f + self.calloutOffset.y);
            
            
            NSString *title = self.annotation.title==nil?@"":self.annotation.title;
            NSString *subtitle = self.annotation.subtitle==nil?@"":self.annotation.subtitle;
            NSArray *titleArr = @[title,subtitle];
            
            self.MypaopaoView.titleArr = titleArr;
        }
        
        [self addSubview:self.MypaopaoView];
        
    }
    else
    {
        [self.MypaopaoView removeFromSuperview];
    
    }
    
    [super setSelected:selected animated:animated];
}


@end
