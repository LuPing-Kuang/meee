//
//  HudManager.m
//  FKGST
//
//  Created by 杨德勇 on 2017/6/20.
//  Copyright © 2017年 U+Road. All rights reserved.
//

#import "HUDManager.h"

@implementation HUDManager
+ (void)uroadplus_Developing{
    
    [HUDManager showErrorMsg:@"此功能正在建设中..."];
    
}

+(void)startAnimation{
    
    [self showLoading:@"正在加载..."];
    
    
}

+(void)changeHudToWhite{
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    
}

+(void)changeHudToBlack{
    
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    
}


+ (void)showErrorMsg:(NSString *)errmsg {
    
    [SVProgressHUD showErrorWithStatus:errmsg];
}

+ (void)showSuccessMsg:(NSString *)msg {
    [SVProgressHUD showSuccessWithStatus:msg];
    
}
+ (void)showMessage:(NSString *)msg{
    [SVProgressHUD showInfoWithStatus:msg];
}

+(void)showLoading:(NSString *)msg{
    [SVProgressHUD showWithStatus:msg];
}

+(void)showMessage:(NSString *)msg andProgress:(CGFloat)progress{
    dispatch_async(dispatch_get_main_queue(), ^{
        [SVProgressHUD showProgress:progress status:msg];
    });
    
}

+(void)dismiss{
    [SVProgressHUD dismiss];
    
}


+(void)showSystemAlert:(NSString *)name btnBlock:(void (^)(UIAlertAction *action))btnBlock{
    [HUDManager dismiss];
    if (![name isKindOfClass:[NSString class]] || name.length == 0) {
        return;
    }
    
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"重要告示" message:name preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler: ^(UIAlertAction *action) {
        if (btnBlock) {
            btnBlock(nil);
        }
    }];
    
    [vc addAction:act1];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:true completion:^{
        
    }];
}


+(void)showSystemAlertWithTitle:(NSString *)title message:(NSString*)message buttonTitle:(NSString *)btntitle needDestructive:(BOOL)needDistory cancleBlock: (void (^)(UIAlertAction *action))cancleBlock btnBlock:(void (^)(UIAlertAction *action))btnBlock {
    
    [HUDManager dismiss];
    
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:cancleBlock];
    
    UIAlertActionStyle style = UIAlertActionStyleDefault;
    if (needDistory) {
        style = UIAlertActionStyleDestructive;
    }else{
        style = UIAlertActionStyleDefault;
    }
    
    UIAlertAction *act2 = [UIAlertAction actionWithTitle:btntitle style:style handler:btnBlock];
    
    [vc addAction:act1];
    [vc addAction:act2];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc animated:true completion:^{
        
    }];
    
}



@end
