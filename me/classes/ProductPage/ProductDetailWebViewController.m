//
//  ProductDetailWebViewController.m
//  me
//
//  Created by jam on 2018/1/7.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "ProductDetailWebViewController.h"

@interface ProductDetailWebViewController ()

@end

@implementation ProductDetailWebViewController

-(instancetype)initWithProductId:(NSString *)productId token:(NSString *)token
{
    self=[super init];
    self.productId=productId;
    self.token=token;
    return self;
}

- (void)viewDidLoad {
    
    NSString* str=[ZZUrlTool fullUrlWithTail:HTML_GoodDetail];
    str=[NSString stringWithFormat:@"%@&id=%@&access_token=%@",str,self.productId,self.token];
    self.url=[NSURL URLWithString:str];
    
    [super viewDidLoad];
    self.title=@"商品详情";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
