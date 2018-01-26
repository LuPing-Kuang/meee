//
//  ProductAllCollectionViewController.m
//  me
//
//  Created by jam on 2017/12/28.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "ProductAllCollectionViewController.h"

#import "ProductLargeCollectionViewCell.h"
#import "ProductSmallCollectionViewCell.h"

#import "ZZSearchBar.h"
#import "MenuHeaderTableViewCell.h"

#import "ProductPageHttpTool.h"

#import "ProductDetailWebViewController.h"
#import "ProductScreeningView.h"

typedef NS_ENUM(NSInteger,ProductCollectionLayoutStyle)
{
    ProductCollectionLayoutStyleSmall,
    ProductCollectionLayoutStyleLarge,
};

@interface ProductAllCollectionViewController ()<UITextFieldDelegate,MenuHeaderTableViewCellDelegate>
@property (nonatomic, strong) ProductScreeningView *ScreeningView;
@property (nonatomic, strong) UIView *coverV;

@property (nonatomic, copy) NSString *cate;
@property (nonatomic, assign) BOOL isrecommand;
@property (nonatomic, assign) BOOL isnew;
@property (nonatomic, assign) BOOL ishot;
@property (nonatomic, assign) BOOL isdiscount;
@property (nonatomic, assign) BOOL issendfree;
@property (nonatomic, assign) BOOL istime;

@end

@implementation ProductAllCollectionViewController
{
    ProductCollectionLayoutStyle currentLayoutStyle;
    UIBarButtonItem* exchangeLayoutItem;
    ZZSearchBar* searchBar;
    
    UIView* header;
    MenuHeaderTableViewCell* menuHeader;
    NSMutableArray* menuHeaderButtonModels;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    exchangeLayoutItem=[[UIBarButtonItem alloc]initWithTitle:@"ex" style:UIBarButtonItemStylePlain target:self action:@selector(changeCollectionViewLayout)];
//    self.navigationItem.rightBarButtonItem=exchangeLayoutItem;
    
//    [self changeCollectionViewLayout];
    self.collectionView.backgroundColor=gray_9;
    
    self.collectionView.contentInset=UIEdgeInsetsMake(40, 0, 0, 0);
    
    ZZSearchBar* sea=[ZZSearchBar defaultBar];
    sea.placeholder=@"输入关键字";
    self.navigationItem.titleView=sea;
    sea.delegate=self;
    searchBar=sea;
    
    [self performSelector:@selector(configureHeaderMenus) withObject:nil afterDelay:0.01];
    
    [self refresh];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:UserLogin_Notification object:nil];
    // Do any additional setup after loading the view.
}

