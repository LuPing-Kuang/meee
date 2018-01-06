//
//  MenuHeaderTableViewCell.m
//  zhanmao
//
//  Created by bangju on 2017/10/23.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "MenuHeaderTableViewCell.h"

@implementation MenuHeaderButtonModel

+(instancetype)modelWithTitle:(NSString *)title selected:(BOOL)selected ordered:(BOOL)ordered ascending:(BOOL)ascending ascendingString:(NSString*)ascendingString descendingString:(NSString*)descendingString imageName:(NSString *)imageName alone:(BOOL)alone
{
    MenuHeaderButtonModel* m=[[MenuHeaderButtonModel alloc]init];
    m.title=title;
    m.selected=selected;
    m.ordered=ordered;
    m.ascending=ascending;
    m.ascendingString=ascendingString;
    m.descendingString=descendingString;
    m.imageName=imageName;
    m.alone=alone;
    return m;
}

-(NSString*)sortString
{
    if (self.selected) {
        if (self.ordered==NO) {
            return self.descendingString;
        }
        else
        {
            if (self.ascending) {
                return self.ascendingString;
            }
            else
            {
                return self.descendingString;
            }
        }
    }
    return @"";
}

@end

@interface MenuHeaderTableViewCell()

@property (nonatomic,strong) UIView* bottomSeperateLine;

@end

@implementation MenuHeaderTableViewCell

-(void)setButtonModelArray:(NSArray<MenuHeaderButtonModel *> *)buttonModelArray
{
    _buttonModelArray=buttonModelArray;
    
    [self removeAllSubviews];
    
//    self.backgroundColor=[UIColor whiteColor];
//    self.backgroundColor=[UIColor whiteColor];
    if (buttonModelArray.count<=0) {
        return;
    }
    CGFloat bw=self.frame.size.width/buttonModelArray.count;
    CGFloat bh=32;
    CGFloat imgW=10;
    CGFloat imgH=imgW;
    for (NSInteger i=0; i<buttonModelArray.count; i++) {
        MenuHeaderButtonModel* model=[buttonModelArray objectAtIndex:i];
        
        UIView* bg=[[UIView alloc]initWithFrame:CGRectMake(0, 0, bw, bh)];
        [self addSubview:bg];
        
        UILabel* ti=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, bw-imgW, bh)];
        ti.text=model.title;
        ti.font=[UIFont systemFontOfSize:15];
//        ti.textColor=[UIColor darkGrayColor];
        ti.textColor=gray_2;
        ti.textAlignment=NSTextAlignmentCenter;
        [bg addSubview:ti];
        
        UILabel* upImg=[[UILabel alloc]initWithFrame:CGRectMake(bw-imgW-12, bh/2-imgH+1, imgW, imgH)];
        upImg.text=@"▲";
        upImg.textColor=gray_6;
        upImg.font=[UIFont systemFontOfSize:9];
        upImg.textAlignment=NSTextAlignmentCenter;
        [bg addSubview:upImg];
        
        UILabel* doImg=[[UILabel alloc]initWithFrame:CGRectMake(upImg.frame.origin.x, bh/2-1, imgW, imgH)];
        doImg.text=@"▼";
        doImg.textColor=gray_6;
        doImg.font=[UIFont systemFontOfSize:9];
        doImg.textAlignment=NSTextAlignmentCenter;
        [bg addSubview:doImg];
        
        UIImageView* rightImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:model.imageName]];
        rightImage.center=CGPointMake(bw-imgW-8, bh/2);
        [bg addSubview:rightImage];
        
        UIView* line=[[UIView alloc]initWithFrame:CGRectMake(bw, 4, 1, bh-8)];
        line.backgroundColor=gray_8;
        [bg addSubview:line];
        
        if (model.ordered==NO) {
            ti.frame=bg.bounds;
            upImg.hidden=YES;
            doImg.hidden=YES;
        }
        if (rightImage.image) {
            ti.frame=CGRectMake(0, 0, bw-imgW, bh);
        }
        if (model.selected) {
            ti.textColor=_mainColor;
            if (model.ascending) {
                upImg.textColor=_mainColor;
            }
            else
            {
                doImg.textColor=_mainColor;
            }
            rightImage.image=[rightImage.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            rightImage.tintColor=_mainColor;
        }
        
        UIButton* btn=[[UIButton alloc]initWithFrame:bg.bounds];
        btn.tag=i;
        [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [bg addSubview:btn];
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

-(void)buttonClicked:(UIButton*)button
{
    NSInteger tag=button.tag;
    MenuHeaderButtonModel* mo=[self.buttonModelArray objectAtIndex:tag];
    BOOL oldSelected=mo.selected;
    if(!mo.alone)
    {
        for (MenuHeaderButtonModel* m in self.buttonModelArray) {
            if (m.alone) {
                break;
            }
            m.selected=NO;
        }
    }
    
    mo.selected=YES;
    if (mo.ordered) {
        mo.ascending=!mo.ascending;
        if (oldSelected==NO) {
            mo.ascending=YES;
        }
    }
    self.buttonModelArray=self.buttonModelArray;
    if ([self.delegate respondsToSelector:@selector(menuHeaderTableViewCell:didChangeModels:)]) {
        [self.delegate menuHeaderTableViewCell:self didChangeModels:self.buttonModelArray];
    }
}

-(UIView*)bottomSeperateLine
{
    if(_bottomSeperateLine==nil)
    {
        _bottomSeperateLine=[[UIView alloc]initWithFrame:CGRectZero];
        _bottomSeperateLine.backgroundColor=gray_8;
        [self addSubview:_bottomSeperateLine];
    }
    return _bottomSeperateLine;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat w=[self frame].size.width;
    CGFloat wp=w/self.buttonModelArray.count;
    CGFloat h=[self frame].size.height;
    
    for (NSInteger i=0;i<self.subviews.count;i++) {
        UIView* view=[self.subviews objectAtIndex:i];
        view.frame=CGRectMake(wp/2+(wp*i)-view.frame.size.width/2, h/2-view.frame.size.height/2, view.frame.size.width, view.frame.size.height);
    }
    CGFloat he=1/[[UIScreen mainScreen]scale];
    self.bottomSeperateLine.frame=CGRectMake(0, self.bounds.size.height-he, self.bounds.size.width, he);
}

@end
