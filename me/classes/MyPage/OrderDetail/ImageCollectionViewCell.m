//
//  ImageCollectionViewCell.m
//  nmjj_ios
//
//  Created by luo_Mac on 2017/5/27.
//  Copyright © 2017年 UI-5. All rights reserved.
//

#import "ImageCollectionViewCell.h"

@implementation ImageCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.ImageView.layer.cornerRadius = 3.0;
    self.ImageView.layer.masksToBounds = YES;
    self.ImageView.userInteractionEnabled = NO;
    
    self.backgroundImageView.hidden = YES;
    self.backgroundImageView.userInteractionEnabled = NO;
}

@end
