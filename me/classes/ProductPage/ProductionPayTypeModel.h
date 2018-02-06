//
//  ProductionPayTypeModel.h
//  me
//
//  Created by KLP on 2018/2/1.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <Foundation/Foundation.h>

@class myPayTypeModel;

@interface ProductionPayTypeModel : NSObject

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *ordersn;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *title;

@property (nonatomic, strong) myPayTypeModel *credit;
@property (nonatomic, strong) myPayTypeModel *wechat;
@property (nonatomic, strong) myPayTypeModel *alipay;
@property (nonatomic, strong) myPayTypeModel *cash;



@end

@interface myPayTypeModel : NSObject

@property (nonatomic, assign) BOOL success;
@property (nonatomic, strong) NSString *current;





@end
