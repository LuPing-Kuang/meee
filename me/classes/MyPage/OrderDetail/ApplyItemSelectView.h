//
//  ApplyItemSelectView.h
//  me
//
//  Created by 邝路平 on 2018/4/1.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApplyItemSelectView : UIView

+ (void)showWithButtonRect:(CGRect)rect SelectBlock:(void(^)(NSInteger index))selectBlock TitleArr:(NSArray*)titelArr;


@end
