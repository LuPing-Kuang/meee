//
//  UIView+GaosutongExtension.m
//  LNGaosutong
//
//  Created by 罗 建镇 on 15/3/4.
//  Copyright (c) 2015年 URoad. All rights reserved.
//

#import "UIView+GaosutongExtension.h"

@implementation UIView (GaosutongExtension)


static char tapActionChar;
static char tapGestureChar;



static char swipeLeftActionChar;
static char swipeLeftGestureChar;


static char swipeRightActionChar;
static char swipeRightGestureChar;



static char swipeUpActionChar;
static char swipeUpGestureChar;



static char swipeDownActionChar;
static char swipeDownGestureChar;



@dynamic  left_gst,top_gst,width_gst,height_gst,size,origin;
@dynamic horizontalAlignMode,horizontalAdjustMode,verticalAdjustMode,verticalAlignMode;
@dynamic tapAction;
@dynamic swipeLeftAction,swipeRightAction,swipeDownAction,swipeUpAction;



//-----------------------------------华丽的分割线---------------------------------

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



-(void)setSwipeLeftAction:(void (^)(UISwipeGestureRecognizer*))swipeLeftAction{
    self.userInteractionEnabled=YES;
    UISwipeGestureRecognizer*gesture=objc_getAssociatedObject(self, &swipeLeftGestureChar);
    if(!gesture){
        gesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeLeft:)];
        [gesture setDirection:UISwipeGestureRecognizerDirectionLeft];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &swipeLeftGestureChar, gesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    objc_setAssociatedObject(self,&swipeLeftActionChar,swipeLeftAction,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}



