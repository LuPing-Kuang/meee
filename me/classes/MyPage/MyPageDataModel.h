//
//  MyPageDataModel.h
//  me
//
//  Created by jam on 2018/1/5.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,MyPageDataType)
{
    MyPageDataTypeNormal,
    MyPageDataTypeHeader,
    MyPageDataTypeCollection,
    MyPageDataTypeLogout
};

@interface MyPageDataModel : NSObject

@property MyPageDataType dataType;
@property (nonatomic,strong) NSString* imageName;
@property (nonatomic,strong) NSString* title;
@property (nonatomic,strong) NSString* detail;
@property NSInteger badge;
@property (nonatomic,strong) NSString* action;
@property id associateObject;

+(instancetype)modelWithType:(MyPageDataType)type imageName:(NSString*)imageName title:(NSString*)title detail:(NSString*)detail badge:(NSInteger)badge action:(NSString*)action associateObject:(id)obj;

@end
