//
//  HudManager.h
//  FKGST
//
//  Created by 杨德勇 on 2017/6/20.
//  Copyright © 2017年 U+Road. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HUDManager : NSObject

+(void)changeHudToWhite;
+(void)changeHudToBlack;

+ (void)uroadplus_Developing;

+(void)startAnimation;
+ (void)showMessage:(NSString *)msg;
+ (void)showErrorMsg:(NSString *)errmsg;
+ (void)showSuccessMsg:(NSString *)msg;
+ (void)showLoading:(NSString *)msg;
+ (void)showMessage:(NSString *)msg andProgress:(CGFloat)progress;
+ (void)dismiss;

+(void)showSystemAlert:(NSString *)name btnBlock:(void (^)(UIAlertAction *action))btnBlock;

+(void)showSystemAlertWithTitle:(NSString *)title message:(NSString*)message buttonTitle:(NSString *)btntitle needDestructive:(BOOL)needDistory cancleBlock: (void (^)(UIAlertAction *action))cancleBlock btnBlock:(void (^)(UIAlertAction *action))btnBlock;
@end
