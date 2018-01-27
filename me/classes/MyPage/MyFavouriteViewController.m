//
//  MyFavouriteViewController.m
//  me
//
//  Created by KLP on 2018/1/27.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "MyFavouriteViewController.h"
#import "MyFavouriteSelectedAllActionView.h"
#import "ProductDetailWebViewController.h"
#import "MyFavouriteViewCell.h"
#import "MyfavouriteModel.h"
#import "UserDataLoader.h"
@interface MyFavouriteViewController ()

@property (nonatomic, strong) UIBarButtonItem* editBtn;
@property (nonatomic, strong) MyFavouriteSelectedAllActionView* actionView;
@property (nonatomic, assign) BOOL editing;

@end

@implementation MyFavouriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"我的收藏";
    
    [self refresh];
    
    self.editBtn=[[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEditing)];
    self.navigationItem.rightBarButtonItem=self.editBtn;
    
    [self showLoadMoreView];
    
    self.actionView=[[[UINib nibWithNibName:@"MyFavouriteSelectedAllActionView" bundle:nil]instantiateWithOwner:nil options:nil]firstObject];
    self.actionView.frame=self.bottomFrame;
    self.actionView.selectedAll = NO;
    [self.actionView.actionButton setTitle:@"删除" forState:UIControlStateNormal];
    [self.actionView.actionButton addTarget:self action:@selector(actionViewDoAction) forControlEvents:UIControlEventTouchUpInside];
    [self.actionView.selectAllButton addTarget:self action:@selector(toggleSelectedAll) forControlEvents:UIControlEventTouchUpInside];
    [self setBottomSubView:self.actionView];
    
    [self setBottomBarHidden:YES];
    
}


-(void)toggleEditing
{
    self.editing=!self.editing;
    
    self.editBtn.title=self.editing?@"完成":@"编辑";
    
    [self setBottomBarHidden:!self.editing];
    
    NSArray* allCells=[self.tableView visibleCells];
    for (MyFavouriteViewCell* ce in allCells) {
        if ([ce isKindOfClass:[MyFavouriteViewCell class]]) {
            if (self.editing) {
                [ce showSelectBtn];
            }else{
                [ce hideSelectBtn];
            }
        }
    }
}

-(void)toggleSelectedAll
{
    
    self.actionView.selectedAll = !self.actionView.selectedAll;
    
    BOOL shouldSelectedAll=!self.actionView.selectedAll;
    
    for (MyfavouriteModel* mo in self.dataSource) {
        mo.isSelected=shouldSelectedAll;
    }
    
    NSArray* allCells=[self.tableView visibleCells];
    for (MyFavouriteViewCell* ce in allCells) {
        if ([ce isKindOfClass:[MyFavouriteViewCell class]]) {
            ce.selectButton.selected = shouldSelectedAll;
        }
    }
    
}

-(void)actionViewDoAction
{
    if (self.dataSource.count==0) {
        self.actionView.selectedAll = NO;
        return;
    }
    
    NSMutableArray* selectedItems=[NSMutableArray array];
    for (MyfavouriteModel* foo in self.dataSource) {
        if (foo.isSelected) {
            [selectedItems addObject:foo];
        }
    }
    if (selectedItems.count==0) {
        [HUDManager showErrorMsg:@"至少选择一个"];
        return;
    }
   
    
    NSMutableArray *arrId = [NSMutableArray array];
    for (NSInteger i=0; i<selectedItems.count; i++) {
        MyfavouriteModel *mo = selectedItems[i];
        [arrId addObject:mo.ID];
    }
    NSString *Ids = [arrId componentsJoinedByString:@","];
    
    MJWeakSelf;
    [self showLoading:@"删除中..."];
    [UserDataLoader CancelFocusMyFavouriteProductIds:Ids withCompleted:^(id result, BOOL success) {
        if (result) {
            [HUDManager showSuccessMsg:@"删除成功"];
            [weakSelf refresh];
            if (weakSelf.needRefreshBlock) {
                weakSelf.needRefreshBlock();
            }
        }
        else{
            [weakSelf showErrorMsg:result];
        }
    }];
    
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
    NSInteger pagesize=30;
    NSInteger page=self.currentPage+1;
    if (refreshing) {
        page=1;
    }
    MJWeakSelf;
    
    [UserDataLoader getMyFavouriteProductPage:page pagesize:pagesize withCompleted:^(NSArray * result, BOOL success) {
        if (success) {
            if(refreshing){
                [weakSelf.dataSource removeAllObjects];
            }
            [weakSelf.dataSource addObjectsFromArray:result];
            
            if (weakSelf.dataSource.count==0) {
                weakSelf.actionView.selectedAll = NO;
            }
            
            [weakSelf.tableView reloadData];
            [weakSelf endRefresh];
            if (result.count>0) {
                self.actionView.selectedAll=NO;
                
                if (refreshing) {
                    weakSelf.currentPage=1;
                }
                else
                {
                    weakSelf.currentPage=weakSelf.currentPage+1;
                }
            }
            
            
        }else{
             [weakSelf endRefresh];
        }
        
    }];

}

#pragma mark tableviews

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 10;
    }
    return 0.0001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1.0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyFavouriteViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"MyFavouriteViewCell" forIndexPath:indexPath];
    cell.myfavouriteModel = self.dataSource[indexPath.row];
    MJWeakSelf;
    cell.selectBlock = ^(MyfavouriteModel *model) {
        [weakSelf someSelectButtonClick:model];
    };
    return cell;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MyfavouriteModel* mo=[self.dataSource objectAtIndex:indexPath.row];
    ProductDetailWebViewController* detailWeb=[[ProductDetailWebViewController alloc]initWithProductId:mo.goodsid token:[UserModel token]];
    [self.navigationController pushViewController:detailWeb animated:YES];
}

-(void)someSelectButtonClick:(MyfavouriteModel*)mo
{
    
    BOOL isSelectAll = YES;;
    
    for (NSInteger i=0; i<self.dataSource.count; i++) {
        MyfavouriteModel *mo = self.dataSource[i];
        if (!mo.isSelected) {
            isSelectAll = NO;
            break;
        }
    }
    
    self.actionView.selectedAll=isSelectAll;
}

@end
