//
//  IBDesignableOnePixelConstant.m
//  zhanmao
//
//  Created by jam on 2017/11/30.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "IBDesignableOnePixelConstant.h"

@implementation IBDesignableOnePixelConstant

-(void)setPixelConstant:(NSInteger)pixelConstant
{
    _pixelConstant=pixelConstant;
    self.constant=_pixelConstant*1.0/[[UIScreen mainScreen]scale];
}

@end
