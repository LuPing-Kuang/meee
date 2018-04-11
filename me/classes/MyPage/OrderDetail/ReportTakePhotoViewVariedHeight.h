//
//  ReportTakePhotoViewVariedHeight.h
//  nmjj_ios
//
//  Created by luo_Mac on 2017/6/14.
//  Copyright © 2017年 UI-5. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportTakePhotoViewVariedHeight : UIView

@property (nonatomic,strong) NSMutableArray *takeImgs;

@property (nonatomic,copy) void(^resultHeight)(CGFloat height);

@end
