//
//  MyPageViewController.m
//  me
//
//  Created by jam on 2018/1/5.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "MyPageViewController.h"

#import "MySimpleTableViewCell.h"
#import "MyHeaderTableViewCell.h"
#import "MyOrderCollectionTableViewCell.h"
#import "MyPageLogoutAndForgetPsCell.h"

#import "MyPageDataModel.h"

#import "MyPageHttpTool.h"

#import "MyOrdersPagerViewController.h"
#import "MyOrderTableViewController.h"
#import "MyPartnerViewController.h"
#import "ApplyPartnerController.h"
#import "MyFavouriteViewController.h"
#import "UserDataLoader.h"
#import "ModifyMyAvatarAndNickNameController.h"

@interface MyPageViewController ()<SimpleButtonsTableViewCellDelegate>
@property (nonatomic, strong) UserModel *userModel;
@end

@implementation MyPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title=@"会员中心";
    
    self.tableView.estimatedRowHeight=100;
    [self loadDataFromLocal:YES];
    [self refresh];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:UserLogin_Notification object:nil];
}

-(void)refresh
{
    [self loadDataFromLocal:NO];
}

-(void)loadDataFromLocal:(BOOL)local
{
    MJWeakSelf;
    [UserDataLoader getPersonalMsgwithCompleted:^(id result, BOOL success) {
        
        if (success) {
            weakSelf.userModel = result;
            [AccountManager sharedInstance].currentUser = result;
            
            [MyPageHttpTool getMyPageDataCache:NO token:[UserModel token] local:local success:^(NSArray *myPageSections) {
                
                [weakSelf.dataSource removeAllObjects];
                [weakSelf.dataSource addObjectsFromArray:myPageSections];
                [weakSelf.tableView reloadData];
                [weakSelf endRefresh];
            } failure:^(NSString *errorMsg) {
                [weakSelf endRefresh];
            }];
            
        }else{
            [weakSelf endRefresh];
        }
    }];
}

#pragma mark tableview datasource delegate

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray* sectionArr=[self.dataSource objectAtIndex:section];
    return sectionArr.count;
}

