//
//  ZZModel.h
//  zhanmao
//
//  Created by bangju on 2017/11/9.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZModel : NSObject

-(instancetype)initWithDictionary:(NSDictionary*)dictionary;
//-(instancetype)initWithArray:(NSArray*)array;

@property (nonatomic,strong) NSDictionary* dictionary;
//@property (nonatomic,strong) NSArray* array;

@end
