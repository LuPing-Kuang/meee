//
//  ExchangeMsgView.h
//  me
//
//  Created by 邝路平 on 2018/3/14.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "exchangeModel.h"

@interface ExchangeMsgView : UIView

@property (nonatomic,strong) exchangeModel *model;

@property (nonatomic,copy) void(^backBlock)(void);

@property (nonatomic,copy) void(^exchangeBlock)(void);

@end
