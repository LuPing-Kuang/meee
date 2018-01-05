//
//  MySimpleTableViewCell.h
//  me
//
//  Created by jam on 2018/1/5.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "LinedTableViewCell.h"

@interface MySimpleTableViewCell : LinedTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *detail;

@property (nonatomic,assign) NSInteger badge;

@end
