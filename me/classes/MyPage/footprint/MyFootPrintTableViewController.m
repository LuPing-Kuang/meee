//
//  MyFootPrintTableViewController.m
//  me
//
//  Created by jam on 2018/1/11.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "MyFootPrintTableViewController.h"
#import "MyFootPrintTableViewCell.h"
#import "MyPageHttpTool.h"

#import "SelectedAllActionView.h"

@interface MyFootPrintTableViewController ()
{
    UIBarButtonItem* editBtn;
    BOOL editing;
    SelectedAllActionView* actionView;
}
@end

@implementation MyFootPrintTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"我的足迹";
    
    [self refresh];
    
    editBtn=[[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEditing)];
    self.navigationItem.rightBarButtonItem=editBtn;
    
    [self showLoadMoreView];
    
    actionView=[[[UINib nibWithNibName:@"SelectedAllActionView" bundle:nil]instantiateWithOwner:nil options:nil]firstObject];
    actionView.frame=self.bottomFrame;
    [actionView.actionButton setTitle:@"删除足迹" forState:UIControlStateNormal];
    [actionView.actionButton addTarget:self action:@selector(actionViewDoAction) forControlEvents:UIControlEventTouchUpInside];
    [actionView.selectAllButton addTarget:self action:@selector(toggleSelectedAll) forControlEvents:UIControlEventTouchUpInside];
    [self setBottomSubView:actionView];
    
    [self setBottomBarHidden:YES];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)toggleEditing
{
    editing=!editing;
//    editToolBar.editing=editing;
    editBtn.title=editing?@"完成":@"编辑";
    
    [self setBottomBarHidden:!editing];
    
    NSArray* allCells=[self.tableView visibleCells];
    for (MyFootPrintTableViewCell* ce in allCells) {
        if ([ce isKindOfClass:[MyFootPrintTableViewCell class]]) {
            ce.editing=editing;
        }
    }
}

-(void)toggleSelectedAll
{
    NSLog(@"toggle select all");
    BOOL isSelectedAll=YES;
    for (FootPrintModel* mo in self.dataSource) {
        if(mo.selected==NO)
        {
            isSelectedAll=NO;
        }
    }
    
    BOOL shouldSelectedAll=!isSelectedAll;
    
    for (FootPrintModel* mo in self.dataSource) {
        mo.selected=shouldSelectedAll;
    }
    
    NSArray* allCells=[self.tableView visibleCells];
    for (MyFootPrintTableViewCell* ce in allCells) {
        if ([ce isKindOfClass:[MyFootPrintTableViewCell class]]) {
            ce.selectButton.selected=shouldSelectedAll;
        }
    }
    
    actionView.selectedAll=shouldSelectedAll;
}

-(void)actionViewDoAction
{
    NSMutableArray* selectedItems=[NSMutableArray array];
    for (FootPrintModel* foo in self.dataSource) {
        if (foo.selected) {
            [selectedItems addObject:foo];
        }
    }
    if (selectedItems.count==0) {
        [HUDManager showErrorMsg:@"至少选择一个"];
        return;
    }
    MJWeakSelf;
    [MyPageHttpTool postRemoveMyFootprints:selectedItems token:[UserModel token] complete:^(BOOL result, NSString *msg) {
        if (result) {
            [HUDManager showSuccessMsg:msg];
            [weakSelf.dataSource removeObjectsInArray:selectedItems];
            [weakSelf.tableView reloadData];
            [weakSelf endRefresh];
        }
        else
        {
            [HUDManager showErrorMsg:msg];
            [weakSelf endRefresh];
        }
    }];
}

-(void)someSelectButtonClick:(UIButton*)button
{
    NSInteger tag=button.tag;
    BOOL se=!button.selected;
    button.selected=se;
    FootPrintModel* thisFoot=[self.dataSource objectAtIndex:tag];
    thisFoot.selected=se;
    
    BOOL isSelectedAll=YES;
    for (FootPrintModel* mo in self.dataSource) {
        if(mo.selected==NO)
        {
            isSelectedAll=NO;
        }
        //do network
    }
    actionView.selectedAll=isSelectedAll;
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
    [MyPageHttpTool getMyFootprintsCache:NO token:[UserModel token] page:page pagesize:pagesize success:^(NSArray *result) {
        if(refreshing)
        {
            [weakSelf.dataSource removeAllObjects];
        }
        
        [weakSelf.dataSource addObjectsFromArray:result];
        
        [weakSelf.tableView reloadData];
        [weakSelf endRefresh];
        if (result.count>0) {
            actionView.selectedAll=NO;
            if (refreshing) {
                weakSelf.currentPage=1;
            }
            else
            {
                weakSelf.currentPage=weakSelf.currentPage+1;
            }
        }
        
    } failure:^(NSError *error) {
        [weakSelf endRefresh];
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
    return self.dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger section=indexPath.section;
    NSInteger row=indexPath.row;
    
    FootPrintModel* foot=[self.dataSource objectAtIndex:section];
    
    if (row==0) {
        MyFootPrintTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"MyFootPrintTimeTableViewCell" forIndexPath:indexPath];
        cell.time.text=foot.createtime;
        return cell;
    }
    else if (row==1) {
        MyFootPrintTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"MyFootPrintGoodTableViewCell" forIndexPath:indexPath];
        [cell.image setImageUrl:foot.thumb];
        cell.title.text=foot.title;
        cell.price1.text=[NSString stringWithFloat:foot.marketprice.doubleValue headUnit:@"¥" tailUnit:nil];
        cell.price2.text=[NSString stringWithFloat:foot.productprice.doubleValue headUnit:@"¥" tailUnit:nil];
        cell.editing=editing;
        cell.selectButton.selected=foot.selected;
        cell.selectButton.tag=section;
        [cell.selectButton addTarget:self action:@selector(someSelectButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    return [[UITableViewCell alloc]init];
}

@end
