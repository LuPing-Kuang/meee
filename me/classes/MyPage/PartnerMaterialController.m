//
//  PartnerMaterialController.m
//  me
//
//  Created by KLP on 2018/1/22.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "PartnerMaterialController.h"
#import "MyPageHttpTool.h"
#import "PartnerMaterialModel.h"
#import "PartnerMaterialFieldModel.h"
#import "PartnerMaterialCell.h"

@interface PartnerMaterialController ()
@property (nonatomic, strong) PartnerMaterialModel *model;

@end

@implementation PartnerMaterialController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"会员资料";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self refresh];
}

-(void)refresh
{
    [self loadDataFromLocal:NO];
}

-(void)loadDataFromLocal:(BOOL)local
{
    MJWeakSelf;
    [MyPageHttpTool getMyMaterialPartnerCache:local token:[UserModel token] success:^(PartnerMaterialModel *model) {
        weakSelf.model = model;
        [weakSelf.tableView reloadData];
        [weakSelf endRefresh];
    } failure:^(NSString *errormsg) {
        [weakSelf showErrorMsg:errormsg];
        [weakSelf endRefresh];
    }];
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return self.model.fieldArr.count;
    }else{
        return 1.0;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
    
}


-(UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        PartnerMaterialFieldModel *mo = self.model.fieldArr[indexPath.row];
        PartnerMaterialCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PartnerMaterialCell" forIndexPath:indexPath];
        cell.nameLb.text = mo.tp_name;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if ([mo.tp_must isEqualToString:@"1"]) {
            cell.dotLb.hidden = NO;
        }else{
            cell.dotLb.hidden = YES;
        }
        cell.myTf.placeholder = mo.placeholder;
        cell.myTf.text = mo.myName;
        
        if (mo.dataType == FieldDataTypeSingleLine) {
            cell.sureBtn.hidden = YES;
            cell.sureBtn.userInteractionEnabled = NO;
        }else if (mo.dataType == FieldDataTypeCity){
            cell.sureBtn.hidden = NO;
            cell.sureBtn.userInteractionEnabled = YES;
            cell.sureBlock = ^{
                
            };
        }
        
        return cell;
    }else{
        PartnerMaterialCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PartnerMaterialFooterCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.saveBlock = ^{
            
        };
        return cell;
    }
    
    return [[UITableViewCell alloc]init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}



@end
