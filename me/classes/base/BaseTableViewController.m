//
//  BaseTableViewController.m
//  yangsheng
//
//  Created by jam on 17/7/6.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "BaseTableViewController.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "BaseLoadMoreFooterView.h"

@interface BaseTableViewController ()<BaseLoadMoreFooterViewDelegate>
{
    AdvertiseView* advHeader;
    NSInteger lastCount;
    BOOL hasNetwork;
    BOOL isManualReload;
    BaseLoadMoreFooterView* loadMoreFooter;
}
@end

@implementation BaseTableViewController

#pragma mark getters

-(NSMutableArray*)dataSource
{
    if (_dataSource==nil) {
        _dataSource=[NSMutableArray array];
    }
    return _dataSource;
}

-(NSMutableArray*)advsArray
{
    if (_advsArray==nil) {
        _advsArray=[NSMutableArray array];
    }
    return _advsArray;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(NSInteger)pageSize
{
    return 30;
}

#pragma mark viewcontrollers

- (void)viewDidLoad {
    [super viewDidLoad];
    
    hasNetwork=NO;
    
    self.shouldLoadMore=YES;

    self.tableView.estimatedRowHeight=100;
    self.tableView.rowHeight=UITableViewAutomaticDimension;
    self.tableView.separatorInset=UIEdgeInsetsMake(0, 15, 0, 0);
    
    self.refreshControl=[[UIRefreshControl alloc]init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    
    self.tableView.tableFooterView=[[UIView alloc]init];

    if (self.tableView.style==UITableViewStyleGrouped) {
        self.tableView.backgroundColor=gray_9;
    }
    

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    NSLog(@"%@ dealloc",NSStringFromClass([self class]));
}

-(void)scheduleRefresh
{

    lastCount=0;
    [self refresh];
}


- (void)endRefresh{
    if (isManualReload) {
        NSLog(@"%@ reloaded data",NSStringFromClass([self class]));
        [self.refreshControl performSelector:@selector(endRefreshing) withObject:nil afterDelay:1];
    }
    else
    {
        isManualReload=YES;
    }
    NSString* loadmoreText=@"加载更多";
    if (lastCount==self.dataSource.count&&!self.refreshControl.refreshing) {
        loadmoreText=@"没有更多了";
    }
    [loadMoreFooter performSelector:@selector(endLoadingWithText:) withObject:loadmoreText afterDelay:0.01];
    lastCount=self.dataSource.count;
}

#pragma mark - Refresh And Load More
-(void)refresh
{
    [self.refreshControl performSelector:@selector(endRefreshing) withObject:nil afterDelay:0.1];
}

-(void)stopRefreshAfterSeconds
{
    [self.refreshControl performSelector:@selector(endRefreshing) withObject:nil afterDelay:1];
}

-(void)loadMore
{
    [loadMoreFooter performSelector:@selector(endLoadingWithText:) withObject:@"" afterDelay:0.1];
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableView.style==UITableViewStylePlain) {
        return 0.0001;
    }
    return 12;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (scrollView==self.tableView) {
        [self.tableView endEditing:YES];
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGPoint contentOffset = scrollView.contentOffset;
    CGRect frame = scrollView.frame;
    CGSize contentSize=scrollView.contentSize;
    
    CGFloat maa=20;
    
    if (contentOffset.y >= contentSize.height - frame.size.height -maa || contentSize.height < frame.size.height-maa)
    {
        if (loadMoreFooter.loading==NO&&loadMoreFooter.superview) {
            NSLog(@"should loadmore");
            [self loadMoreFooterViewShouldStartLoadMore:loadMoreFooter];
        }
    }
}

#pragma mark - Advertiseview header & delegate

-(void)setAdvertiseHeaderViewWithPicturesUrls:(NSArray *)picturesUrls
{
    if (!advHeader) {
        
        advHeader=[AdvertiseView defaultAdvertiseView];
        advHeader.delegate=self;
    }
    
    advHeader.picturesUrls=picturesUrls;
    self.tableView.tableHeaderView=picturesUrls.count>0?advHeader:nil;
}

-(void)advertiseView:(AdvertiseView *)adver didSelectedIndex:(NSInteger)index
{

}

#pragma mark - loadmore something

-(void)showLoadMoreView
{
    if (loadMoreFooter==nil) {
        loadMoreFooter=[BaseLoadMoreFooterView defaultFooter];
        loadMoreFooter.delegate=self;
    }
    self.tableView.tableFooterView=nil;
    self.tableView.tableFooterView=loadMoreFooter;
}

-(void)hideLoadMoreView
{
    if (self.tableView.tableFooterView==loadMoreFooter) {
        self.tableView.tableFooterView=nil;
    }
}

-(void)loadMoreFooterViewShouldStartLoadMore:(BaseLoadMoreFooterView *)footerView
{
    footerView.loading=YES;
    [self loadMore];
}


#pragma mark -
#pragma mark - 提示

- (void)startAnimation{
    [HUDManager showLoading:@"加载中..."];
}
- (void)stopAnimation{
    [HUDManager dismiss];
}
-(void)showMessage:(NSString *)msg{
    [HUDManager showMessage:msg];
}
- (void)showErrorMsg:(NSString *)errmsg{
    [HUDManager showErrorMsg:errmsg];
}
- (void)showSuccessMsg:(NSString *)msg{
    [HUDManager showSuccessMsg:msg];
}
- (void)showLoading:(NSString *)msg{
    [HUDManager showLoading:msg];
}


-(void)showSystemAlertWithTitle:(NSString *)title
                        message:(NSString*)message
                    buttonTitle:(NSString *)btntitle
                needDestructive:(BOOL)needDistory
                    cancleBlock: (void (^)(UIAlertAction *action))cancleBlock
                       btnBlock:(void (^)(UIAlertAction *action))btnBlock {
    
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:cancleBlock];
    
    UIAlertActionStyle style = UIAlertActionStyleDefault;
    if (needDistory) {
        style = UIAlertActionStyleDestructive;
    }else{
        style = UIAlertActionStyleDefault;
    }
    
    UIAlertAction *act2 = [UIAlertAction actionWithTitle:btntitle style:style handler:btnBlock];
    
    [vc addAction:act1];
    [vc addAction:act2];
    [self presentViewController:vc animated:true completion:nil];
    
    
}


- (void)showloginVc{
    UIViewController* log=[[UIStoryboard storyboardWithName:@"MyPage" bundle:nil]instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self presentViewController:log animated:YES completion:nil];
}

- (void)pushToStoryBoardName:(NSString*)name Idetifier:(NSString*)idetifier{
    
    if (name == nil || idetifier == nil) {
        return;
    }
    
    UIViewController *vc = [[UIStoryboard storyboardWithName:name bundle:nil] instantiateViewControllerWithIdentifier:idetifier];
    
    if (vc) {
        [self.navigationController pushViewController:vc animated:true];
    }
    
    
}



@end
