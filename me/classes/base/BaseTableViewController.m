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
//    lastCount=_dataSource.count;
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
//    if (_pageSize<=0) {
//        _pageSize=30;
//    }
//    return _pageSize;
    return 30;
}

#pragma mark viewcontrollers

- (void)viewDidLoad {
    [super viewDidLoad];
    
    hasNetwork=NO;
    
    self.shouldLoadMore=YES;
//    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    self.tableView.estimatedRowHeight=100;
    self.tableView.rowHeight=UITableViewAutomaticDimension;
    
    self.refreshControl=[[UIRefreshControl alloc]init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    
    self.tableView.tableFooterView=[[UIView alloc]init];
//    [self showLoadMoreView];
    
//    self.tableView.separatorColor=[UIColor groupTableViewBackgroundColor];
    if (self.tableView.style==UITableViewStyleGrouped) {
        self.tableView.backgroundColor=gray_9;
    }
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(networkStateChange:) name:kReachabilityChangedNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadDataNotification:) name:UITableViewReloadDataNotification object:nil];

//    [self.refreshControl beginRefreshing];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    NSLog(@"%@ deal",NSStringFromClass([self class]));
}

-(void)scheduleRefresh
{
//    NSLog(@"%@ scheduleRefreshing",NSStringFromClass([self class]));
//    [self.refreshControl beginRefreshing];
    lastCount=0;
    [self refresh];
}

-(void)reloadDataNotification:(NSNotification*)notification
{
    NSDictionary* userDef=notification.userInfo;
    UITableView* tableVi=[userDef valueForKey:@"tableView"];
    if (tableVi==self.tableView) {
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
}



#pragma mark - Refresh And Load More

-(void)firstLoad
{
    
}

-(void)refresh
{
    [self.refreshControl performSelector:@selector(endRefreshing) withObject:nil afterDelay:0.1];
}

-(void)stopRefreshAfterSeconds
{
//    [self.refreshControl performSelector:@selector(endRefreshing) withObject:nil afterDelay:2];
}

-(void)loadMore
{
    [loadMoreFooter performSelector:@selector(endLoadingWithText:) withObject:@"" afterDelay:0.1];
}

-(void)reloadWithDictionary:(NSDictionary*)dict
{
    
}

-(void)tableViewReloadData
{
    [self.tableView reloadData];
}

#pragma mark - Table view data source


//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UIView* bg=[[UIView alloc]initWithFrame:cell.bounds];
//    bg.backgroundColor=[UIColor groupTableViewBackgroundColor];
//    cell.selectedBackgroundView=bg;
////    cell.selectionStyle=UITableViewCellSelectionStyleNone;
////    if ((indexPath.section==[tableView numberOfSections]-1)&&(indexPath.row==[tableView numberOfRowsInSection:indexPath.section]-1)) {
////        self.shouldLoadMore=_dataSource.count!=lastCount;
////        lastCount=_dataSource.count;
//////        NSString* loadmoreText=@"正在加载...";
////        if (self.shouldLoadMore) {
////            [self loadMore];
////        }
//////        else
//////        {
//////            loadmoreText=@"";
//////        }
//////        [self setNothingFooterViewWithText:loadmoreText];
////    }
//}

#pragma mark - table view delegate

//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UIView* bgView=cell.selectedBackgroundView;
//    if (!bgView) {
//        bgView=[[UIView alloc]init];
//    }
//    bgView.frame=cell.bounds;
//    
//    bgView.backgroundColor=[UIColor redColor];
//    cell.selectedBackgroundView=bgView;
//    
//    bgView=cell.backgroundView;
//    if (!bgView) {
//        bgView=[[UIImageView alloc]init];
//    }
//    
//    bgView.backgroundColor=[UIColor whiteColor];
//    bgView.frame=cell.bounds;
//    cell.backgroundView=bgView;
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableView.style==UITableViewStylePlain) {
        return 0.0001;
    }
    return 8;
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
//    NSLog(@"advertise:%@ did selected index:%ld",advHeader,(long)index);
//    if (index<self.advsArray.count) {
//        NSObject* ob=[self.advsArray objectAtIndex:index];
//        if ([ob isKindOfClass:[BaseModel class]]) {
////            BaseModel* mo=(BaseModel*)ob;
////            NSLog(@"adv type:%@, id:%@",mo.name,mo.idd);
//        }
//    }
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

@end