-(UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section=indexPath.section;
    NSInteger row=indexPath.row;
    
    NSArray* sectionArr=[self.dataSource objectAtIndex:section];
    MyPageDataModel* mo=[sectionArr objectAtIndex:row];
    
    if (mo.dataType==MyPageDataTypeNormal) {
        MySimpleTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"MySimpleTableViewCell" forIndexPath:indexPath];
        cell.image.image=[UIImage imageNamed:mo.imageName];
        cell.title.text=mo.title;
        cell.detail.text=mo.detail;
        cell.badge=mo.badge;
        return cell;
    }
    else if(mo.dataType==MyPageDataTypeCollection)
    {
        MyOrderCollectionTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"MyOrderCollectionTableViewCell" forIndexPath:indexPath];
        if (mo.associateObject) {
            [cell setButtons:mo.associateObject];
        }
        [cell setDelegate:self];
        return cell;
    }
    else if(mo.dataType==MyPageDataTypeHeader)
    {
        UserModel* us=mo.associateObject;
        MyHeaderTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"MyHeaderTableViewCell" forIndexPath:indexPath];
        [cell.headImageView setImageUrl:us.avatar];
        cell.moneyLabel.text=us.money;
        cell.nameLabel.text=us.nickname;
        cell.levelName.text=[NSString stringWithFormat:@"[%@] ID:%@",us.levelname,us.idd];
        
        if (us.levelname.length==0) {
            cell.levelName.text=nil;
        }

        [cell.topupButton addTarget:self action:@selector(goToTopUp) forControlEvents:UIControlEventTouchUpInside];
        [cell.headButton addTarget:self action:@selector(goToChangeAvatar) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    else if(mo.dataType==MyPageDataTypeLogout)
    {
        UserModel* us=mo.associateObject;
        MyPageLogoutAndForgetPsCell* cell=[tableView dequeueReusableCellWithIdentifier:@"MyPageLogoutAndForgetPsCell" forIndexPath:indexPath];
        MJWeakSelf;
        [cell setLogoutBlock:^{
            [weakSelf logout];
        }];
        
        [cell setChangePsBlock:^{
            [weakSelf gotoChangePs];
        }];
        
        return cell;
    }
    
    
    return [[UITableViewCell alloc]init];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray* sectionArr=[self.dataSource objectAtIndex:indexPath.section];
    MyPageDataModel* mo=[sectionArr objectAtIndex:indexPath.row];

    NSString* link=mo.action;
    
    if ([link isEqualToString:@"member.address"]) {
        [self pushViewControllerForStoryBoardId:@"MyAddressesTableViewController"];
    }
    else if([link isEqualToString:@"member.history"])
    {
        [self pushViewControllerForStoryBoardId:@"MyFootPrintTableViewController"];
    }
    else if([link isEqualToString:@"member.favorite"])
    {
        [self gotoMyFavourite];
    }
    else if([link isEqualToString:@"member.cart"])
    {
        [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"CartPageViewController"] animated:YES];
    }
    else if([link isEqualToString:@"order"])
    {
        [self pushOrderViewControllerWithShowingOrderType:MyOrderTypeAll];
    }
    else if([link isEqualToString:@"commission"])
    {
        
        /*
         status:1,isagent:1 合伙人
         status:0,isagent:1 申请中，待审核
         status:0,isagent:0 未申请
         */
        if ([self.userModel.status isEqualToString:@"1"] && [self.userModel.isagent isEqualToString:@"1"]) {
            
            [self pushViewControllerForStoryBoardId:@"MyPartnerViewController"];
            
        }else if ([self.userModel.status isEqualToString:@"0"] && [self.userModel.isagent isEqualToString:@"1"]){
            
            [self showMessage:@"合伙人资料申请中，等待审核"];
            
        }else if ([self.userModel.status isEqualToString:@"0"] && [self.userModel.isagent isEqualToString:@"0"]){
            
            [self showSystemAlertWithTitle:@"温馨提示" message:@"您还不是合伙人，要申请成为合伙人吗？" buttonTitle:@"确定" needDestructive:YES cancleBlock:^(UIAlertAction *action) {
                
            } btnBlock:^(UIAlertAction *action) {
                
                MJWeakSelf;
                ApplyPartnerController *vc = [[UIStoryboard storyboardWithName:@"MyPage" bundle:nil]instantiateViewControllerWithIdentifier:@"ApplyPartnerController"];
                vc.needRefreshBlock = ^{
                    [weakSelf refresh];
                };
                
                [self.navigationController pushViewController:vc animated:YES];
            }];
            
            
        }
        
    }

    
    else if([link isEqualToString:@"member.info"])
    {
        /*
         status:1,isagent:1 合伙人
         status:0,isagent:1 申请中，待审核
         status:0,isagent:0 未申请
         */
        if ([self.userModel.status isEqualToString:@"1"] && [self.userModel.isagent isEqualToString:@"1"]) {
            
            [self pushViewControllerForStoryBoardId:@"PartnerMaterialController"];
            
        }else if ([self.userModel.status isEqualToString:@"0"] && [self.userModel.isagent isEqualToString:@"1"]){
            
            [self showMessage:@"合伙人资料申请中，等待审核"];
            
        }else if ([self.userModel.status isEqualToString:@"0"] && [self.userModel.isagent isEqualToString:@"0"]){
            
            MJWeakSelf;
            ApplyPartnerController *vc = [[UIStoryboard storyboardWithName:@"MyPage" bundle:nil]instantiateViewControllerWithIdentifier:@"ApplyPartnerController"];
            vc.needRefreshBlock = ^{
                [weakSelf refresh];
            };
            
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        
    }else if ([link isEqualToString:@"shop.notice"]){
        [self pushViewControllerForStoryBoardId:@"ReportNewsController"];
    }
    
    
}

