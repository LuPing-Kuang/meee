//
//  ZZSearchBar.m
//  yangsheng
//
//  Created by Macx on 17/7/19.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "ZZSearchBar.h"

@implementation ZZSearchBar

+(instancetype)defaultBar
{
    ZZSearchBar* bar=[[ZZSearchBar alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen]bounds].size.width, 30)];
    bar.layer.cornerRadius=bar.frame.size.height/2;
    bar.backgroundColor=[UIColor whiteColor];
//    bar.textColor=pinkColor;
    bar.textColor=gray_2;
    bar.font=[UIFont systemFontOfSize:13];
    bar.returnKeyType=UIReturnKeySearch;
    
    UIImage* seaImg=[UIImage imageNamed:@"searchGraySmall"];
    
    //UIGraphicsBeginImageContext(CGSizeMake(16, 16));
    //[seaImg drawInRect:CGRectMake(0, 0, 16, 16)];
    //UIImage* img=UIGraphicsGetImageFromCurrentImageContext();
    //UIGraphicsEndImageContext();
    
    UIImageView* icon=[[UIImageView alloc]initWithImage:seaImg];
    icon.tintColor=gray_8;
    icon.contentMode=UIViewContentModeCenter;
    icon.frame=CGRectMake(0, 0, bar.frame.size.height, bar.frame.size.height);
    bar.leftView=icon;
    bar.leftViewMode=UITextFieldViewModeAlways;
    
//    bar.translatesAutoresizingMaskIntoConstraints = NO;
    /*
    UIButton* cle=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, bar.frame.size.height, bar.frame.size.height)];
    [cle setImage:[UIImage imageNamed:@"clear"] forState:UIControlStateNormal];
    [cle addTarget:bar action:@selector(clearText) forControlEvents:UIControlEventTouchUpInside];
    bar.rightView=cle;
    bar.rightViewMode=UITextFieldViewModeAlways;
    */
    return bar;
}

-(void)clearText
{
    self.text=@"";
    [self becomeFirstResponder];
}

//-(CGSize)intrinsicContentSize
//{
//    return UILayoutFittingExpandedSize;
//}

@end
