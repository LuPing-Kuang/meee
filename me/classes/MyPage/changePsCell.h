//
//  changePsCell.h
//  me
//
//  Created by KLP on 2018/1/27.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface changePsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *phoneTf;
@property (weak, nonatomic) IBOutlet UITextField *codeTf;
@property (weak, nonatomic) IBOutlet UITextField *theNewPsTf;
@property (weak, nonatomic) IBOutlet UITextField *againPsTf;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;

@property (nonatomic, copy) void(^sureBlock)(void);

@property (nonatomic, copy) void(^codeBlock)(void);



@end
