//
//  ItemPhotoBrowserController.h
//  main
//
//  Created by URoad_MP on 15/5/26.
//  Copyright (c) 2015年 com.URoad. All rights reserved.
//



typedef void (^DeleteItemBlock) (NSInteger);

@interface ItemPhotoBrowserController : UIViewController

- (id)initControllerWithArray:(NSArray *)array withSelectIndex:(NSInteger)index needDelBtn:(BOOL)IsNeed;

@property (nonatomic,strong)DeleteItemBlock block;
@end
