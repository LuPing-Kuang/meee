//
//  ProductionOrderModel.m
//  me
//
//  Created by jam on 2018/1/9.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "ProductionOrderModel.h"

@implementation ProductionOrderGoodModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"idd" : @"id"};
}

@end

@implementation ProductionOrderAddressModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"idd" : @"id"};
}

@end

@implementation ProductionOrderDetailPriceModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"idd" : @"id"};
}

-(BOOL)shouldShowMemberDiscount
{
    return self.discountprice.doubleValue>0;
}

-(NSInteger)sectionShowingCount
{
    if (self.shouldShowMemberDiscount) {
        return 4;
    }
    return 3;
}

@end
