//
//  ZZStepper.m
//  zhanmao
//
//  Created by bangju on 2017/10/25.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "ZZStepper.h"

@implementation ZZStepper
{
    UIButton* addButton;
    UIButton* subButton;
    UILabel* valueLabel;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self config];
}

-(void)config
{
    self.backgroundColor=[UIColor clearColor];
    
    CGSize siz=self.bounds.size;
    CGFloat w=siz.width;
    CGFloat h=siz.height;
    
    CGFloat radius=2;
    CGFloat margin=1;
    UIColor* bgColor=gray_9;
    UIColor* textColor=gray_2;
    UIColor* disableColor=gray_6;
    
    subButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, h, h)];
    subButton.backgroundColor=bgColor;
    [subButton setTitle:@"-" forState:UIControlStateNormal];
    [subButton setTitleColor:textColor forState:UIControlStateNormal];
    [subButton setTitleColor:disableColor forState:UIControlStateDisabled];
    [subButton addTarget:self action:@selector(sub) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:subButton];
    
    addButton=[[UIButton alloc]initWithFrame:CGRectMake(w-h, 0, h, h)];
    addButton.backgroundColor=bgColor;
    [addButton setTitle:@"+" forState:UIControlStateNormal];
    [addButton setTitleColor:textColor forState:UIControlStateNormal];
    [addButton setTitleColor:disableColor forState:UIControlStateDisabled];
    [addButton addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addButton];
    
    CGFloat titleW=w-h-h-margin-margin;
    if (titleW>0) {
        valueLabel=[[UILabel alloc]initWithFrame:CGRectMake(h+margin, 0, titleW, h)];
        valueLabel.text=@"1";
        valueLabel.backgroundColor=bgColor;
        valueLabel.textAlignment=NSTextAlignmentCenter;
        valueLabel.textColor=textColor;
        [self addSubview:valueLabel];
    }
    
    for (UIView* view in self.subviews) {
        view.layer.cornerRadius=radius;
        view.layer.masksToBounds=YES;
    }
    
    self.stepper=1;
    self.value=1;
    self.min=1;
    self.max=0;
}

-(void)setValue:(NSInteger)value
{
    if ((value<=self.max||self.max==0)&&value>=self.min) {
        _value=value;
        valueLabel.text=[NSString stringWithFormat:@"%ld",(long)value];
    }
    [self performSelector:@selector(configurButtonEnable) withObject:nil afterDelay:0.02];
}

-(void)configurButtonEnable
{
    subButton.enabled=self.value>self.min;
    addButton.enabled=self.value<self.max;
}

-(void)add
{
    NSInteger old=self.value;
    self.value=old+self.stepper;
    if (self.value!=old) {
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

-(void)sub
{
    NSInteger old=self.value;
    self.value=old-self.stepper;
    if (self.value!=old) {
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

@end
