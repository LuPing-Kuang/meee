//
//  BaiduNavManager.h
//  me
//
//  Created by KLP on 2018/2/3.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaiduNavManager : NSObject

+(instancetype)sharedInstance;

- (void)startWithAppKey:(NSString*)key;

@end
