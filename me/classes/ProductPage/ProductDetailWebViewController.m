//
//  ProductDetailWebViewController.m
//  me
//
//  Created by jam on 2018/1/7.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "ProductDetailWebViewController.h"
#import "ProductOrderComfirmTableViewController.h"
#import "CartPageViewController.h"

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
    if (self.token) {
        str=[NSString stringWithFormat:@"%@&id=%@&access_token=%@",str,self.productId,self.token];
    }else{
        str=[NSString stringWithFormat:@"%@&id=%@",str,self.productId];
    }
    
    self.url=[NSURL URLWithString:str];
    
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"商品详情";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString* abs=request.URL.absoluteString;
    NSLog(@"%@",abs);
    
    //ht tp://192.168.1.131:8094//app/index.php?i=1&c=entry&m=ewei_shopv2&do=mobile&r=order.create&mid=3292&id=23&optionid=0&total=1&giftid&liveid=0
    //create order
    
    
    //app9vcom:%23%23//getOrder/?./index.php?i=1&c=entry&m=ewei_shopv2&do=api&r=order.create&mid=3292&id=3&optionid=19&total=1&gdid=427&giftid&liveid=0&access_token=666
    //create order 2
    
    //h ttp://192.168.1.131:8094//app/index.php?i=1&c=entry&m=ewei_shopv2&do=mobile&r=member.cart&mid=3292
    //cart
    
    NSString* valueR=[abs stringValueFromUrlParamsKey:@"r"];
    if ([abs containsString:@"app9vcom"]&&[abs containsString:@"getOrder"])
    {
        NSLog(@"creat 2");
        [self actionWithCreateOrderUrl:abs];
        return NO;
    }
    else if ([valueR isEqualToString:@"order.create"]) {
        NSLog(@"creat");
        [self actionWithCreateOrderUrl:abs];
        return NO;
    }
    else if([valueR isEqualToString:@"member.cart"]) {
        NSLog(@"cart ");
        if (has_login) {
            [self actionWithCartUrl:abs];
        }else{
            [self.navigationController popViewControllerAnimated:NO];
            UIViewController* log=[[UIStoryboard storyboardWithName:@"MyPage" bundle:nil]instantiateViewControllerWithIdentifier:@"LoginViewController"];
            [self presentViewController:log animated:YES completion:nil];
        }
        return NO;
    }
    else if([valueR isEqualToString:@"account.login"]) {
        NSLog(@"account.login ");
        [self.navigationController popViewControllerAnimated:NO];
        UIViewController* log=[[UIStoryboard storyboardWithName:@"MyPage" bundle:nil]instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self presentViewController:log animated:YES completion:nil];
        return NO;
    }
    else if ([valueR isEqualToString:@"member.cart.add"]) {
        NSLog(@"member.cart.add ");
        [[NSNotificationCenter defaultCenter] postNotificationName:UserNeed_RefreshCart_Notification object:nil];
        return NO;
    }
    
    return YES;
}

#pragma mark action with url

-(void)actionWithCreateOrderUrl:(NSString*)url
{
    NSString* access_token=[UserModel token];
    if (access_token.length==0) {
        NSLog(@"did not login");
        return;
    }
    
    ProductOrderComfirmTableViewController* orderComfirm=[[UIStoryboard storyboardWithName:@"ProductPage" bundle:nil]instantiateViewControllerWithIdentifier:@"ProductOrderComfirmTableViewController"];
    orderComfirm.url=url;
    [self.navigationController pushViewController:orderComfirm animated:YES];
}

-(void)actionWithCartUrl:(NSString*)url
{
    CartPageViewController* cart=[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"CartPageViewController"];
    [self.navigationController pushViewController:cart animated:YES];
}

@end
