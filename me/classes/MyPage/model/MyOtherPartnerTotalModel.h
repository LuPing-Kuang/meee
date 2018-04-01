//
//  MyOtherPartnerTotalModel.h
//  me
//
//  Created by KLP on 2018/1/20.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyOtherPartnerModel.h"

typedef NS_ENUM(NSInteger,DistributionLevelType)
{
    DistributionLevelTypeLevel1 = 1,
    DistributionLevelTypeLevel2 = 2,
    DistributionLevelTypeLevel3 = 3,
    
};

@interface MyOtherPartnerTotalModel : NSObject

+(DistributionLevelType)levelTypeForPagerIndex:(NSInteger)index;
+(NSInteger)pageIndexForLevelType:(DistributionLevelType)type;
+(NSString*)titleForLevelType:(DistributionLevelType)type;

@property (nonatomic, strong) NSArray <MyOtherPartnerModel*>*list;


@property (nonatomic, copy) NSString *total;
@property (nonatomic, copy) NSString *pagesize;
@property (nonatomic, copy) NSString *pagecount;

@end

