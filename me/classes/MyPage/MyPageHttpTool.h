//
//  MyPageHttpTool.h
//  me
//
//  Created by jam on 2018/1/6.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "ZZHttpTool.h"
#import "MyPageDataModel.h"
#import "UserModel.h"

#import "SimpleButtonsTableViewCell.h"

@interface MyPageHttpTool : ZZHttpTool

+(void)getMyPageDataCache:(BOOL)cache token:(NSString*)token success:(void(^)(NSArray* myPageSections))success failure:(void(^)(NSError* error))failure;

@end
