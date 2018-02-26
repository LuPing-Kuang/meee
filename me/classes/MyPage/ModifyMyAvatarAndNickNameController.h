//
//  ModifyMyAvatarAndNickNameController.h
//  me
//
//  Created by KLP on 2018/2/26.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "BaseTableViewController.h"

@interface ModifyMyAvatarAndNickNameController : BaseTableViewController

@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *avatar;

@property (nonatomic, copy) void(^needToReload)(void);



@end
