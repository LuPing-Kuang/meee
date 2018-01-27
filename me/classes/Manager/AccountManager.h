//
//  AccountManager.h
//  me
//
//  Created by KLP on 2018/1/27.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface AccountManager : NSObject

+(instancetype)sharedInstance;

@property (nonatomic, strong) UserModel *currentUser;


@end
