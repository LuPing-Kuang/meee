//
//  ImageTitleBarButtonItem.h
//  zhanmao
//
//  Created by bangju on 2017/10/23.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageTitleBarButtonItem : UIBarButtonItem

+(instancetype)itemWithImageName:(NSString *)imageName leftImage:(BOOL)isLeft title:(NSString *)title target:(id)target selector:(SEL)selector;

@end