-(void)configureHeaderMenus
{
    header=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    header.backgroundColor=[UIColor whiteColor];
    [self.collectionView addSubview:header];
    
//    UIView * whiBg=[[UIView alloc]initWithFrame:CGRectMake(0, 0, header.frame.size.width-8, header.frame.size.height)];
//    whiBg.backgroundColor=[UIColor whiteColor];
//    [header addSubview:whiBg];
    
//    UIVisualEffectView* blurView=[[UIVisualEffectView alloc]initWithFrame:header.bounds];
//    blurView.effect=[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
//    [header addSubview:blurView];
    
    menuHeader=[[MenuHeaderTableViewCell alloc]initWithFrame:header.bounds];
    menuHeaderButtonModels=[NSMutableArray arrayWithObjects:
                            [MenuHeaderButtonModel modelWithTitle:@"综合" selected:YES ordered:NO ascending:NO ascendingString:@"" descendingString:@"" imageName:nil alone:NO needReload:YES],
                            
                            [MenuHeaderButtonModel modelWithTitle:@"销量" selected:NO ordered:NO ascending:NO ascendingString:@"sales" descendingString:@"sales" imageName:nil alone:NO needReload:YES],
                            
                            [MenuHeaderButtonModel modelWithTitle:@"价格" selected:NO ordered:YES ascending:NO ascendingString:@"minprice" descendingString:@"minprice" imageName:nil alone:NO needReload:YES],
                            
                            [MenuHeaderButtonModel modelWithTitle:@"筛选" selected:NO ordered:NO ascending:NO ascendingString:@"" descendingString:@"" imageName:@"sift" alone:NO needReload:NO],
                            nil];
    menuHeader.buttonModelArray=menuHeaderButtonModels;
    menuHeader.delegate=self;
    [header addSubview:menuHeader];
    
    //默认值
    self.cate = nil;
    self.isrecommand = NO;
    self.isnew = NO;
    self.ishot = NO;
    self.isdiscount = NO;
    self.issendfree = NO;
    self.istime = NO;
    
    UIView* bottomLine=[[UIView alloc]initWithFrame:CGRectMake(0, header.frame.size.height-0.5, header.frame.size.width, 0.5)];
    bottomLine.backgroundColor=gray_8;
    [header addSubview:bottomLine];
    
    self.coverV = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(header.frame), UIScreenWidth, self.view.frame.size.height - CGRectGetMaxY(header.frame))];
    self.coverV.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    self.coverV.hidden = YES;
    
    [self.view addSubview:self.coverV];
    
    self.ScreeningView = LOAD_XIB_CLASS(ProductScreeningView);
    self.ScreeningView.frame = CGRectMake(0, -self.ScreeningView.frame.size.height, UIScreenWidth, self.ScreeningView.frame.size.height);
    
    [self.coverV addSubview:self.ScreeningView];
    MJWeakSelf;
    
    [self.ScreeningView setCancelBlock:^{
        [weakSelf hideScreeningView];
    }];
    
    [self.ScreeningView setSureBlock:^(NSString *cate, BOOL isrecommand, BOOL isnew, BOOL ishot, BOOL isdiscount, BOOL issendfree, BOOL istime) {
        [weakSelf hideScreeningView];
        weakSelf.cate = cate;
        weakSelf.isrecommand = isrecommand;
        weakSelf.isnew = isnew;
        weakSelf.ishot = ishot;
        weakSelf.isdiscount = isdiscount;
        weakSelf.issendfree = issendfree;
        weakSelf.istime = istime;
        
        [weakSelf refresh];
    }];
    
    
    
    [self performSelector:@selector(scrollViewDidScroll:) withObject:self.collectionView afterDelay:0.01];
}

-(void)refresh
{
    [self loadingDataRefreshing:YES];
}

-(void)loadMore
{
    [self loadingDataRefreshing:NO];
}

