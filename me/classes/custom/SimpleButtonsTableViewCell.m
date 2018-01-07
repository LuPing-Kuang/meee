//
//  SimpleButtonsTableViewCell.m
//  zhanmao
//
//  Created by bangju on 2017/10/16.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "SimpleButtonsTableViewCell.h"

const CGFloat simpleButtonMarginY=17;
const CGFloat simpleButtonImageHeight=40;
const CGFloat simpleButtonTitleHeight=15;
const CGFloat simpleButtonImageTitleMarginY=12;
const CGFloat simpleButtonHeight=simpleButtonImageTitleMarginY+simpleButtonImageHeight+simpleButtonTitleHeight;
const CGFloat simpleButtonWidth=74;
const NSInteger simpleButtonRowCount=4;

@interface SimpleButtonsTableViewCell()

@property (nonatomic,weak) UIView* contentView;

@end

@implementation SimpleButtonsTableViewCell

-(UIView*)contentView
{
    return self;
}

+(CGFloat)heightWithButtonsCount:(NSInteger)count
{
    if(count==0)
    {
        return 1;
    }
    NSInteger rows=count/simpleButtonRowCount;
    if (count%simpleButtonRowCount>0) {
        rows=rows+1;
    }
    CGFloat he=(simpleButtonHeight+simpleButtonMarginY)*rows+simpleButtonMarginY;
    return he;
}

-(void)setButtons:(NSArray<SimpleButtonModel *> *)buttons
{
    _buttons=buttons;
    [self.contentView removeAllSubviews];
    self.backgroundColor=[UIColor clearColor];
    self.contentView.backgroundColor=[UIColor clearColor];
    
    CGFloat widthPerEach=simpleButtonWidth;
    CGFloat heightPerEach=simpleButtonHeight;
//    CGFloat height_2=heightPerEach/2;
    
    CGFloat titleHeight=simpleButtonTitleHeight;
    CGFloat imageHeight=simpleButtonImageHeight;
    
    NSInteger counts=buttons.count;
    for (NSInteger i=0; i<counts; i++) {
        NSInteger row=i/simpleButtonRowCount;
        SimpleButtonModel* mo=[buttons objectAtIndex:i];
//        NSLog(@"%ld,%ld",col,row);
        
        UIView* bbg=[[UIView alloc]initWithFrame:CGRectMake(0, row*(heightPerEach+simpleButtonMarginY)+simpleButtonMarginY, widthPerEach, heightPerEach)];
//        bbg.backgroundColor=_randomColor;
        [self.contentView addSubview:bbg];
        
        UILabel* titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, heightPerEach-titleHeight, widthPerEach, titleHeight)];
        titleLabel.textAlignment=NSTextAlignmentCenter;
        titleLabel.textColor=gray_2;
        if (mo.titleColor) {
            titleLabel.textColor=mo.titleColor;
        }
        titleLabel.font=[UIFont systemFontOfSize:12];
        titleLabel.text=mo.title;
        [bbg addSubview:titleLabel];
        
        UIImageView* imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, widthPerEach, imageHeight)];
        UIImage* img=[UIImage imageNamed:mo.imageName];
//        imageView.backgroundColor=_randomColor;
        imageView.contentMode=UIViewContentModeCenter;
        imageView.image=img;
        imageView.clipsToBounds=YES;
        [bbg addSubview:imageView];
        
        if(!img)
        {
            [imageView setImageUrl:mo.imageName];
            imageView.contentMode=UIViewContentModeScaleAspectFit;
        }
        
        if (mo.circledImage) {
            CGFloat w=imageHeight+12;
            UIView* circle=[[UIView alloc]initWithFrame:CGRectMake(0, 0, w,w)];
            circle.backgroundColor=rgb(86,133,229);
            circle.layer.cornerRadius=circle.frame.size.width/2;
            circle.center=imageView.center;
            if (mo.circleColor) {
                circle.backgroundColor=mo.circleColor;
            }
            [bbg insertSubview:circle belowSubview:imageView];
        }
        
        if(mo.badge>0)
        {
            UILabel *bad=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
            bad.backgroundColor=_mainColor;
            bad.textColor=[UIColor whiteColor];
            bad.text=[NSString stringWithFormat:@"%ld",(long)mo.badge];
            bad.font=[UIFont systemFontOfSize:14];
            if(mo.badge>99)
            {
                bad.text=@"99+";
            }
            bad.textAlignment=NSTextAlignmentCenter;
            [bad sizeToFit];
            
            CGRect newRe=bad.frame;
            newRe.origin=CGPointMake(imageView.frame.size.width/2+10, -10);
            newRe.size.width=newRe.size.width+8;
            newRe.size.height=20;
            if(newRe.size.width<newRe.size.height)
            {
                newRe.size.width=newRe.size.height;
            }
            
            bad.frame=newRe;
            
            bad.layer.cornerRadius=newRe.size.height/2;
            bad.clipsToBounds=YES;
            [bbg addSubview:bad];
        }
        
        UIButton* btn=[[UIButton alloc]initWithFrame:bbg.bounds];
        btn.tag=i;
        [btn setBackgroundImage:[UIImage imageNamed:@"button_highlighted_bg"] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(buttonClicks:) forControlEvents:UIControlEventTouchUpInside];
        [bbg addSubview:btn];
    }
}

-(void)buttonClicks:(UIButton*)button
{
    NSInteger tag=button.tag;
    SimpleButtonModel* mo=[self.buttons objectAtIndex:tag];
//    NSLog(@"%@,%@",mo.title,mo.identifier);
    if([self.delegate respondsToSelector:@selector(simpleButtonsTableViewCell:didSelectedModel:)])
    {
        [self.delegate simpleButtonsTableViewCell:self didSelectedModel:mo];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat totalWidth=self.contentView.frame.size.width;
    CGFloat wid=totalWidth/simpleButtonRowCount;
    CGFloat wid2=wid/2;
    NSInteger counts=[self.contentView subviews].count;
    for (NSInteger i=0; i<counts; i++) {
        NSInteger col=i%simpleButtonRowCount;
        
        UIView* vi=[[self.contentView subviews]objectAtIndex:i];
        vi.center=CGPointMake(wid2+wid*col, vi.center.y);
    }
}

@end

@implementation SimpleButtonModel

-(instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName identifier:(NSString *)identifier type:(NSInteger)type badge:(NSInteger)badge
{
    self=[super init];
    if (self) {
        self.title=title;
        self.imageName=imageName;
        self.identifier=identifier;
        self.type=type;
        self.badge=badge;
    }
    return self;
}

@end
