//
//  MyFavouriteSelectedAllActionView.h
//  me
//
//  Created by KLP on 2018/1/27.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyFavouriteSelectedAllActionView : UIView

@property (nonatomic,assign) BOOL selectedAll;

@property (weak, nonatomic) IBOutlet UIButton *selectAllButton;
@property (weak, nonatomic) IBOutlet UIButton *actionButton;

@end
