//
//  HomePageCollectionViewController.m
//  me
//
//  Created by jam on 2017/12/27.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "HomePageCollectionViewController.h"

#import "ProductLargeCollectionViewCell.h"
#import "ProductSmallCollectionViewCell.h"
#import "ProductCateHeaderCollectionReusableView.h"
#import "HomeFourCollectionViewCell.h"

#import "SimpleButtonsTableViewCell.h"

#import "HomePageHttpTool.h"

#import "ProductDetailWebViewController.h"

#import "MyOrdersPagerViewController.h"
#import "MyFavouriteViewController.h"
#import "StoresMapController.h"
#import "QRCodeScanningController.h"
#import "ExchangeController.h"

@interface HomePageCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,SimpleButtonsTableViewCellDelegate>

@end

@implementation HomePageCollectionViewController
{
    NSMutableArray* collArray;
    NSMutableArray* bannersArray;
    NSMutableArray* productSections;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"ME微光电";
    [self loadDataFromLocal:YES];
    [self refresh];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:UserLogin_Notification object:nil];
    
    /*  //扫一扫功能不放在这里
     UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44.0, 44.0)];
     UIImage *image = [UIImage imageNamed:@"扫一扫"];
     [btn setImage:image forState:UIControlStateNormal];
     [btn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
     btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, image.size.width - 44.0);
     UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
     
     self.navigationItem.rightBarButtonItem = rightBtn;
     */
    
}


- (void)rightBtnClick {
    
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
     [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)refresh
{
    [self loadDataFromLocal:NO];
}

-(void)loadDataFromLocal:(BOOL)local
{
    MJWeakSelf;
    [HomePageHttpTool getHomePageDatasCache:NO token:[UserModel token] local:local success:^(NSArray *banners, NSArray *collections, NSArray *productSecns) {
        
        
        
        productSections=[NSMutableArray arrayWithArray:productSecns];
        bannersArray=[NSMutableArray arrayWithArray:banners];
        collArray=[NSMutableArray arrayWithArray:collections];
        NSMutableArray* pics=[NSMutableArray array];
        for (BannerModel* ban in banners) {
            NSString* picur=ban.imgurl;
            if (picur.length==0) {
                picur=@"";
            }
            [pics addObject:picur];
        }
        [weakSelf setAdvertiseHeaderViewWithPicturesUrls:pics];
        
        [weakSelf.collectionView reloadData];
        [weakSelf endRefresh];
    } failure:^(NSError *error) {
        [weakSelf endRefresh];
    }];
}

#pragma mark collectionview datasource delegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1+productSections.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(section==0)
    {
        return 1;
    }
    else
    {
        ProductSection* prosec=[productSections objectAtIndex:section-1];
        return prosec.products.count;
    }
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section=indexPath.section;
    NSInteger row=indexPath.row;
    if (section==0)
    {
        HomeFourCollectionViewCell* ce=[collectionView dequeueReusableCellWithReuseIdentifier:@"HomeFourCollectionViewCell" forIndexPath:indexPath];
        [ce setButtons:collArray];
        [ce setDelegate:self];
        return ce;
    }
    
    ProductSection* prosec=[productSections objectAtIndex:section-1];
    ProductAdvModel* promo=[prosec.products objectAtIndex:row];
    if (prosec.style==ProductSectionStyleOne) {
        ProductLargeCollectionViewCell* ce=[collectionView dequeueReusableCellWithReuseIdentifier:@"ProductLargeCollectionViewCell" forIndexPath:indexPath];
        ce.title.text=promo.title;
        [ce.image setImageUrl:promo.thumb];
        ce.price.text=promo.price;
        return ce;
    }
    else
    {
        ProductSmallCollectionViewCell* ce=[collectionView dequeueReusableCellWithReuseIdentifier:@"ProductSmallCollectionViewCell" forIndexPath:indexPath];
        ce.title.text=promo.title;
        [ce.image setImageUrl:promo.thumb];
        ce.price.text=promo.price;
        return ce;
    }
//    UICollectionViewCell* cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
//    cell.backgroundColor=_randomColor;
//    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat scrW=collectionView.frame.size.width;
    if (indexPath.section==0) {
        
        return CGSizeMake(scrW, [SimpleButtonsTableViewCell heightWithButtonsCount:collArray.count]);
    }
    ProductSection* prosec=[productSections objectAtIndex:indexPath.section-1];
    if(prosec.style==ProductSectionStyleOne)
    {
        CGFloat he=110;
        if (scrW>=375) {
            he=140;
        }
        return CGSizeMake(scrW-31, he);
    }
    
    CGFloat www=scrW*0.5-24;
    return CGSizeMake(www,www+67);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return [super collectionView:collectionView layout:collectionViewLayout referenceSizeForHeaderInSection:section];
    }
    else
    {
        if ([collectionView numberOfItemsInSection:section]>0) {
            return CGSizeMake(collectionView.frame.size.width,60);
        }
        return CGSizeZero;
    }
}

