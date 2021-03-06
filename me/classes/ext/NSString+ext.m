//
//  NSString+ext.m
//  yangsheng
//
//  Created by Macx on 17/7/12.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "NSString+ext.h"

@implementation NSString (ext)         

-(BOOL)isMobileNumber
{
//    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9]|70|77)\\d{8}$";
//    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
//    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
//    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
//    
//    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
//
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
//    BOOL res1 = [regextestmobile evaluateWithObject:self];
//    BOOL res2 = [regextestcm evaluateWithObject:self];
//    BOOL res3 = [regextestcu evaluateWithObject:self];
//    BOOL res4 = [regextestct evaluateWithObject:self];
//    if (res1 || res2 || res3 || res4 )
//    {
//        return YES;
//    }
//    else
//    {
//        return NO;
//    }
//    if (self.length<=11) {
//        return NO;
//    }
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:self];
}

-(BOOL)isEMailAddress
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

-(void)setPasswordLength:(BOOL)passwordLength
{
    
}

-(BOOL)passwordLength
{
    return self.length>=5&&self.length<=20;
}

-(NSString*)dateString
{
    NSString* str=[[self componentsSeparatedByString:@" "]firstObject];
    if (str.length==0) {
        str=@"";
    }
    return str;
}

-(NSString*)timeString
{
    NSString* str=[[self componentsSeparatedByString:@" "]lastObject];
    if (str.length==0) {
        str=@"";
    }
    return str;
}

+(NSString*)stringWithFloat:(CGFloat)doubleValue headUnit:(NSString *)head tailUnit:(NSString *)tail
{
    if (head.length==0) {
        head=@"";
    }
    if (tail.length==0) {
        tail=@"";
    }
    double dou=doubleValue;
    if (dou<0) {
        dou=-dou;
    }
    return [NSString stringWithFormat:@"%@%@%.2f%@",doubleValue<0?@"-":@"",head,dou,tail];
}

-(NSString*)stringAppendingUnit:(NSString *)unit
{
    if (unit.length==0) {
        unit=@"";
    }
    NSString* str=[NSString stringWithFormat:@"%@%@",self,unit];
    return str;
}

-(NSString*)stringValueFromUrlParamsKey:(NSString *)key
{
    NSArray* quesMarkArr=[self componentsSeparatedByString:@"?"];
    if (quesMarkArr.lastObject) {
        NSString* paras=quesMarkArr.lastObject;
        NSArray* andMarkArr=[paras componentsSeparatedByString:@"&"];
        for (NSString* oneParStr in andMarkArr) {
            NSArray* keyValue=[oneParStr componentsSeparatedByString:@"="];
            if (keyValue.count==2) {
                if ([keyValue.firstObject isEqualToString:key]) {
                    return keyValue.lastObject;
                }
            }
        }
    }
    return @"";
}

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    if (SYSTEM_VERSION_EARLY_THAN_7_0) {
        
        return [self sizeWithFont:font constrainedToSize:maxSize lineBreakMode:NSLineBreakByWordWrapping];
    }else{
        return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    }
}

@end
