//
//  ProductScreeningView.h
//  me
//
//  Created by KLP on 2018/1/21.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductScreeningView : UIView

@property (nonatomic, copy) void(^CancelBlock)();
@property (nonatomic, copy) void(^SureBlock)(NSString *cate,BOOL isrecommand,BOOL isnew,BOOL ishot,BOOL isdiscount,BOOL issendfree,BOOL istime);

- (void)resetStatues;

@end


