//
//  ZZStepper.h
//  zhanmao
//
//  Created by bangju on 2017/10/25.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZStepper : UIControl

//+(instancetype)stepperWithValue:(NSInteger)

@property (nonatomic,assign) NSInteger value;
@property (nonatomic,assign) NSInteger min;
@property (nonatomic,assign) NSInteger max;
@property (nonatomic,assign) NSInteger stepper; //def 1;

@end
