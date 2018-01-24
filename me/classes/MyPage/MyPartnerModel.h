//
//  MyPartnerModel.h
//  me
//
//  Created by KLP on 2018/1/18.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MyPartnerMsgModel;

@interface MyPartnerModel : NSObject

@property (nonatomic, strong) MyPartnerMsgModel *member;
@property (nonatomic, copy) NSString *levelname;
@property (nonatomic, copy) NSString *agentname;
@property (nonatomic, copy) NSString *icode;
@property (nonatomic, copy) NSString *cansettle;


@end