-(void)loadingDataRefreshing:(BOOL)refreshing
{
    NSString* keywords=searchBar.text;
    NSString* access_token=[UserModel token];
    NSInteger pagesize=30;
    NSInteger page=self.currentPage+1;
    if (refreshing) {
        page=1;
    }
    
    NSString* order=nil;
    NSString* by=@"desc";
    
    for (MenuHeaderButtonModel* menum in menuHeaderButtonModels) {
        if (!menum.alone) {
            if (menum.selected && menum.needReload) {
                order=menum.sortString;
                if (menum.ascending) {
                    by=@"asc";
                }
                break;
            }
        }
    }
    
    //调试中
    MJWeakSelf;
    [ProductPageHttpTool getProductPageCache:NO token:access_token page:page pagesize:pagesize keywords:keywords cate:self.cate recommand:self.isrecommand new:self.isnew hot:self.ishot discount:self.isdiscount sendfree:self.issendfree time:self.istime order:order by:by success:^(NSArray *result) {
        if(refreshing)
        {
            [weakSelf.dataSource removeAllObjects];
        }

        [weakSelf.dataSource addObjectsFromArray:result];
        
        [weakSelf.collectionView reloadData];
        [weakSelf endRefresh];
        
        if (result.count>0) {
            [searchBar resignFirstResponder];
            if (refreshing) {
                weakSelf.currentPage=1;
            }
            else
            {
                weakSelf.currentPage=self.currentPage+1;
            }
        }
        
    } failure:^(NSError *error) {
        [weakSelf endRefresh];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark collectionview delegate datasource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NSInteger section=indexPath.section;
    NSInteger row=indexPath.row;
    
    ProductionModel* mo=[self.dataSource objectAtIndex:row];
    
    if (currentLayoutStyle==ProductCollectionLayoutStyleLarge) {
        ProductLargeCollectionViewCell* ce=[collectionView dequeueReusableCellWithReuseIdentifier:@"ProductLargeCollectionViewCell" forIndexPath:indexPath];
        ce.title.text=mo.title;
        [ce.image setImageUrl:mo.thumb];
        ce.price.text=[NSString stringWithFloat:mo.minprice.doubleValue headUnit:@"¥" tailUnit:nil];
        return ce;
    }
    else if(currentLayoutStyle==ProductCollectionLayoutStyleSmall)
    {
        ProductSmallCollectionViewCell* ce=[collectionView dequeueReusableCellWithReuseIdentifier:@"ProductSmallCollectionViewCell" forIndexPath:indexPath];
        ce.title.text=mo.title;
        [ce.image setImageUrl:mo.thumb];
        ce.price.text=[NSString stringWithFloat:mo.minprice.doubleValue headUnit:@"¥" tailUnit:nil];
        return ce;
    }
    UICollectionViewCell* cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.backgroundColor=_randomColor;
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat scrW=collectionView.frame.size.width;
    if(currentLayoutStyle==ProductCollectionLayoutStyleLarge)
    {
        CGFloat he=110;
        if (scrW>=375) {
            he=140;
        }
        return CGSizeMake(scrW-31, he);
    }
    
    CGFloat www=scrW*0.5-13;
    return CGSizeMake(www,www+77);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 8;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.00;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(8,8, 35, 8);
}

//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    return CGSizeMake(collectionView.frame.size.width, 40);
//}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSLog(@"%@ did selected %@",collectionView,indexPath);
    ProductionModel* mo=[self.dataSource objectAtIndex:indexPath.row];
    ProductDetailWebViewController* detailWeb=[[ProductDetailWebViewController alloc]initWithProductId:mo.idd token:[UserModel token]];
    [self.navigationController pushViewController:detailWeb animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView==self.collectionView) {
        CGFloat offY=scrollView.contentOffset.y;
//        CGFloat insetTop=scrollView.contentInset.top;
//        NSLog(@"y:%f",offY);
//        NSLog(@"t:%f",insetTop);
//        
//        CGFloat navHeight=self.navigationController.navigationBar.frame.size.height;
//        CGFloat staHeight=[[UIApplication sharedApplication]statusBarFrame].size.height;
        
        CGFloat newHeaderY=offY;//+navHeight+staHeight;
        
        CGRect headerRect=header.frame;
        headerRect.origin.x=0;
        headerRect.origin.y=newHeaderY;
        headerRect.size.width=scrollView.frame.size.width;
        header.frame=headerRect;
        
        [header removeFromSuperview];
        [scrollView addSubview:header];
    }
}

#pragma mark layout change

-(void)changeCollectionViewLayout
{
    if (currentLayoutStyle==ProductCollectionLayoutStyleLarge) {
        currentLayoutStyle=ProductCollectionLayoutStyleSmall;
//        exchangeLayoutItem.title=@"大";
    }
    else
    {
        currentLayoutStyle=ProductCollectionLayoutStyleLarge;
//        exchangeLayoutItem.title=@"小";
    }
    [self.collectionView reloadData];
    [self endRefresh];
}

#pragma mark textfield delegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
//    if ([textField isKindOfClass:[ZZSearchBar class]]) {
//        NSLog(@"%@",@"search");
//        return NO;
//    }
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self refresh];
    [textField resignFirstResponder];
    return YES;
}

#pragma mark menuheader delegate

-(void)menuHeaderTableViewCell:(MenuHeaderTableViewCell *)cell didChangeModels:(NSArray<MenuHeaderButtonModel *> *)models
{
    menuHeaderButtonModels=[NSMutableArray arrayWithArray:models];
    
    for (MenuHeaderButtonModel* menum in menuHeaderButtonModels) {
        
        if (!menum.needReload) {        // 不需要重新加载的，筛选
            if (menum.selected) {
                [self showScreeningView];
            }else{
                [self hideScreeningView];
            }
        }
    }
    
    
    [self refresh];
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}


- (void)showScreeningView{
    self.coverV.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        
        self.coverV.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
        self.ScreeningView.frame = CGRectMake(0, 0, UIScreenWidth, self.ScreeningView.frame.size.height);
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hideScreeningView{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.coverV.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        self.ScreeningView.frame = CGRectMake(0, -self.ScreeningView.frame.size.height, UIScreenWidth, self.ScreeningView.frame.size.height);
        
    } completion:^(BOOL finished) {
        self.coverV.hidden = YES;
    }];
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end
