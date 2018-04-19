//
//  MyOtherPartnerTotalModel.m
//  me
//
//  Created by KLP on 2018/1/20.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "MyOtherPartnerTotalModel.h"

@implementation MyOtherPartnerTotalModel

+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [MyOtherPartnerModel class]};
}

+(DistributionLevelType)levelTypeForPagerIndex:(NSInteger)index{
    switch (index) {
        case 0:
            return DistributionLevelTypeLevel1;
            break;
        case 1:
            return DistributionLevelTypeLevel2;
            break;
        case 2:
            return DistributionLevelTypeLevel3;
            break;
        default:
            break;
    }
    return 0;
}
+(NSInteger)pageIndexForLevelType:(DistributionLevelType)type{
    switch (type) {
        case DistributionLevelTypeLevel1:
            return 0;
            break;
        case DistributionLevelTypeLevel2:
            return 1;
            break;
        case DistributionLevelTypeLevel3:
            return 2;
            break;
        default:
            break;
    }
    return 0;
}
+(NSString*)titleForLevelType:(DistributionLevelType)type{
    switch (type) {
        case DistributionLevelTypeLevel1:
            return @"A";
            break;
        case DistributionLevelTypeLevel2:
            return @"B";
            break;
        case DistributionLevelTypeLevel3:
            return @"C";
            break;
        default:
            break;
    }
    return @"";
}


@end
