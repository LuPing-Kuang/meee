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

typedef NS_ENUM(NSInteger,ProductCollectionLayoutStyle)
{
    ProductCollectionLayoutStyleLarge,
    ProductCollectionLayoutStyleSmall,
};

@interface ProductAllCollectionViewController ()<UITextFieldDelegate>

@end

@implementation ProductAllCollectionViewController
{
    ProductCollectionLayoutStyle currentLayoutStyle;
    UIBarButtonItem* exchangeLayoutItem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    exchangeLayoutItem=[[UIBarButtonItem alloc]initWithTitle:@"ex" style:UIBarButtonItemStylePlain target:self action:@selector(changeCollectionViewLayout)];
    self.navigationItem.rightBarButtonItem=exchangeLayoutItem;
    
    [self changeCollectionViewLayout];
    
    ZZSearchBar* sea=[ZZSearchBar defaultBar];
    sea.placeholder=@"输入关键字";
    self.navigationItem.titleView=sea;
    sea.delegate=self;
    
    // Do any additional setup after loading the view.
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
    return 50;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section=indexPath.section;
    NSInteger row=indexPath.row;
    
    if (currentLayoutStyle==ProductCollectionLayoutStyleLarge) {
        ProductLargeCollectionViewCell* ce=[collectionView dequeueReusableCellWithReuseIdentifier:@"ProductLargeCollectionViewCell" forIndexPath:indexPath];
        ce.title.text=[NSString stringWithFormat:@"第%ld号佳丽",row];
        ce.image.image=[UIImage imageNamed:[NSString stringWithFormat:@"demo%ld.png",(long)(row+section)%5]];
        ce.price.text=[NSString stringWithFloat:1000+section+row headUnit:@"¥" tailUnit:nil];
        return ce;
    }
    else if(currentLayoutStyle==ProductCollectionLayoutStyleSmall)
    {
        ProductSmallCollectionViewCell* ce=[collectionView dequeueReusableCellWithReuseIdentifier:@"ProductSmallCollectionViewCell" forIndexPath:indexPath];
        ce.title.text=[NSString stringWithFormat:@"第%ld号佳丽",row];
        ce.image.image=[UIImage imageNamed:[NSString stringWithFormat:@"demo%ld.png",(long)(row+section)%5]];
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
    if(currentLayoutStyle==ProductCollectionLayoutStyleLarge)
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
    return UIEdgeInsetsMake(15,15, 35, 15);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(collectionView.frame.size.width, 40);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NSLog(@"%@ did selected %@",collectionView,indexPath);
}

#pragma mark layout change

-(void)changeCollectionViewLayout
{
    if (currentLayoutStyle==ProductCollectionLayoutStyleLarge) {
        currentLayoutStyle=ProductCollectionLayoutStyleSmall;
        exchangeLayoutItem.title=@"大";
    }
    else
    {
        currentLayoutStyle=ProductCollectionLayoutStyleLarge;
        exchangeLayoutItem.title=@"小";
    }
    [self.collectionView reloadData];
}

#pragma mark textfield delegate

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([textField isKindOfClass:[ZZSearchBar class]]) {
        NSLog(@"%@",@"search");
        return NO;
    }
    return YES;
}

@end
