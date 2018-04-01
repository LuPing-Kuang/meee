//
//  MyPageLogoutAndForgetPsCell.h
//  me
//
//  Created by KLP on 2018/1/25.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPageLogoutAndForgetPsCell : UITableViewCell

@property (nonatomic, copy) void(^changePsBlock)(void);
@property (nonatomic, copy) void(^logoutBlock)(void);



@end
