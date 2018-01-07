//
//  BaseToolBarTableViewController.h
//  zhanmao
//
//  Created by bangju on 2017/10/24.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseToolBarTableViewController : BaseTableViewController

//@property (nonatomic,assign) NSInteger type;

@property (nonatomic,readonly,assign) CGRect bottomFrame;

-(void)bottomToolBarButtonClicked;

-(void)setBottomSubView:(UIView*)view;
-(void)setBottomBarHidden:(BOOL)hidden;

@end
