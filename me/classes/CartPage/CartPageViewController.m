//
//  CartPageViewController.m
//  me
//
//  Created by jam on 2018/1/7.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "CartPageViewController.h"
#import "CartEditTableViewCell.h"

#import "CartPageHttpTool.h"
#import "RentCartEditToolBar.h"
#import "ProductDetailWebViewController.h"
#import "ProductOrderComfirmTableViewController.h"

@interface CartPageViewController ()<CartEditTableViewCellDelegate>

{
    RentCartEditToolBar* editToolBar;
    UIBarButtonItem* editBtn;
    BOOL editing;
}

@end

@implementation CartPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"我的购物车";
    
//    [self refresh];
    
    editToolBar=[[[UINib nibWithNibName:@"RentCartEditToolBar" bundle:nil]instantiateWithOwner:nil options:nil]firstObject];
    CGRect fra=[self bottomFrame];
    editToolBar.frame=fra;
    [self setBottomSubView:editToolBar];
    [editToolBar.selectAllButton addTarget:self action:@selector(toggleSelectAllItems) forControlEvents:UIControlEventTouchUpInside];
    [editToolBar.deleteBtn addTarget:self action:@selector(deleteSelectedItems) forControlEvents:UIControlEventTouchUpInside];
    [editToolBar.attention addTarget:self action:@selector(attentSelectedItems) forControlEvents:UIControlEventTouchUpInside];
    [editToolBar.account addTarget:self action:@selector(buySelectedItems) forControlEvents:UIControlEventTouchUpInside];
    
    editBtn=[[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEditing)];
    self.navigationItem.rightBarButtonItem=editBtn;
    
    [self calculateTotalAmount];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refresh];
}

#pragma mark actions

-(void)refresh
{
    [CartPageHttpTool getCartPageCache:NO token:[UserModel token] success:^(NSArray *result,BOOL selectedAll) {
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:result];
        editToolBar.seletedAll=selectedAll;
        [self.tableView reloadData];
        [self calculateTotalAmount];
    } failure:^(NSError *error) {
        [self.tableView reloadData];
        [self calculateTotalAmount];
    }];
}

-(void)toggleEditing
{
    editing=!editing;
    editToolBar.editing=editing;
    editBtn.title=editing?@"完成":@"编辑";
    
    NSArray* allCells=[self.tableView visibleCells];
    for (CartEditTableViewCell* ce in allCells) {
        if ([ce isKindOfClass:[CartEditTableViewCell class]]) {
            ce.editing=editing;
        }
    }
}

-(NSArray*)seletedItems
{
    NSMutableArray* arr=[NSMutableArray array];
    for (CartItemModel* car in self.dataSource) {
        if (car.selected.boolValue) {
            [arr addObject:car];
        }
    }
    return arr;
}

-(void)toggleSelectAllItems
{
    NSLog(@"toggle select all");
    BOOL isSelectedAll=YES;
    for (CartItemModel* mo in self.dataSource) {
        if(mo.selected.boolValue==NO)
        {
            isSelectedAll=NO;
        }
    }
    
    BOOL shouldSelectedAll=!isSelectedAll;
    
    for (CartItemModel* mo in self.dataSource) {
        mo.selected=[NSNumber numberWithBool:shouldSelectedAll];
    }
    
    NSArray* allCells=[self.tableView visibleCells];
    for (CartEditTableViewCell* ce in allCells) {
        if ([ce isKindOfClass:[CartEditTableViewCell class]]) {
            ce.selectButton.selected=ce.cartModel.selected.boolValue;
        }
    }
    
    editToolBar.seletedAll=shouldSelectedAll;
    
    [CartPageHttpTool postSelectCartsId:nil token:[UserModel token] selected:shouldSelectedAll];
    [self calculateTotalAmount];
}

-(void)deleteSelectedItems
{
    NSLog(@"delete selected");
    NSArray* items=[self seletedItems];
    [HUDManager showLoading:@"正在删除"];
    [CartPageHttpTool postDeleteCarts:items token:[UserModel token] complete:^(BOOL result, NSArray *deletedItems, NSString* msg) {
        if (result) {
            [HUDManager showSuccessMsg:@"已删除"];
            [self.dataSource removeObjectsInArray:deletedItems];
            [self.tableView reloadData];
            [self calculateTotalAmount];
        }
        else
        {
            [HUDManager showErrorMsg:msg];
        }
    }];
}

-(void)attentSelectedItems
{
    NSLog(@"attent selected");
    NSArray* items=[self seletedItems];
    [HUDManager showLoading:@"正在移动"];
    [CartPageHttpTool postDeleteCarts:items token:[UserModel token] complete:^(BOOL result, NSArray *deletedItems, NSString* msg) {
        if (result) {
            [HUDManager showSuccessMsg:@"已移到关注"];
            [self.dataSource removeObjectsInArray:deletedItems];
            [self.tableView reloadData];
            [self calculateTotalAmount];
        }
        else
        {
            [HUDManager showErrorMsg:msg];
        }
    }];
}

