//
//  RentCartEditToolBar.h
//  zhanmao
//
//  Created by bangju on 2017/11/1.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RentCartEditToolBar : UIView

@property (weak, nonatomic) IBOutlet UIButton *selectAllButton;

@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UIButton *account;
@property (weak, nonatomic) IBOutlet UIButton *attention;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@property (weak, nonatomic) IBOutlet UIView *normalView;

@property (weak, nonatomic) IBOutlet UIView *editingView;

@property (nonatomic,assign) BOOL editing;
@property (nonatomic,assign) BOOL seletedAll;

@end
