//
//  BaseCollectionViewController.m
//  yangsheng
//
//  Created by Macx on 17/7/14.
//  Copyright © 2017年 jam. All rights reserved.
//

#import "BaseCollectionViewController.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import "BaseLoadMoreFooterView.h"

@interface BaseCollectionViewController ()<BaseLoadMoreFooterViewDelegate>
{
    UIRefreshControl* refreshControl;
    BOOL hasNetwork;
    NSInteger lastCount;
    
    BOOL isManualReload;
    BaseLoadMoreFooterView* loadMoreFooter;
}

@property (nonatomic,strong) AdvertiseView* advHeader;
@end

@implementation BaseCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    hasNetwork=NO;
    
    self.shouldLoadMore=YES;
    
//    self.automaticallyAdjustsScrollViewInsets=NO;
    
    refreshControl=[[UIRefreshControl alloc]init];
    [self.collectionView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadSectionsNotification:) name:UICollectionViewReloadSectionsNotification object:nil];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    self.collectionView.collectionViewLayout=self.collectionViewLayout;
    self.collectionView.bounces=YES;
    self.collectionView.alwaysBounceVertical=YES;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"h"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"f"];
    
//    [self setAdvertiseHeaderViewWithPicturesUrls:@[@"",@""]];
    // Do any additional setup after loading the view.
    
    [self showLoadMoreView];
    self.collectionView.backgroundColor=[UIColor whiteColor];
}

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

-(NSInteger)pageSize
{
//    if (_pageSize<=0) {
//        NSDictionary* d=[ZZHttpTool pageParams];
//        
//        _pageSize=[[d valueForKey:@"pagesize"]integerValue];
//    }
//    return _pageSize;
    return 30;
}



-(void)reloadSectionsNotification:(NSNotification*)notification
{
    NSDictionary* userDef=notification.userInfo;
    UICollectionView* collecVi=[userDef valueForKey:@"collectionView"];
    if (collecVi==self.collectionView) {

        NSLog(@"%@ reloaded sections",NSStringFromClass([self class]));
        [refreshControl performSelector:@selector(endRefreshing) withObject:nil afterDelay:1];

        NSString* loadmoreText=@"加载更多";
        if (lastCount==self.dataSource.count&&!refreshControl.refreshing) {
            loadmoreText=@"没有更多了";
        }
        [loadMoreFooter performSelector:@selector(endLoadingWithText:) withObject:loadmoreText afterDelay:1];
        lastCount=self.dataSource.count;
    }
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    NSLog(@"%@ deal",NSStringFromClass([self class]));
}

#pragma mark - Refresh And Load More

-(void)firstLoad
{
    
}

-(void)refresh
{
    [refreshControl performSelector:@selector(endRefreshing) withObject:nil afterDelay:1];
    [self.collectionView reloadData];
}

-(void)loadMore
{
    [loadMoreFooter performSelector:@selector(endLoadingWithText:) withObject:@"" afterDelay:1];
}

#pragma mark - Advertiseview header

-(AdvertiseView*)advHeader
{
    if (!_advHeader) {
        
        _advHeader=[AdvertiseView defaultAdvertiseView];
        _advHeader.delegate=self;
    }
    return _advHeader;
}

-(void)setAdvertiseHeaderViewWithPicturesUrls:(NSArray *)picturesUrls
{
    self.advHeader.picturesUrls=picturesUrls;
    [self.advHeader removeFromSuperview];
    
    if (picturesUrls.count>0) {
        [self.collectionView addSubview:self.advHeader];
        
        [self.collectionView reloadData];
    }
}

-(void)advertiseView:(AdvertiseView *)adver didSelectedIndex:(NSInteger)index
{
        NSLog(@"advertise:%@ did selected index:%d",adver,(int)index);
}

-(UICollectionViewLayout*)collectionViewLayout
{
    UICollectionViewFlowLayout* flow=[[UICollectionViewFlowLayout alloc]init];
    return flow;
}

-(void)setNothingFooterView
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIView* bgView=cell.selectedBackgroundView;
    if (!bgView) {
        bgView=[[UIView alloc]init];
        bgView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    }
    bgView.frame=cell.bounds;
    cell.selectedBackgroundView=bgView;
    
    bgView=cell.backgroundView;
    if (!bgView) {
        bgView=[[UIImageView alloc]init];
        bgView.backgroundColor=[UIColor whiteColor];
    }
    bgView.frame=cell.bounds;
    cell.backgroundView=bgView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    return cell;
}

-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if([kind isEqualToString:UICollectionElementKindSectionFooter])
    {
        UICollectionReusableView* view=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"f" forIndexPath:indexPath];
        [view removeAllSubviews];
        if (indexPath.section==collectionView.numberOfSections-1) {
            [loadMoreFooter removeFromSuperview];
            [view addSubview:loadMoreFooter];
        }
        return view;
    }
    else
    {
        UICollectionReusableView* view=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"h" forIndexPath:indexPath];
        return view;
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        if (self.advHeader.picturesUrls.count>0) {
            return self.advHeader.frame.size;
        }
    }
    return CGSizeZero;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section==collectionView.numberOfSections-1) {
        return loadMoreFooter.bounds.size;
    }
    return CGSizeMake(collectionView.frame.size.width, 1);
}

#pragma mark <UICollectionViewDelegate>

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGPoint contentOffset = scrollView.contentOffset;
    CGRect frame = scrollView.frame;
    CGSize contentSize=scrollView.contentSize;
    
//    CGFloat maa=20;
    
    if (contentOffset.y >= contentSize.height - frame.size.height || contentSize.height < frame.size.height)
    {
        if (loadMoreFooter.loading==NO&&loadMoreFooter.superview) {
            NSLog(@"should loadmore");
            [self loadMoreFooterViewShouldStartLoadMore:loadMoreFooter];
        }
    }
}


#pragma mark - loadmore something

-(void)showLoadMoreView
{
    if (loadMoreFooter==nil) {
        loadMoreFooter=[BaseLoadMoreFooterView defaultFooter];
        loadMoreFooter.delegate=self;
    }
}

-(void)hideLoadMoreView
{

}

-(void)loadMoreFooterViewShouldStartLoadMore:(BaseLoadMoreFooterView *)footerView
{
    footerView.loading=YES;
    [self loadMore];
}

@end
