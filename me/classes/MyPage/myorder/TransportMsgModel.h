//
//  TransportMsgModel.h
//  me
//
//  Created by KLP on 2018/2/3.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyOrderModel.h"
@class TransportMsgListModel;
@interface TransportMsgModel : NSObject

@property (nonatomic, strong) NSString *statusstr;
@property (nonatomic, strong) NSString *express;
@property (nonatomic, strong) NSString *expresssn;
@property (nonatomic, strong) NSArray *productArr;

@property (nonatomic, strong) NSArray *expresslist;


@end

@interface TransportMsgListModel : NSObject

@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *step;


@end
