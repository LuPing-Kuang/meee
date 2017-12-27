//
//  ImageBadgeBarButtonItem.m
//  zhanmao
//
//  Created by bangju on 2017/10/26.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "ImageBadgeBarButtonItem.h"

@implementation ImageBadgeBarButtonItem

+(instancetype)itemWithImageName:(NSString *)imageName count:(NSInteger)count target:(id)target selector:(SEL)selector
{
    UIImageView* img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
//    img.frame=CGRectMake(0, 0, 44, 32);
    img.contentMode=UIViewContentModeCenter;
    img.frame=CGRectMake(0, 0, 30, 34);
    
    UIButton* v=[[UIButton alloc]initWithFrame:img.bounds];
    [v addSubview:img];
    [v addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    if (count>0) {
        UILabel* lab=[[UILabel alloc]initWithFrame:img.bounds];
        lab.textColor=[UIColor whiteColor];
        lab.backgroundColor=[UIColor redColor];
        lab.font=[UIFont systemFontOfSize:12];
        lab.textAlignment=NSTextAlignmentCenter;
        lab.text=[NSString stringWithFormat:@"%ld",(long)count];
        if (count>99) {
            lab.text=@"99+";
        }
        [lab sizeToFit];
        CGRect fr=lab.frame;
        fr.size.width=fr.size.width+6;
        if (fr.size.width<fr.size.height) {
            fr.size.width=fr.size.height;
        }
//        fr.size.height=fr.size.height+8;
        fr.origin.x=img.frame.size.width+img.frame.origin.x-fr.size.width/2;//*1.5;
        fr.origin.y=0;//-fr.size.height/2;
        lab.frame=fr;
        
        lab.layer.masksToBounds=YES;
        lab.layer.cornerRadius=fr.size.height/2;
        
        [v addSubview:lab];
    }
    
    ImageBadgeBarButtonItem* item=[[ImageBadgeBarButtonItem alloc]initWithCustomView:v];
    return item;
}

@end