-(void(^)(UISwipeGestureRecognizer*))swipeLeftAction{
    void(^action)(UISwipeGestureRecognizer*)=objc_getAssociatedObject(self,&swipeLeftActionChar);
    if(!action){
        action=nil;
        objc_setAssociatedObject(self,&swipeLeftActionChar,action,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return action;
}





-(void)swipeLeft:(UISwipeGestureRecognizer*)gesture{
    if(self.swipeLeftAction){
        self.swipeLeftAction(gesture);
    }
}




-(void)setSwipeRightAction:(void (^)(UISwipeGestureRecognizer *))swipeRightAction{
    self.userInteractionEnabled=YES;
    UISwipeGestureRecognizer*gesture=objc_getAssociatedObject(self, &swipeRightGestureChar);
    if(!gesture){
        gesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeRight:)];
        [gesture setDirection:UISwipeGestureRecognizerDirectionRight];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &swipeRightGestureChar, gesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    objc_setAssociatedObject(self,&swipeRightActionChar,swipeRightAction,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void(^)(UISwipeGestureRecognizer*))swipeRightAction{
    void(^action)(UISwipeGestureRecognizer*)=objc_getAssociatedObject(self,&swipeRightActionChar);
    if(!action){
        action=nil;
        objc_setAssociatedObject(self,&swipeRightActionChar,action,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return action;
}

-(void)swipeRight:(UISwipeGestureRecognizer*)gesture{
    if(self.swipeRightAction){
        self.swipeRightAction(gesture);
    }
}


-(void)setSwipeUpAction:(void (^)(UISwipeGestureRecognizer *))swipeUpAction{
    self.userInteractionEnabled=YES;
    UISwipeGestureRecognizer*gesture=objc_getAssociatedObject(self, &swipeUpGestureChar);
    if(!gesture){
        gesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeUp:)];
        [gesture setDirection:UISwipeGestureRecognizerDirectionUp];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &swipeUpGestureChar, gesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    objc_setAssociatedObject(self,&swipeUpActionChar,swipeUpAction,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(void(^)(UISwipeGestureRecognizer*))swipeUpAction{
    void(^action)(UISwipeGestureRecognizer*)=objc_getAssociatedObject(self,&swipeUpActionChar);
    if(!action){
        action=nil;
        objc_setAssociatedObject(self,&swipeUpActionChar,action,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return action;
}


-(void)swipeUp:(UISwipeGestureRecognizer*)gesture{
    if(self.swipeUpAction){
        self.swipeUpAction(gesture);
    }
}




-(void)setSwipeDownAction:(void (^)(UISwipeGestureRecognizer *))swipeDownAction{
    self.userInteractionEnabled=YES;
    UISwipeGestureRecognizer*gesture=objc_getAssociatedObject(self, &swipeDownGestureChar);
    if(!gesture){
        gesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeDown:)];
        [gesture setDirection:UISwipeGestureRecognizerDirectionDown];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &swipeDownGestureChar, gesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    objc_setAssociatedObject(self,&swipeDownActionChar,swipeDownAction,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void(^)(UISwipeGestureRecognizer*))swipeDownAction{
    void(^action)(UISwipeGestureRecognizer*)=objc_getAssociatedObject(self,&swipeDownActionChar);
    if(!action){
        action=nil;
        objc_setAssociatedObject(self,&swipeDownActionChar,action,OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return action;
}



-(void)swipeDown:(UISwipeGestureRecognizer*)gesture{
    if(self.swipeDownAction){
        self.swipeDownAction(gesture);
    }
}



//-----------------------------------华丽的分割线---------------------------------
-(float)left_gst{
    return self.frame.origin.x;
}
-(void)setLeft_gst:(float)left_gst{
    CGRect oriRect=self.frame;
    self.frame=CGRectMake(left_gst, oriRect.origin.y, oriRect.size.width, oriRect.size.height);
}

-(float)top_gst{
    return self.frame.origin.y;
}



-(void)setTop_gst:(float)top_gst{
    CGRect oriRect=self.frame;
    self.frame=CGRectMake(oriRect.origin.x, top_gst, oriRect.size.width, oriRect.size.height);
}

-(float)width_gst{
    return self.frame.size.width;
}

-(void)setWidth_gst:(float)width_gst{
    CGRect oriRect=self.frame;
    self.frame=CGRectMake(oriRect.origin.x, oriRect.origin.y, width_gst, oriRect.size.height);
}

-(float)height_gst{
    return self.frame.size.height;
}

-(void)setHeight_gst:(float)height_gst{
    CGRect oriRect=self.frame;
    self.frame=CGRectMake(oriRect.origin.x, oriRect.origin.y, oriRect.size.width,height_gst);
}

-(CGSize)size{
    return self.frame.size;
}
-(void)setTop_:(float)top{
    CGRect oriRect=self.frame;
    self.frame=CGRectMake(oriRect.origin.x, top, oriRect.size.width, oriRect.size.height);
}

-(void)setSize:(CGSize)size{
    CGPoint originPoint=self.frame.origin;
    self.frame=CGRectMake(originPoint.x, originPoint.y, size.width, size.height);
}

-(CGPoint)origin{
    return self.frame.origin;
}
-(void)setOrigin:(CGPoint)origin{
    CGSize oriSize=self.frame.size;
    self.frame=CGRectMake(origin.x, origin.y, oriSize.width, oriSize.height);
}

//-----------------------------------华丽的分割线---------------------------------

-(void)setFullAdjust{
    
    self.autoresizingMask=UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
}



-(YooViewHorizontalAlginMode)horizontalAlignMode{
    
    
    
    bool flexRight=false;
    bool flexLeft=false;
    
    int restIntCount=self.autoresizingMask;
    
    int FlexibleBottom=restIntCount/32;
    if(FlexibleBottom==1){//有FlexibleBottom
        restIntCount=restIntCount-32;
    }
    
    int FlexibleHeight=restIntCount/16;
    if(FlexibleHeight==1){//有FlexibleHeight
        restIntCount=restIntCount-16;
    }
    
    
    int FlexibleTop=restIntCount/8;
    if(FlexibleTop==1){
        restIntCount=restIntCount-8;
    }
    
    int FlexibleRight=restIntCount/4;
    if(FlexibleRight==1){
        restIntCount=restIntCount-4;
        flexRight=YES;
    }
    
    
    int FlexibleWidth =restIntCount/2;
    if(FlexibleWidth==1){
        restIntCount=restIntCount-2;
    }
    
    
    int FlexibleLeft=restIntCount/1;
    if(FlexibleLeft==1){
        flexLeft=YES;
    }
    
    if(flexLeft){
        if(flexRight){
            return YooViewHorizontalAlginModeNone;
        }else{
            return YooViewHorizontalAlginModeRight;
        }
    }else{
        if(flexRight){
            return YooViewHorizontalAlginModeLeft;
        }else{
            return YooViewHorizontalAlginModeLeft;
        }
    }
    
}



-(void)setHorizontalAlignMode:(YooViewHorizontalAlginMode)horizontalAlignMode{
    int restIntCount=self.autoresizingMask;
    int addCount=0;
    if(horizontalAlignMode==YooViewHorizontalAlginModeLeft){
        addCount=4;
    }
    else if(horizontalAlignMode==YooViewHorizontalAlginModeNone){
        addCount=5;
    }
    else if(horizontalAlignMode==YooViewHorizontalAlginModeRight){
        addCount=1;
    }
    
    int minus=0;
    
    int originCount=self.autoresizingMask;
    
    
    int FlexibleBottom=restIntCount/32;
    if(FlexibleBottom==1){//有FlexibleBottom
        restIntCount=restIntCount-32;
    }
    
    int FlexibleHeight=restIntCount/16;
    if(FlexibleHeight==1){//有FlexibleHeight
        restIntCount=restIntCount-16;
    }
    
    
    int FlexibleTop=restIntCount/8;
    if(FlexibleTop==1){
        restIntCount=restIntCount-8;
    }
    
    int FlexibleRight=restIntCount/4;//flexright
    if(FlexibleRight==1){
        restIntCount=restIntCount-4;
        minus+=4;
    }
    
    
    int FlexibleWidth =restIntCount/2;
    if(FlexibleWidth==1){
        restIntCount=restIntCount-2;
    }
    
    
    int FlexibleLeft=restIntCount/1;//flexleft
    if(FlexibleLeft==1){
        minus+=1;
    }
    
    int newCount=originCount-minus+addCount;
    self.autoresizingMask=newCount;
    
}



-(YooViewVerticalAlginMode)verticalAlignMode{
    
    bool flexTop=false;
    bool flexBottom=false;
    
    
    
    int restIntCount=self.autoresizingMask;
    
    int FlexibleBottom=restIntCount/32;
    if(FlexibleBottom==1){//有FlexibleBottom
        restIntCount=restIntCount-32;
        flexBottom=YES;
    }
    
    int FlexibleHeight=restIntCount/16;
    if(FlexibleHeight==1){//有FlexibleHeight
        restIntCount=restIntCount-16;
    }
    
    
    int FlexibleTop=restIntCount/8;
    if(FlexibleTop==1){
        restIntCount=restIntCount-8;
        flexTop=YES;
    }
    
    int FlexibleRight=restIntCount/4;
    if(FlexibleRight==1){
        restIntCount=restIntCount-4;
        
    }
    
    
    int FlexibleWidth =restIntCount/2;
    if(FlexibleWidth==1){
        restIntCount=restIntCount-2;
    }
    
    
    int FlexibleLeft=restIntCount/1;
    if(FlexibleLeft==1){
        
    }
    
    if(flexTop){
        if(flexBottom){
            return YooViewVerticalAlginModeNone;
        }else{
            return YooViewVerticalAlginModeBottom;
        }
    }else{
        if(flexBottom){
            return YooViewVerticalAlginModeTop;
        }else{
            return YooViewVerticalAlginModeTop;
        }
    }
}



-(void)setVerticalAlignMode:(YooViewVerticalAlginMode)verticalAlignMode{
    int restIntCount=self.autoresizingMask;
    int addCount=0;
    if(verticalAlignMode==YooViewVerticalAlginModeTop){
        addCount=32;
    }
    else if(verticalAlignMode==YooViewVerticalAlginModeBottom){
        addCount=8;
    }
    else if(verticalAlignMode==YooViewVerticalAlginModeNone){
        addCount=40;
    }
    
    
    
    int minus=0;
    
    int originCount=self.autoresizingMask;
    
    
    int FlexibleBottom=restIntCount/32;
    if(FlexibleBottom==1){//有FlexibleBottom
        restIntCount=restIntCount-32;
        minus+=32;
    }
    
    int FlexibleHeight=restIntCount/16;
    if(FlexibleHeight==1){//有FlexibleHeight
        restIntCount=restIntCount-16;
    }
    
    
    int FlexibleTop=restIntCount/8;
    if(FlexibleTop==1){
        restIntCount=restIntCount-8;
        minus+=8;
    }
    
    int FlexibleRight=restIntCount/4;//flexright
    if(FlexibleRight==1){
        restIntCount=restIntCount-4;
        
    }
    
    
    int FlexibleWidth =restIntCount/2;
    if(FlexibleWidth==1){
        restIntCount=restIntCount-2;
    }
    
    
    int FlexibleLeft=restIntCount/1;//flexleft
    if(FlexibleLeft==1){
        
    }
    
    int newCount=originCount-minus+addCount;
    self.autoresizingMask=newCount;
}





-(YooViewHorizontalAdjustMode)horizontalAdjustMode{
    
    
    bool flexW=false;
    
    
    
    
    int restIntCount=self.autoresizingMask;
    int FlexibleBottom=restIntCount/32;
    if(FlexibleBottom==1){//有FlexibleBottom
        restIntCount=restIntCount-32;
        
    }
    int FlexibleHeight=restIntCount/16;
    if(FlexibleHeight==1){//有FlexibleHeight
        restIntCount=restIntCount-16;
    }
    
    int FlexibleTop=restIntCount/8;
    if(FlexibleTop==1){
        restIntCount=restIntCount-8;
        
    }
    
    int FlexibleRight=restIntCount/4;
    if(FlexibleRight==1){
        restIntCount=restIntCount-4;
        
    }
    
    
    int FlexibleWidth =restIntCount/2;
    if(FlexibleWidth==1){
        restIntCount=restIntCount-2;
        flexW=YES;
    }
    
    
    int FlexibleLeft=restIntCount/1;
    if(FlexibleLeft==1){
        
    }
    
    if(flexW){
        return YooViewHorizontalAdjustModeAdjust;
    }else{
        return YooViewHorizontalAdjustModeNone;
    }
}

-(void)setHorizontalAdjustMode:(YooViewHorizontalAdjustMode)horizontalAdjustMod{
    int restIntCount=self.autoresizingMask;
    int addCount=0;
    if(horizontalAdjustMod==YooViewHorizontalAdjustModeAdjust){
        addCount=2;
    }
    
    int minus=0;
    
    int originCount=self.autoresizingMask;
    
    int FlexibleBottom=restIntCount/32;
    if(FlexibleBottom==1){//有FlexibleBottom
        restIntCount=restIntCount-32;
        
    }
    
    int FlexibleHeight=restIntCount/16;
    if(FlexibleHeight==1){//有FlexibleHeight
        restIntCount=restIntCount-16;
    }
    
    
    int FlexibleTop=restIntCount/8;
    if(FlexibleTop==1){
        restIntCount=restIntCount-8;
        
    }
    
    int FlexibleRight=restIntCount/4;//flexright
    if(FlexibleRight==1){
        restIntCount=restIntCount-4;
        
    }
    
    int FlexibleWidth =restIntCount/2;
    if(FlexibleWidth==1){
        restIntCount=restIntCount-2;
        minus+=2;
    }
    
    int FlexibleLeft=restIntCount/1;//flexleft
    if(FlexibleLeft==1){
        
    }
    
    int newCount=originCount-minus+addCount;
    self.autoresizingMask=newCount;
}

-(YooViewVerticalAdjustMode)verticalAdjustMode{
    bool flexH=false;
    
    int restIntCount=self.autoresizingMask;
    int FlexibleBottom=restIntCount/32;
    if(FlexibleBottom==1){//有FlexibleBottom
        restIntCount=restIntCount-32;
        
    }
    int FlexibleHeight=restIntCount/16;
    if(FlexibleHeight==1){//有FlexibleHeight
        restIntCount=restIntCount-16;
        flexH=YES;
    }
    
    int FlexibleTop=restIntCount/8;
    if(FlexibleTop==1){
        restIntCount=restIntCount-8;
        
    }
    
    int FlexibleRight=restIntCount/4;
    if(FlexibleRight==1){
        restIntCount=restIntCount-4;
        
    }
    
    
    int FlexibleWidth =restIntCount/2;
    if(FlexibleWidth==1){
        restIntCount=restIntCount-2;
        
    }
    
    
    int FlexibleLeft=restIntCount/1;
    if(FlexibleLeft==1){
        
    }
    
    if(flexH){
        return YooViewVerticalAdjustModeAdjust;
        
    }else{
        return YooViewVerticalAdjustModeNone;
    }
}
-(void)setVerticalAdjustMode:(YooViewVerticalAdjustMode)verticalAdjustMode{
    int restIntCount=self.autoresizingMask;
    int addCount=0;
    if(verticalAdjustMode==YooViewVerticalAdjustModeAdjust){
        addCount=16;
    }
    
    
    
    
    
    int minus=0;
    
    int originCount=self.autoresizingMask;
    
    
    int FlexibleBottom=restIntCount/32;
    if(FlexibleBottom==1){//有FlexibleBottom
        restIntCount=restIntCount-32;
    }
    
    int FlexibleHeight=restIntCount/16;
    if(FlexibleHeight==1){//有FlexibleHeight
        restIntCount=restIntCount-16;
        minus+=16;
    }
    
    
    int FlexibleTop=restIntCount/8;
    if(FlexibleTop==1){
        restIntCount=restIntCount-8;
        
    }
    
    int FlexibleRight=restIntCount/4;//flexright
    if(FlexibleRight==1){
        restIntCount=restIntCount-4;
        
    }
    
    
    int FlexibleWidth =restIntCount/2;
    if(FlexibleWidth==1){
        restIntCount=restIntCount-2;
        
    }
    
    
    int FlexibleLeft=restIntCount/1;//flexleft
    if(FlexibleLeft==1){
        
    }
    
    
    int newCount=originCount-minus+addCount;
    self.autoresizingMask=newCount;
}
//-----------------------------------华丽的分割线---------------------------------

-(void)addSubviewAtCenter:(UIView *)view{
    float w=self.width_gst;
    float h=self.height_gst;
    view.left_gst=(w-view.width_gst)/2.;
    view.top_gst=(h-view.height_gst)/2.;
    [self addSubview:view];
}


@end
