//
//  MyAddressesTableViewController.m
//  me
//
//  Created by jam on 2018/1/11.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "MyAddressesTableViewController.h"
#import "MyPageHttpTool.h"

#import "AddressListTableViewCell.h"
#import "AddressOptionTableViewCell.h"

#import "MyAddressAddNewTableViewController.h"

@interface MyAddressesTableViewController ()<AddressOptionTableViewCellDelegate>

@end

@implementation MyAddressesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"收货地址";
    
    [self refresh];
    
    UIButton* addnewButton=[[UIButton alloc]initWithFrame:self.bottomFrame];
    addnewButton.backgroundColor=_mainColor;
    addnewButton.titleLabel.font=[UIFont systemFontOfSize:14];
    [addnewButton setTitle:@"新建地址" forState:UIControlStateNormal];
    [addnewButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addnewButton addTarget:self action:@selector(addNewAddress) forControlEvents:UIControlEventTouchUpInside];
    [self setBottomSubView:addnewButton];
    
    [self showLoadMoreView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [MyPageHttpTool getMyAddressesCache:NO token:[UserModel token] page:page pagesize:pagesize success:^(NSArray *result) {
        if(refreshing)
        {
            [self.dataSource removeAllObjects];
        }
        
        [self.dataSource addObjectsFromArray:result];
        
        [self.tableView reloadData];
        
        if (result.count>0) {
            if (refreshing) {
                self.currentPage=1;
            }
            else
            {
                self.currentPage=self.currentPage+1;
            }
        }
        
    } failure:^(NSError *error) {
        [self.tableView reloadData];
    }];
}

#pragma mark tableviews

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
    ProductionOrderAddressModel* add=[self.dataSource objectAtIndex:indexPath.section];
    if (indexPath.row==0) {
        AddressListTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"AddressListTableViewCell" forIndexPath:indexPath];
        cell.name.text=add.realname;
        cell.phone.text=add.mobile;
        NSString* pro=add.province;
        NSString* cit=add.city;
        NSString* dis=add.area;
        NSString* adr=add.address;
        if (pro.length==0) {
            pro=@"";
        }
        if (cit.length==0) {
            cit=@"";
        }
        if (dis.length==0) {
            dis=@"";
        }
        if (adr.length==0) {
            adr=@"";
        }
        cell.address.text=[NSString stringWithFormat:@"%@%@%@%@",pro,cit,dis,adr];
        return cell;
    }
    else if(indexPath.row==1)
    {
        AddressOptionTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"AddressOptionTableViewCell" forIndexPath:indexPath];
        cell.defaulButton.selected=add.isdefault.boolValue;
        cell.delegate=self;
        cell.model=add;
        return cell;
    }
    return [[UITableViewCell alloc]init];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==0) {
        //do some
        ProductionOrderAddressModel* model=[self.dataSource objectAtIndex:indexPath.section];
        if ([self.delegate respondsToSelector:@selector(myAddressesTableViewController:didSelectedAddress:)]) {
            [self.delegate myAddressesTableViewController:self didSelectedAddress:model];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

#pragma mark addressotiontableviewcell delegate& actions

-(void)addressOtionTableViewCell:(AddressOptionTableViewCell *)cell doAction:(AddressOptionAction)action
{
//    NSString* token=[UserModel token];
//    
//    AddressModel* model=cell.model;
//    NSLog(@"%@,%@",model.idd,model.address);
//    if(action==AddressOptionActionDefault)
//    {
//        if(model.classic)
//        {
//            return;
//        }
//        [MBProgressHUD showProgressMessage:@"正在设定"];
//        [MyPageHttpTool postDefaultAddressId:model.idd token:token success:^(BOOL result, NSString *msg) {
//            if (result) {
//                [MBProgressHUD showSuccessMessage:msg];
//                model.classic=YES;
//                [self.dataSource removeObject:model];
//                for (AddressModel* mo in self.dataSource) {
//                    mo.classic=NO;
//                }
//                [self.dataSource insertObject:model atIndex:0];
//                [self.tableView reloadData];
//                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
//            }
//            else
//            {
//                [MBProgressHUD showErrorMessage:msg];
//            }
//        }];
//    }
//    else if(action==AddressOptionActionDelete)
//    {
//        UIAlertController* alert=[UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除该地址吗？" preferredStyle:UIAlertControllerStyleAlert];
//        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
//        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            [MBProgressHUD showProgressMessage:@"正在删除"];
//            [MyPageHttpTool postDeleteAddressId:model.idd token:token success:^(BOOL result, NSString *msg) {
//                if (result) {
//                    [MBProgressHUD showSuccessMessage:msg];
//                    NSInteger ind=[self.dataSource indexOfObject:model];
//                    [self.dataSource removeObject:model];
//                    [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:ind] withRowAnimation:UITableViewRowAnimationAutomatic];
//                    [self scrollViewDidScroll:self.tableView];
//                }
//                else
//                {
//                    [MBProgressHUD showErrorMessage:msg];
//                }
//            }];
//        }]];
//        [self presentViewController:alert animated:YES completion:nil];
//        
//    }
//    else if(action==AddressOptionActionEdit)
//    {
//        AddressAddNewFormTableViewController* add=[[AddressAddNewFormTableViewController alloc]init];
//        add.editAddress=model;
//        [self.navigationController pushViewController:add animated:YES];
//    }
}

#pragma mark action

-(void)addNewAddress
{
    [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"MyPage" bundle:nil]instantiateViewControllerWithIdentifier:@"MyAddressAddNewTableViewController"] animated:YES];
}

@end
