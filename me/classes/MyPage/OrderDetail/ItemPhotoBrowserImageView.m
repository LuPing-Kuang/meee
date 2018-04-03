//
//  ItemPhotoBrowserImageView.m
//  main
//
//  Created by URoad_MP on 15/5/26.
//  Copyright (c) 2015年 com.URoad. All rights reserved.
//

#import "ItemPhotoBrowserImageView.h"
#import "LZImageZoomView.h"
@interface ItemPhotoBrowserImageView()
@property (strong, nonatomic)IBOutlet LZImageZoomView *imgV;

@end

@implementation ItemPhotoBrowserImageView

- (id)initViewWithEty:(NSString *)urlString{
    self = LOAD_XIB_CLASS(ItemPhotoBrowserImageView);
    if (self) {
        _imgV = [[LZImageZoomView alloc]initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight) byUrlString:urlString];
        _imgV.center = CGPointMake(_imgV.center.x, UIScreenHeight/2);
        [_imgV setFullAdjust];
        _imgV.tapAction=^(UITapGestureRecognizer*tap){
            
        };
        
        [self addSubview:_imgV];
    }
    return self;
}

- (id)initViewWithImage:(UIImage *)img{
    self = LOAD_XIB_CLASS(ItemPhotoBrowserImageView);
    if (self) {
        [_imgV loadImage:img];
        __weak typeof(self) weakself = self;
        _imgV.tapAction=^(UITapGestureRecognizer*tap){
            if (weakself.tapBlock) {
                weakself.tapBlock();
            }
        };
        
        [self addSubview:_imgV];
    }
    return self;

}


- (void)startLoad{
//    [_imgV loadImage];
}

@end
