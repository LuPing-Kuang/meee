//
//  StoresAddressView.h
//  me
//
//  Created by KLP on 2018/2/7.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreModel.h"

@interface StoresAddressView : UIView

@property (nonatomic,copy) void(^selectblock)(StoreModel*model);     // 点击Cell回调

- (void)searchWithKeyword:(NSString*)keyword;       // 根据关键字搜索

- (void)showInView:(UIView*)view;

- (void)dismiss;

@end
