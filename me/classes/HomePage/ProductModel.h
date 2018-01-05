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

@property NSString* thumb;
@property NSString* title;
@property NSString* subtitle;
@property NSString* price;
@property NSString* gid;
@property NSString* total;
@property NSString* bargain;
@property NSString* productprice;
@property NSString* credit;
@property NSString* ctype;
@property NSString* gtype;
@property NSInteger sales;

@end

@interface ProductSection : NSObject

@property NSInteger style;
@property NSString* title;
@property NSArray* products;

@end
