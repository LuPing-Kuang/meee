//
//  MyfavouriteModel.h
//  me
//
//  Created by KLP on 2018/1/27.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyfavouriteModel : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *goodsid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *thumb;
@property (nonatomic, copy) NSString *marketprice;
@property (nonatomic, copy) NSString *productprice;
@property (nonatomic, copy) NSString *merchid;

//非服务器字段
@property (nonatomic, assign) BOOL isSelected;


@end



