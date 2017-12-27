//
//  CorneredImageView.m
//  zhanmao
//
//  Created by bangju on 2017/10/20.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "CorneredImageView.h"

@implementation CorneredImageView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.layer.masksToBounds=YES;
    self.layer.cornerRadius=6;
    self.layer.borderColor=[UIColor clearColor].CGColor;
    self.layer.borderWidth=1/[[UIScreen mainScreen]scale];
}

-(void)setImage:(UIImage *)image
{
    if (image) {
        self.layer.borderColor=[UIColor clearColor].CGColor;
    }
    else
    {
        self.layer.borderColor=gray_8.CGColor;
    }
    [super setImage:image];
}

@end
