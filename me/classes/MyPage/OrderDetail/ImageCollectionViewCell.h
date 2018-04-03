//
//  ImageCollectionViewCell.h
//  nmjj_ios
//
//  Created by luo_Mac on 2017/5/27.
//  Copyright © 2017年 UI-5. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *ImageView;

@property (weak, nonatomic) IBOutlet UILabel *sizeLb;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;


@end
