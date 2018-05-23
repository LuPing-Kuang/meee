//
//  BaseWebViewController.m
//  yangsheng
//
//  Created by jam on 17/7/8.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "BaseWebViewController.h"
#import "ZZUrlTool.h"
#import "ZZHttpTool.h"
#import "UserModel.h"
#import "ProductPageHttpTool.h"
//#import "WBWebProgressBar.h"

@interface BaseWebViewController ()
{
    UIView* bottomBg;
    CGFloat bottomSafe;
}
@property (nonatomic,strong) UIWebView* ios8WebView;

@end

@implementation BaseWebViewController
{
    UIImageView* loadingImageView;
    UIActivityIndicatorView* loadingIndicator;
}

-(CGFloat)bottomSafeInset
{
    return bottomSafe;
}

#if XcodeSDK11
-(void)viewSafeAreaInsetsDidChange
{
    [super viewSafeAreaInsetsDidChange];
    if ([self.view respondsToSelector:@selector(safeAreaInsets)]) {
        if (@available(iOS 11.0, *)) {
            UIEdgeInsets est=[self.view safeAreaInsets];
            bottomSafe=est.bottom;
            
            //            self.tableView.contentInset=UIEdgeInsetsMake(0, 0, 64, 0);
            [self relayoutViews];
        } else {
            // Fallback on earlier versions
        }
    }
}
#endif

-(instancetype)initWithUrl:(NSURL *)url
{
    self=[super init];
    _url=url;
    return self;
}

-(instancetype)initWithHtml:(NSString *)html
{
    self=[super init];
    _html=html;
    return self;
}

#pragma mark bottom views

-(void)setBottomView:(UIView *)bottomView
{
    _bottomView=bottomView;
    if (bottomView!=nil) {
        [bottomView removeFromSuperview];
//        if (bottomBg==nil) {
        [bottomBg removeFromSuperview];
            bottomBg=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-bottomView.frame.size.height-bottomSafe, self.view.frame.size.width, 200)];
            bottomBg.backgroundColor=[UIColor whiteColor];
            [self.view addSubview:bottomBg];
            
            UIView* line=[[UIView alloc]initWithFrame:CGRectMake(0, 0, bottomBg.frame.size.width, 1/[[UIScreen mainScreen]scale])];
            line.backgroundColor=gray_8;
            [bottomBg addSubview:line];
//        }
        bottomBg.frame=CGRectMake(0, self.view.frame.size.height-bottomView.frame.size.height-bottomSafe, self.view.frame.size.width, 200);
//        [bottomBg removeAllSubviews];
        [bottomBg insertSubview:bottomView atIndex:0];
//        bottomView.frame=bottomBg.bounds;
        [self performSelector:@selector(relayoutViews) withObject:nil afterDelay:0.01];
    }
}

-(CGRect)bottomBgBounds
{
    return CGRectMake(0, 0, self.view.frame.size.width, 64);
}

#pragma mark getters

-(NSMutableDictionary*)params
{
    if(_params.count==0)
    {
        _params=[NSMutableDictionary dictionary];
    }
    return _params;
}

-(UIView*)webUIView
{
    return self.ios8WebView;
}

-(UIWebView*)ios8WebView
{
    if (_ios8WebView==nil) {
        _ios8WebView=[[UIWebView alloc]initWithFrame:self.view.bounds];
        
        //uiwebview's
        _ios8WebView.dataDetectorTypes=UIDataDetectorTypeNone;
        _ios8WebView.delegate=self;
        
        _ios8WebView.scrollView.showsVerticalScrollIndicator=NO;
        _ios8WebView.scrollView.showsHorizontalScrollIndicator=NO;
        
        //wkwebview's
        //        _ios8WebView.navigationDelegate=self;
        //        _ios8WebView.UIDelegate=self;
        [self.view addSubview:_ios8WebView];
    }
    NSLog(@"uiwebview");
    return _ios8WebView;
}


#pragma mark views


-(void)dealloc
{
    self.ios8WebView.delegate=nil;
    
    NSLog(@"%@ deal",NSStringFromClass([self class]));
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self relayoutViews];
}

