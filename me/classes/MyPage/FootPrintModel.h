//
//  FootPrintModel.h
//  me
//
//  Created by jam on 2018/1/11.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FootPrintModel : NSObject

@property (nonatomic,strong) NSString* idd;
@property (nonatomic,strong) NSString* goodsid;
@property (nonatomic,strong) NSString* title;
@property (nonatomic,strong) NSString* thumb;
@property (nonatomic,strong) NSNumber* marketprice;
@property (nonatomic,strong) NSNumber* productprice;
@property (nonatomic,strong) NSString* createtime;
@property (nonatomic,strong) NSString* merchid;
@property (nonatomic,strong) NSString* merchname;

@property (nonatomic,assign) BOOL selected;

@end
