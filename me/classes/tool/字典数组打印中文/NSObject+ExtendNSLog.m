//
//  NSObject+ExtendNSLog.m
//  CareChat
//
//  Created by 邝路平 on 16/7/13.
//  Copyright © 2016年 邝路平. All rights reserved.
//

#import "NSObject+ExtendNSLog.h"

@implementation NSObject (ExtendNSLog)

void ExtendNSLog(const char *file, int lineNumber, const char *functionName, NSString *format, ...) {
    
    va_list ap;
    
    va_start(ap, format);
    
    if (![format hasSuffix: @"\n"]) {
        format = [format stringByAppendingString: @"\n"];
    }
    
    NSString *body = [[NSString alloc] initWithFormat:format arguments:ap];
    
    va_end(ap);
    
    NSString *fileName = [[NSString stringWithUTF8String:file] lastPathComponent];
    fprintf(stderr, "(%s) (%s:%d) %s",
            functionName,
            [fileName UTF8String],
            lineNumber,
            [body UTF8String]);
}

@end
