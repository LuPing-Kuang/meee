//
//  UIView+Meee.m
//  me
//
//  Created by KLP on 2018/1/22.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "UIView+Meee.h"

@implementation UIView (Meee)

static char tapActionChar;
static char tapGestureChar;

@dynamic tapAction;

-(void)setTapAction:(void (^)(UITapGestureRecognizer*))tapAction{
    self.userInteractionEnabled=YES;
    UITapGestureRecognizer*gesture=objc_getAssociatedObject(self, &tapGestureChar);
    
    if(!gesture){
        gesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &tapGestureChar, gesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    objc_setAssociatedObject(self,&tapActionChar,tapAction,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}




-(void(^)(UITapGestureRecognizer*))tapAction{
    void(^action)(UITapGestureRecognizer*)=objc_getAssociatedObject(self,&tapActionChar);
    if(!action){
        action=nil;
        objc_setAssociatedObject(self,&tapActionChar,action,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return action;
}

-(void)tapClick:(UITapGestureRecognizer*)gesture{
    if(self.tapAction){
        self.tapAction(gesture);
    }
}


-(void)addRoundlineWithColor:(UIColor * _Nonnull)color andWidth:(CGFloat)width{
    
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
    self.layer.masksToBounds = true;
    
}

-(void)addDefaultShadow{
    
    self.layer.shadowOpacity = 0.3;
    self.layer.shadowOffset = CGSizeZero;
    self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.layer.masksToBounds = false;
    
    
}

@end
