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

typedef NS_ENUM(NSInteger,HomePageSection)
{
    HomePageSectionButtons,
    HomePageSectionMallHot,
    HomePageSectionPartners,
    HomePageSectionCommons,
    HomePageSectionCount,
};

@interface HomePageCollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,SimpleButtonsTableViewCellDelegate>

@end

@implementation HomePageCollectionViewController
{
    NSArray* arrayWithSimpleButtons;
    NSMutableArray* mallHotArray;
    NSMutableArray* partnerArray;
    NSMutableArray* commonsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"ME微光电";
    
    [self setAdvertiseHeaderViewWithPicturesUrls:[NSArray arrayWithObjects:@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=4059113324,2480842661&fm=27&gp=0.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1514364119633&di=f56f1aa2f7e78865bdd94bc584984720&imgtype=0&src=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fphotoblog%2F1303%2F16%2Fc10%2F18970073_18970073_1363441358578_mthumb.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1514364147938&di=a0232a2d24ddfa235fbfcdb56a7b2e17&imgtype=jpg&src=http%3A%2F%2Fimg4.imgtn.bdimg.com%2Fit%2Fu%3D1759907589%2C489492230%26fm%3D214%26gp%3D0.jpg", nil]];
    
    
}

-(NSArray*)arrayWithSimpleButtons
{
    if (arrayWithSimpleButtons.count==0) {
        
        NSMutableArray* array=[NSMutableArray array];
        for (NSInteger i=0; i<4; i++) {
            NSNumber* num=[NSNumber numberWithInteger:i];
            [array addObject:num];
        }
        arrayWithSimpleButtons=[SimpleButtonModel exampleButtonModelsWithTypes:array];;
    }
    return arrayWithSimpleButtons;
}

#pragma mark collectionview datasource delegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return HomePageSectionCount;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(section==HomePageSectionButtons)
    {
        return 1;
    }
    else
    {
        return section*4;;
    }
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section=indexPath.section;
    NSInteger row=indexPath.row;
    if (section==HomePageSectionButtons)
    {
        HomeFourCollectionViewCell* ce=[collectionView dequeueReusableCellWithReuseIdentifier:@"HomeFourCollectionViewCell" forIndexPath:indexPath];
        [ce setButtons:[self arrayWithSimpleButtons]];
        [ce setDelegate:self];
        return ce;
    }
    else if (section==HomePageSectionMallHot) {
        ProductLargeCollectionViewCell* ce=[collectionView dequeueReusableCellWithReuseIdentifier:@"ProductLargeCollectionViewCell" forIndexPath:indexPath];
        ce.title.text=ce.description;
        ce.image.image=[UIImage imageNamed:[NSString stringWithFormat:@"demo%ld.png",(row+section)%5]];
        ce.price.text=[NSString stringWithFloat:1000+section+row headUnit:@"¥" tailUnit:nil];
        return ce;
    }
    else if(section==HomePageSectionPartners||section==HomePageSectionCommons)
    {
        ProductSmallCollectionViewCell* ce=[collectionView dequeueReusableCellWithReuseIdentifier:@"ProductSmallCollectionViewCell" forIndexPath:indexPath];
        ce.title.text=ce.description;
        ce.image.image=[UIImage imageNamed:[NSString stringWithFormat:@"demo%ld.png",(row+section)%5]];
        ce.price.text=[NSString stringWithFloat:1000+section+row headUnit:@"¥" tailUnit:nil];
        return ce;
    }
    UICollectionViewCell* cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.backgroundColor=_randomColor;
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat scrW=collectionView.frame.size.width;
    if (indexPath.section==HomePageSectionButtons) {
        
        return CGSizeMake(scrW, [SimpleButtonsTableViewCell heightWithButtonsCount:[self arrayWithSimpleButtons].count]);
    }
    else if(indexPath.section==HomePageSectionMallHot)
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
    if (section==HomePageSectionButtons) {
        return [super collectionView:collectionView layout:collectionViewLayout referenceSizeForHeaderInSection:section];
    }
    else if(section==HomePageSectionCommons||section==HomePageSectionPartners||section==HomePageSectionMallHot)
    {
        if ([collectionView numberOfItemsInSection:section]>0) {
            return CGSizeMake(collectionView.frame.size.width,60);
        }
        return CGSizeZero;
    }
    else{
        return CGSizeMake(0, 0);
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    CGFloat scrW=collectionView.frame.size.width;
    if (section==HomePageSectionPartners||section==HomePageSectionMallHot) {
        return CGSizeMake(scrW, 10);
    }
    else
    {
        return [super collectionView:collectionView layout:collectionViewLayout referenceSizeForFooterInSection:section];
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (section==HomePageSectionPartners||section==HomePageSectionCommons) {
        return 15;
    }
    else if(section==HomePageSectionMallHot)
    {
        return 15;
    }
    return 0.00;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.00;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section==HomePageSectionPartners||section==HomePageSectionCommons) {
        return UIEdgeInsetsMake(5,15, 35, 15);
    }
    else if(section==HomePageSectionMallHot)
    {
        return UIEdgeInsetsMake(5,15, 35, 15);
    }
    return UIEdgeInsetsZero;
}

-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if (indexPath.section==HomePageSectionMallHot||indexPath.section==HomePageSectionPartners||indexPath.section==HomePageSectionCommons) {
            ProductCateHeaderCollectionReusableView* cateHeader=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ProductCateHeaderCollectionReusableView" forIndexPath:indexPath];
            if (indexPath.section==HomePageSectionMallHot) {
                cateHeader.title.text=@"商城热销";
                cateHeader.detail.text=nil;
            }
            else if (indexPath.section==HomePageSectionPartners) {
                cateHeader.title.text=@"合伙人推荐";
                cateHeader.detail.text=@"查看更多";
            }
            else if (indexPath.section==HomePageSectionCommons) {
                cateHeader.title.text=@"常用耗材推荐";
                cateHeader.detail.text=@"查看更多";
            }
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

#pragma mark actions

-(void)checkmoreButtonClick:(UIButton*)button
{
    NSLog(@"button tag:%ld",(long)button.tag);
}

@end
