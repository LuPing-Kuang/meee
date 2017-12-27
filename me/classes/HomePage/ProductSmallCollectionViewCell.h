//
//  ProductSmallCollectionViewCell.h
//  me
//
//  Created by jam on 2017/12/27.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductSmallCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet CorneredImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *price;

@end
