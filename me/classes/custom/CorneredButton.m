//
//  CorneredButton.m
//  me
//
//  Created by jam on 2017/12/27.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "CorneredButton.h"

@implementation CorneredButton

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    if (!self.borderColor) {
        self.borderColor=[UIColor clearColor];
    }
    
    self.layer.cornerRadius=self.cornerRadius;
    self.layer.borderColor=self.borderColor.CGColor;
    self.layer.borderWidth=0.5;
    self.layer.masksToBounds=YES;
    
    
}

@end
