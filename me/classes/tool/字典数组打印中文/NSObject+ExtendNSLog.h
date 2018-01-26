//
//  NSObject+ExtendNSLog.h
//  CareChat
//
//  Created by 邝路平 on 16/7/13.
//  Copyright © 2016年 邝路平. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ExtendNSLog)
void ExtendNSLog(const char *file, int lineNumber, const char *functionName, NSString *format, ...);
@end
