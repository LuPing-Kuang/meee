//
//  RefundPageModel.h
//  me
//
//  Created by 邝路平 on 2018/4/2.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RefundPageOrderModel;

@interface RefundPageModel : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *refundtype;
@property (nonatomic,strong) NSString *refundreason;
@property (nonatomic,strong) NSString *refundexplain;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) RefundPageOrderModel *order;
@property (nonatomic,assign) BOOL refund;
@property (nonatomic,strong) NSArray *images;
@property (nonatomic,strong) NSArray *imgs;
@property (nonatomic,strong) NSString *rtypeIndex;
@property (nonatomic,strong) NSString *reasonIndex;

@end


@interface RefundPageOrderModel : NSObject

@property (nonatomic,strong) NSString *ID;
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *refundid;
@property (nonatomic,strong) NSString *goodsprice;
@property (nonatomic,strong) NSString *dispatchprice;
@property (nonatomic,strong) NSString *deductprice;
@property (nonatomic,strong) NSString *deductcredit2;
@property (nonatomic,strong) NSString *finishtime;
@property (nonatomic,strong) NSString *isverify;
@property (nonatomic,strong) NSString *virtual1;
@property (nonatomic,strong) NSString *refundstate;
@property (nonatomic,strong) NSString *merchid;
@property (nonatomic,assign) BOOL cannotrefund;
@property (nonatomic,strong) NSString *refundprice;  //(最大退款金额)

@end



