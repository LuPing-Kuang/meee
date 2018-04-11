//
//  MyOrderDetailBottomView.h
//  me
//
//  Created by 邝路平 on 2018/4/1.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrderDetailBottomView : UIView

@property (nonatomic,strong) NSArray *titleArr;

@property (nonatomic,strong) NSArray *firstColorTitleArr;

@property (nonatomic,copy) void(^selectBlock)(NSInteger index);

@end
