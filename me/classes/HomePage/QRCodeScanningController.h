//
//  QRCodeScanningController.h
//  me
//
//  Created by 邝路平 on 2018/3/14.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QRCodeScanningController : UIViewController

@property (nonatomic, copy) void(^ScanBlock)(NSString*str,BOOL success);

@end
