//
//  MyFavouriteViewCell.h
//  me
//
//  Created by KLP on 2018/1/27.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyfavouriteModel.h"

@interface MyFavouriteViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (nonatomic, strong) MyfavouriteModel *myfavouriteModel;


- (void)showSelectBtn;

- (void)hideSelectBtn;

@property (nonatomic, copy) void(^selectBlock)(MyfavouriteModel*model);


@end
