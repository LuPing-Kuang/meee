//
//  TransportViewCell.h
//  me
//
//  Created by KLP on 2018/2/3.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyOrderModel.h"
@interface TransportViewCell : UITableViewCell

@property (nonatomic, copy) void(^sureBlock)(MyOrderProductModel *model);
@property (weak, nonatomic) IBOutlet UILabel *countLb;
@property (weak, nonatomic) IBOutlet UILabel *packLb;
@property (weak, nonatomic) IBOutlet UILabel *contentLb;
@property (weak, nonatomic) IBOutlet UIImageView *productImageV;

@property (nonatomic, strong) MyOrderProductModel *productModel;


@end