-(void)relayoutViews
{
    self.ios8WebView.frame=self.view.bounds;
    if (self.bottomView) {
//        self.ios8WebView.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-self.bottomView.frame.size.height-bottomSafe);
        
        bottomBg.frame=CGRectMake(0, self.view.frame.size.height-self.bottomView.frame.size.height-bottomSafe, self.view.frame.size.width, self.bottomView.frame.size.height+bottomSafe);
        self.ios8WebView.scrollView.contentInset=UIEdgeInsetsMake(0, 0, bottomBg.frame.size.height-bottomSafe, 0);
    }
    else
    {
//        self.ios8WebView.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-bottomSafe);
        self.ios8WebView.scrollView.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self setupSubViews];
    
    loadingIndicator=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    loadingIndicator.center=CGPointMake(self.view.center.x, 64);
    loadingIndicator.hidesWhenStopped=YES;
//    loadingIndicator.backgroundColor=[UIColor redColor];
    [loadingIndicator stopAnimating];
    [self.view addSubview:loadingIndicator];
    
    NSString *filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"hhh.txt"];
    
    NSError* err=nil;
    NSString* mTxt=[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&err];
    [self.ios8WebView loadHTMLString:mTxt baseURL:nil];
    
    if(self.html.length>0)
    {
        [self loadHtml:self.html];
    }
    else if (self.url) {
        NSString* abs=[self.url absoluteString];
        
        if(![abs containsString:@"?"])
        {
            [self.params setValue:[NSNumber numberWithInteger:self.idd] forKey:@"id"];
            if (self.type.length>0) {
                [self.params setValue:self.type forKey:@"type"];
            }
            [self.params setValue:@"ios" forKey:@"sys"];
            [self.params setValue:[NSNumber numberWithInteger:[[NSDate date]timeIntervalSince1970]] forKey:@"time"];
            NSString* access_token=[UserModel token];
            if (access_token.length>0) {
                [self.params setValue:access_token forKey:@"access_token"];
            }
            
            [self.params setValue:@"1" forKey:@"html"];
            
            NSArray* keys=[self.params allKeys];
            NSMutableArray* keysAndValues=[NSMutableArray array];
            for (NSString* key in keys) {
                NSString* value=[self.params valueForKey:key];
                
                NSString* kv=[NSString stringWithFormat:@"%@=%@",key,value];
                [keysAndValues addObject:kv];
            }
            
            NSString* body=[keysAndValues componentsJoinedByString:@"&"];
            
            if (body.length>0) {
                if ([abs containsString:[ZZUrlTool main]])
                {
                    abs=[NSString stringWithFormat:@"%@%@%@",abs,[abs containsString:@"?"]?@"":@"?",body];
                }
            }
            self.url=[NSURL URLWithString:abs];
        }
//        NSLog(@"webview:  %@",abs);
        NSURLRequest* req=[NSURLRequest requestWithURL:self.url];
        
        [self.ios8WebView performSelector:@selector(loadRequest:) withObject:req afterDelay:0.5];
        
        [loadingIndicator removeFromSuperview];
        [self.view addSubview:loadingIndicator];
        [loadingIndicator startAnimating];
        
    }
    
    if (self.isNeedQuery) {
        [self queryPayResult];
    }
}

#pragma mark action

-(void)loadHtml:(NSString*)htmlString
{
    [self.ios8WebView loadHTMLString:htmlString baseURL:self.url];

}

#pragma mark --old uiwebview delegate

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [loadingIndicator startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [loadingIndicator stopAnimating];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    return YES;
}


- (void)setupSubViews {
    UIImage *leftButtonImg = [UIImage imageNamed:@"back"];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:leftButtonImg forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0,0,44,44);
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 44-leftButtonImg.size.width);
    [backBtn addTarget:self action:@selector(naviBackAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *naviBack = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    self.navigationItem.leftBarButtonItem = naviBack;
}


- (void)naviBackAction{
    
    if (self.ios8WebView.canGoBack) {
        [self.ios8WebView goBack];
    }else {
        [self.navigationController popViewControllerAnimated:true];
    }
    
}





- (void)queryPayResult{
    
    MJWeakSelf;
    [ProductPageHttpTool queryResultWithOrderNum:self.orderId WithCompleted:^(id result, BOOL success) {
        
        if (success) {
            
            if ([result isKindOfClass:[NSString class]] && [result isEqualToString:@"1"]) {
                [HUDManager showSuccessMsg:@"支付成功"];
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            }else{
                [weakSelf queryPayResult];
            }
            
        }else{
            
        }
        
    }];
    
    
}


@end