#pragma mark SimpleButtonsTableViewCellDelegate

-(void)simpleButtonsTableViewCell:(SimpleButtonsTableViewCell *)cell didSelectedModel:(SimpleButtonModel *)model
{
    NSString* link=model.identifier;
    NSInteger type=model.type;
    if ([link isEqualToString:@"order"]) {
        if (type==MyOrderTypeExchanging) {
            MyOrderTableViewController* exOrderVC=[[UIStoryboard storyboardWithName:@"MyPage" bundle:nil]instantiateViewControllerWithIdentifier:@"MyOrderTableViewController"];
            MyOrderType orderType=type;
            exOrderVC.title=[MyOrderModel titleForOrderType:orderType];
            exOrderVC.orderType=orderType;
            [self.navigationController pushViewController:exOrderVC animated:YES];
            return;
        }
        [self pushOrderViewControllerWithShowingOrderType:type];
    }
}

#pragma mark actions

-(void)pushViewControllerForStoryBoardId:(NSString*)ident
{
    [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"MyPage" bundle:nil]instantiateViewControllerWithIdentifier:ident] animated:YES];
}

-(void)pushOrderViewControllerWithShowingOrderType:(MyOrderType)showingType
{
    MyOrdersPagerViewController* pag=[[MyOrdersPagerViewController alloc]init];
    pag.originalPageIndex=[MyOrderModel pageIndexForOrderType:showingType];
    [self.navigationController pushViewController:pag animated:YES];
}



-(void)goToTopUp
{
    NSLog(@"topup");
}

-(void)goToChangeAvatar
{
    NSLog(@"avatar");
    MJWeakSelf;
    if (has_login) {
        ModifyMyAvatarAndNickNameController *bindVc = [[UIStoryboard storyboardWithName:@"MyPage" bundle:nil]instantiateViewControllerWithIdentifier:NSStringFromClass([ModifyMyAvatarAndNickNameController class])];
        bindVc.isFromHome = YES;
        bindVc.needToReload = ^{
            [weakSelf refresh];
        };
        
        [self.navigationController pushViewController:bindVc animated:YES];
        
    }else{
        UIViewController* log=[[UIStoryboard storyboardWithName:@"MyPage" bundle:nil]instantiateViewControllerWithIdentifier:@"LoginViewController"];
        [self presentViewController:log animated:YES completion:nil];
    }
    
}

//修改密码
- (void)gotoChangePs{

    NSLog(@"changePs");
    
    UIViewController* vc=[[UIStoryboard storyboardWithName:@"MyPage" bundle:nil]instantiateViewControllerWithIdentifier:@"changePsController"];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)logout{
    MJWeakSelf;
    [self showSystemAlertWithTitle:@"温馨提示" message:@"您确定要退出ME微光电吗？" buttonTitle:@"确定" needDestructive:YES cancleBlock:^(UIAlertAction *action) {
        
    } btnBlock:^(UIAlertAction *action) {
        [weakSelf showLoading:@"退出中..."];
        
        [UserDataLoader logoutwithCompleted:^(id result, BOOL success) {
            [weakSelf stopAnimation];
            if (success) {
                [weakSelf showSuccessMsg:@"退出成功"];
                [UserModel saveToken:nil];
                AccountManager.sharedInstance.currentUser = nil;
                [self.navigationController.tabBarController setSelectedIndex:0];
                [[NSNotificationCenter defaultCenter] postNotificationName:UserLogin_Notification object:nil];
                
            }else{
                [weakSelf showErrorMsg:result];
            }
        }];
    
    
    }];
}


//跳转到我的收藏模块
- (void)gotoMyFavourite{
    MJWeakSelf;
    MyFavouriteViewController *vc = [[UIStoryboard storyboardWithName:@"MyPage" bundle:nil]instantiateViewControllerWithIdentifier:@"MyFavouriteViewController"];
    vc.needRefreshBlock = ^{
        [weakSelf refresh];
    };
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
