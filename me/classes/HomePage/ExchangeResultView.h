//
//  ExchangeResultView.h
//  me
//
//  Created by 邝路平 on 2018/3/14.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExchangeResultView : UIView

@property (nonatomic,copy) void(^sureBlock)(BOOL success);

- (void)showSuccess;

- (void)showError;

@end
