//
//  ImageCollectionViewCell.m
//  me
//
//  Created by 邝路平 on 2018/4/1.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "ImageCollectionViewCell.h"

@implementation ImageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
    }
    return self;
    
}



- (void)setupSubViews{
    UIImageView *ImageV = [[UIImageView alloc]initWithFrame:self.bounds];
    ImageV.layer.masksToBounds = true;
    ImageV.contentMode = UIViewContentModeScaleToFill;
    self.imageV = ImageV;
    [self.contentView addSubview:ImageV];
    
}

@end
