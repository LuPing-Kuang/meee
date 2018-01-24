//
//  MyPartnerViewController.m
//  me
//
//  Created by KLP on 2018/1/18.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "MyPartnerViewController.h"
#import "MyPartnerViewCell.h"
#import "MyPartnerModel.h"
#import "MyPageHttpTool.h"

@interface MyPartnerViewController ()
@property (nonatomic, strong) MyPartnerModel *partner;

@end

@implementation MyPartnerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"合伙人中心";
    [self refresh];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 2;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0) {
        MyPartnerViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"MyPartnerViewCellHeader" forIndexPath:indexPath];
        if (self.partner) {
            cell.partnerModel = self.partner;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        MyPartnerViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"MyPartnerViewCellFunc" forIndexPath:indexPath];
        if (self.partner) {
            cell.partnerModel = self.partner;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    return [[UITableViewCell alloc]init];
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
    MJWeakSelf;
    [MyPageHttpTool getMyPartnerCache:NO token:[UserModel token] success:^(MyPartnerModel* partner) {
        weakSelf.partner = partner;
        [weakSelf.tableView reloadData];
        
    } failure:^(NSString *errorMsg) {
        [weakSelf.tableView reloadData];
        [HUDManager showErrorMsg:errorMsg];
        
    }];
}




@end
