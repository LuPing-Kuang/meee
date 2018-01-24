//
//  PartnerMaterialCell.h
//  me
//
//  Created by KLP on 2018/1/22.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PartnerMaterialCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLb;
@property (weak, nonatomic) IBOutlet UILabel *dotLb;
@property (weak, nonatomic) IBOutlet UITextField *myTf;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (nonatomic, copy) void(^sureBlock)(void);


@property (nonatomic, copy) void(^saveBlock)(void);

@end
