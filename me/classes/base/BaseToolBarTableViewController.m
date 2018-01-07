//
//  BaseToolBarTableViewController.m
//  zhanmao
//
//  Created by bangju on 2017/10/24.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "BaseToolBarTableViewController.h"

@interface BaseToolBarTableViewController ()
{
    BOOL showingKeyboard;
    CGFloat bottomSafe;
}

@property (nonatomic,strong) UIView* bottomToolBar;

@end

@implementation BaseToolBarTableViewController

#if XcodeSDK11
-(void)viewSafeAreaInsetsDidChange
{
    [super viewSafeAreaInsetsDidChange];
    if ([self.view respondsToSelector:@selector(safeAreaInsets)]) {
        if (@available(iOS 11.0, *)) {
            UIEdgeInsets est=[self.view safeAreaInsets];
            bottomSafe=est.bottom;
            
//            self.tableView.contentInset=UIEdgeInsetsMake(0, 0, 64, 0);
            [self scrollViewDidScroll:self.tableView];
        } else {
            // Fallback on earlier versions
        }
    }
}
#endif

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIToolbar* too=[[UIToolbar alloc]init];;
//    too.frame=CGRectMake(0, 0, 100, 64);
//    [self.tableView addSubview:too];
////    self.navigationController.toolbarHidden=NO;
//    return;
//    self.bottomLayoutGuide;
    
    self.tableView.contentInset=UIEdgeInsetsMake(0, 0, 49, 0);
    
    self.bottomToolBar=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, self.tableView.contentInset.bottom+bottomSafe)];
    self.bottomToolBar.backgroundColor=[UIColor whiteColor];
    self.bottomToolBar.autoresizesSubviews=NO;
    [self.tableView addSubview:self.bottomToolBar];
    
    UIView* line=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bottomToolBar.frame.size.width, 1/[[UIScreen mainScreen]scale])];
    line.backgroundColor=gray_8;
    [self.bottomToolBar addSubview:line];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShows:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHides:) name:UIKeyboardDidHideNotification object:nil];
    
    [self performSelector:@selector(scrollViewDidScroll:) withObject:self.tableView afterDelay:0.01];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self performSelector:@selector(scrollViewDidScroll:) withObject:self.tableView afterDelay:0.01];
}

#pragma mark keyboards

-(void)keyboardShows:(NSNotification*)noti
{
    //    NSLog(@"%@",noti);
    
    //UIKeyboardFrameEndUserInfoKey;
    //UIKeyboardAnimationDurationUserInfoKey;
    //UIKeyboardAnimationCurveUserInfoKey;
    
    showingKeyboard=YES;
}

-(void)keyboardHides:(NSNotification*)noti
{
    //    NSLog(@"%@",noti);
    
    showingKeyboard=NO;
    [self scrollViewDidScroll:self.tableView];
}

#pragma mark actions

-(void)setBottomSubView:(UIView *)view
{
    [self.bottomToolBar removeAllSubviews];
    [view removeFromSuperview];
    [self.bottomToolBar insertSubview:view atIndex:0];
    
    UIView* line=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bottomToolBar.frame.size.width, 1/[[UIScreen mainScreen]scale])];
    line.backgroundColor=gray_8;
    [self.bottomToolBar addSubview:line];
}

-(void)goToCustom
{
    [self bottomToolBarButtonClicked];
}

-(void)bottomToolBarButtonClicked
{
    
}

-(void)setBottomBarHidden:(BOOL)hidden
{
    self.bottomToolBar.hidden=hidden;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (showingKeyboard) {
        return;
    }
    CGFloat offy=scrollView.contentOffset.y;
    CGFloat h=scrollView.frame.size.height;
    CGFloat b=scrollView.contentInset.bottom;
    
    CGRect appf=self.bottomToolBar.frame;
    appf.origin.y=offy+h-b-bottomSafe;
    appf.size.height=b+bottomSafe;
    self.bottomToolBar.frame=appf;
    
    [self.bottomToolBar removeFromSuperview];
    [self.tableView addSubview:self.bottomToolBar];
}

-(CGRect)bottomFrame
{
    CGRect fr=self.bottomToolBar.bounds;
    fr.size.height=fr.size.height-bottomSafe;
    return fr;
}

@end
