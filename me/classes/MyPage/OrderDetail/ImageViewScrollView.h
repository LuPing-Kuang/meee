//
//  ImageViewScrollView.h
//  me
//
//  Created by 邝路平 on 2018/4/1.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewScrollView : UIView



@property (nonatomic,strong) NSMutableArray *ImageArr;

- (void)addImageArr:(NSArray*)ImageArr;

@end
