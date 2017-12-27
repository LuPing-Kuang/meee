//
//  ImageBadgeBarButtonItem.h
//  zhanmao
//
//  Created by bangju on 2017/10/26.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageBadgeBarButtonItem : UIBarButtonItem

+(instancetype)itemWithImageName:(NSString *)imageName count:(NSInteger)count target:(id)target selector:(SEL)selector;

@end
