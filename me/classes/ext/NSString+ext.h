//
//  NSString+ext.h
//  yangsheng
//
//  Created by Macx on 17/7/12.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UnitStringSquareMeter @"m²"

@interface NSString (ext)

-(NSURL*)urlWithMainUrl;

-(BOOL)isMobileNumber;

-(BOOL)isEMailAddress;

-(NSString*)dateString;
-(NSString*)timeString;

@property (nonatomic,assign) BOOL passwordLength;


+(NSString*)stringWithFloat:(CGFloat)doubleValue headUnit:(NSString*)head tailUnit:(NSString*)tail;  //such as $100/day

-(NSString*)stringAppendingUnit:(NSString*)unit;

@end
