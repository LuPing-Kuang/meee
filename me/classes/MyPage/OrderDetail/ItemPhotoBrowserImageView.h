//
//  ItemPhotoBrowserImageView.h
//  main
//
//  Created by URoad_MP on 15/5/26.
//  Copyright (c) 2015年 com.URoad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemPhotoBrowserImageView : UIView
- (id)initViewWithEty:(NSString *)urlString;

- (id)initViewWithImage:(UIImage *)img;

- (void)startLoad;

@property (nonatomic,copy) void(^tapBlock)();

@end
