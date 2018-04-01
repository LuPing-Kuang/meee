//
//  MyFootPrintTableViewCell.h
//  me
//
//  Created by jam on 2018/1/11.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyFootPrintTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *price1;
@property (weak, nonatomic) IBOutlet UILabel *price2;

@end
