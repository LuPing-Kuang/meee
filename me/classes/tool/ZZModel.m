//
//  ZZModel.m
//  zhanmao
//
//  Created by bangju on 2017/11/9.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "ZZModel.h"

@implementation ZZModel

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self=[super init];
    if (self) {
        self.dictionary=dictionary;
    }
    return self;
}

//-(instancetype)initWithArray:(NSArray *)array
//{
//    self=[super init];
//    if (self) {
//        self.array=array;
//    }
//    return self;
//}

@end
