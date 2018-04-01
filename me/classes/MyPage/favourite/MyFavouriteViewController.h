//
//  MyFavouriteViewController.h
//  me
//
//  Created by KLP on 2018/1/27.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "BaseTableViewController.h"
#import "BaseToolBarTableViewController.h"

@interface MyFavouriteViewController : BaseToolBarTableViewController

@property (nonatomic, copy) void(^needRefreshBlock)(void);

@end
