//
//  PruductModel.h
//  me
//
//  Created by jam on 2018/1/5.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,ProductSectionStyle)
{
    ProductSectionStyleOne,
    ProductSectionStyleTwo,
};

@interface ProductModel : NSObject

@property (nonatomic,strong) NSString* thumb;
@property (nonatomic,strong) NSString* title;
@property (nonatomic,strong) NSString* subtitle;
@property (nonatomic,strong) NSString* price;
@property (nonatomic,strong) NSString* gid;
@property (nonatomic,strong) NSString* total;
@property (nonatomic,strong) NSString* bargain;
@property (nonatomic,strong) NSString* productprice;
@property (nonatomic,strong) NSString* credit;
@property (nonatomic,strong) NSString* ctype;
@property (nonatomic,strong) NSString* gtype;
@property NSInteger sales;

@end

@interface ProductSection : NSObject

@property NSInteger style;
@property (nonatomic,strong) NSString* title;
@property NSArray* products;

@end
