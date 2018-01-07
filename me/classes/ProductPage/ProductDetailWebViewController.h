//
//  ProductDetailWebViewController.h
//  me
//
//  Created by jam on 2018/1/7.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "BaseWebViewController.h"

@interface ProductDetailWebViewController : BaseWebViewController

@property (nonatomic,strong) NSString* productId;
@property (nonatomic,strong) NSString* token;

-(instancetype)initWithProductId:(NSString*)productId token:(NSString*)token;

@end
