//
//  ProductionCategoryModel.h
//  me
//
//  Created by 邝路平 on 2018/4/13.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductionCategoryModel : NSObject

@property (nonatomic,strong) NSString *ID;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *thumb;
@property (nonatomic,strong) NSString *advurl;
@property (nonatomic,strong) NSString *advimg;
@property (nonatomic,strong) NSArray *child;

@end



