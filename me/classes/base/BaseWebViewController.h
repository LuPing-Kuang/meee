//
//  BaseWebViewController.h
//  yangsheng
//
//  Created by jam on 17/7/8.
//  Copyright © 2017年 jam. All rights reserved.
//

#define HTML_GoodDetail @"/app/index.php?i=1&c=entry&m=ewei_shopv2&do=api&r=goods.detailpage"

@interface BaseWebViewController : UIViewController

-(instancetype)initWithUrl:(NSURL*)url;
-(instancetype)initWithHtml:(NSString*)html;

@property (nonatomic,assign) NSInteger idd;
@property (nonatomic,strong) NSString* type;
@property (nonatomic,strong) NSURL* url;
@property (nonatomic,strong) NSString* html;
@property (nonatomic,strong) UIView* webUIView;

@property (nonatomic,weak) UIView* bottomView;
@property (nonatomic,assign) CGRect bottomBgBounds;
@property (nonatomic,assign,readonly) CGFloat bottomSafeInset;

@property (nonatomic,strong) NSMutableDictionary* params;

@end