-(void)buySelectedItems
{
    NSLog(@"buy selected");
    
    NSArray* items=[self seletedItems];
    if (items.count==0) {
        [HUDManager showErrorMsg:@"请选择要购买的商品"];
        return;
    }
    
    // if something done
    [self actionWithCreateOrderUrl:nil];
}

-(void)actionWithCreateOrderUrl:(NSString*)url
{
    NSString* access_token=[UserModel token];
    if (access_token.length==0) {
        NSLog(@"did not login");
        return;
    }
    
    ProductOrderComfirmTableViewController* orderComfirm=[[UIStoryboard storyboardWithName:@"ProductPage" bundle:nil]instantiateViewControllerWithIdentifier:@"ProductOrderComfirmTableViewController"];
    orderComfirm.url=url;
    [self.navigationController pushViewController:orderComfirm animated:YES];
}

-(void)calculateTotalAmount
{
    CGFloat amount=0;
    NSInteger count=0;
    
    for (CartItemModel* ca in self.dataSource) {
        if (ca.selected.boolValue) {
            NSInteger thisCount=ca.total.integerValue;
            CGFloat thisAmount=ca.marketprice.doubleValue*thisCount;
            
            count=count+thisCount;
            amount=amount+thisAmount;
        }
        else
        {
            editToolBar.seletedAll=NO;
        }
    }
    
    editToolBar.money.text=[NSString stringWithFloat:amount headUnit:@"¥" tailUnit:nil];
    [editToolBar.account setTitle:[NSString stringWithFormat:@"结算(%ld)",(long)count] forState:UIControlStateNormal];
    
    if (self==self.navigationController.viewControllers.firstObject) {
        NSInteger itemCount=self.dataSource.count;
        NSString* tabbString=nil;
        if (itemCount>0) {
            tabbString=[NSString stringWithFormat:@"%ld",(long)itemCount];
        }
        self.navigationController.tabBarItem.badgeValue=tabbString;
    }
}

#pragma mark cart cell delegate

-(void)cartEditTableViewCell:(CartEditTableViewCell *)cell didChangeModelSelection:(CartItemModel *)cartModel
{
    [CartPageHttpTool postSelectCartsId:cartModel.idd token:[UserModel token] selected:cartModel.selected.boolValue];
    BOOL isSelectedAll=YES;
    for (CartItemModel* mo in self.dataSource) {
        if(mo.selected.boolValue==NO)
        {
            isSelectedAll=NO;
        }
        //do network
    }
    editToolBar.seletedAll=isSelectedAll;
    [self calculateTotalAmount];
}

-(void)cartEditTableViewCell:(CartEditTableViewCell *)cell didChangeModelCount:(CartItemModel *)cartModel
{
    NSInteger count=cartModel.total.integerValue;
    NSString* cartid=cartModel.idd;
    [CartPageHttpTool postChangeCartCount:count cartId:cartid token:[UserModel token]];
    [self calculateTotalAmount];
}

#pragma mark tableview datasource delegate

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CartItemModel* mo=[self.dataSource objectAtIndex:indexPath.row];
    CartEditTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"CartEditTableViewCell" forIndexPath:indexPath];
    
    cell.selectButton.selected=mo.selected.boolValue;
    [cell.image setImageUrl:mo.thumb];
    cell.title.text=mo.title;
    
    BOOL showOption=mo.optiontitle.length>0;
    cell.optionButton.hidden=!showOption;
    cell.optionArrow.hidden=cell.optionButton.hidden;
    [cell.optionButton setTitle:mo.optiontitle forState:UIControlStateNormal];
    
    cell.money.text=[NSString stringWithFloat:mo.marketprice.doubleValue headUnit:@"¥" tailUnit:nil];
    cell.stepper.min=mo.minbuy.integerValue;
    cell.stepper.max=mo.totalmaxbuy.integerValue;
    cell.stepper.value=mo.total.integerValue;
    cell.countLabel.text=[NSString stringWithFormat:@"x%ld",(long)mo.total.integerValue];
    if (cell.stepper.min<=0) {
        cell.stepper.min=1;
    }
    
    cell.delegate=self;
    cell.cartModel=mo;
    
    cell.editing=editing;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (editing) {
        return;
    }
    CartItemModel* mo=[self.dataSource objectAtIndex:indexPath.row];
    ProductDetailWebViewController* detailWeb=[[ProductDetailWebViewController alloc]initWithProductId:mo.goodsid token:[UserModel token]];
    [self.navigationController pushViewController:detailWeb animated:YES];
}

@end