//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//    CGFloat scrW=collectionView.frame.size.width;
//    if (section==HomePageSectionPartners||section==HomePageSectionMallHot) {
//        return CGSizeMake(scrW, 10);
//    }
//    else
//    {
//        return [super collectionView:collectionView layout:collectionViewLayout referenceSizeForFooterInSection:section];
//    }
//}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 15;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.00;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section!=0) {
        
        return UIEdgeInsetsMake(5,15, 35, 15);
    }
    
    return UIEdgeInsetsZero;
}

-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if (indexPath.section!=0) {
            
            ProductSection* prosec=[productSections objectAtIndex:indexPath.section-1];
            
            ProductCateHeaderCollectionReusableView* cateHeader=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ProductCateHeaderCollectionReusableView" forIndexPath:indexPath];
            cateHeader.title.text=prosec.title;
            cateHeader.detail.text=nil;
            cateHeader.button.tag=indexPath.section;
            [cateHeader.button removeTarget:self action:@selector(checkmoreButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [cateHeader.button addTarget:self action:@selector(checkmoreButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            return cateHeader;
        }
    }
    else if([kind isEqualToString:UICollectionElementKindSectionFooter])
    {
        UICollectionReusableView* foot=[super collectionView:collectionView viewForSupplementaryElementOfKind:kind atIndexPath:indexPath];
        foot.backgroundColor=gray_9;
        return foot;
    }
    return [super collectionView:collectionView viewForSupplementaryElementOfKind:kind atIndexPath:indexPath];

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSLog(@"%@ did selected %@",collectionView,indexPath);
    
    if (indexPath.section>0) {
        ProductSection* sectionP=[productSections objectAtIndex:indexPath.section-1];
        ProductAdvModel* promo=[sectionP.products objectAtIndex:indexPath.row];
        
        ProductDetailWebViewController* detailWeb=[[ProductDetailWebViewController alloc]initWithProductId:promo.gid token:[UserModel token]];
        [self.navigationController pushViewController:detailWeb animated:YES];
    }
    
}

#pragma mark actions

-(void)checkmoreButtonClick:(UIButton*)button
{
    NSLog(@"button tag:%ld",(long)button.tag);
}

-(void)simpleButtonsTableViewCell:(SimpleButtonsTableViewCell*)cell didSelectedModel:(SimpleButtonModel*)model{
    NSString *action = [model.identifier stringValueFromUrlParamsKey:@"r"];
    
    
    if ([action isEqualToString:@"order"]) {
        
        if ([UserModel token].length == 0) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:UserNeed_Login_Notification object:@{@"needMsg":@"0"}];
            return;
        }
        
        MyOrdersPagerViewController* pag=[[MyOrdersPagerViewController alloc]init];
        pag.originalPageIndex=MyOrderTypeNotSent ;
        [self.navigationController pushViewController:pag animated:YES];
        
    }else if ([action isEqualToString:@"member.favorite"]){
        
        if ([UserModel token].length == 0) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:UserNeed_Login_Notification object:@{@"needMsg":@"0"}];
            return;
        }
        
        MyFavouriteViewController *vc = [[UIStoryboard storyboardWithName:@"MyPage" bundle:nil]instantiateViewControllerWithIdentifier:@"MyFavouriteViewController"];
       
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if ([action isEqualToString:@"goods"]){
        
        /*
         StoresMapController *vc = [[StoresMapController alloc]init];
         [self.navigationController pushViewController:vc animated:YES];
         */
        
        BaseWebViewController *vc = [[BaseWebViewController alloc]initWithUrl:[NSURL URLWithString:kMapStoreUrl]];
        vc.title = @"在线地图";
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        
    }


}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
