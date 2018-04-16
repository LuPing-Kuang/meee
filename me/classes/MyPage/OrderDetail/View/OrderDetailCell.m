//
//  OrderDetailCell.m
//  me
//
//  Created by 邝路平 on 2018/4/1.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "OrderDetailCell.h"
#import "OrderDetailFieldCell.h"

@interface OrderDetailCell()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableV;


@end

@implementation OrderDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.orderNumLb.isCopyable = true;
    
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.tableHeaderView = [[UIView alloc]init];
    self.tableV.tableFooterView = [[UIView alloc]init];
    self.tableV.scrollEnabled = false;
    self.tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableV registerNib:[UINib nibWithNibName:NSStringFromClass([OrderDetailFieldCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([OrderDetailFieldCell class])];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.goodModel.diyformfields.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderDetailFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OrderDetailFieldCell class])];
    OrderGoodFieldModel *fieldModel = self.goodModel.diyformfields[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if ([fieldModel.data_type isEqualToString:@"5"]) {  //相片
        cell.itemImageV.hidden = false;
        cell.itemMsgLb.hidden = true;
        cell.itemNameLb.text = fieldModel.tp_name;
        cell.itemMsgLb.text = nil;
        id obj = self.goodModel.diyformdata[fieldModel.diy_type];
        if ([obj isKindOfClass:[NSArray class]]) {
            NSArray *imageArr = self.goodModel.diyformdata[fieldModel.diy_type];
            [cell.itemImageV setImageUrl:[NSString stringWithFormat:@"%@%@",uploadImageUrl,imageArr.firstObject]];
        }
        
    }else {
        cell.itemImageV.hidden = true;
        cell.itemMsgLb.hidden = false;
        cell.itemNameLb.text = fieldModel.tp_name;
        
        id obj = self.goodModel.diyformdata[fieldModel.diy_type];
        if ([obj isKindOfClass:[NSString class]]) {
            
            cell.itemMsgLb.text = (NSString*)obj;
            
        }else if ([obj isKindOfClass:[NSArray class]]) {
            NSArray *arrStr = self.goodModel.diyformdata[fieldModel.diy_type];
            NSString *str = [arrStr componentsJoinedByString:@","];
            
            cell.itemMsgLb.text = str;
        }
        
        
    }
    
    
    
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OrderGoodFieldModel *fieldModel = self.goodModel.diyformfields[indexPath.row];
    if ([fieldModel.data_type isEqualToString:@"5"]) {
        return 50;
    }else {
        return 40;
    }
    
}





- (void)setGoodModel:(OrderGoodDetailModel *)goodModel {
    
    _goodModel = goodModel;
    [self.tableV reloadData];
    
    
}












@end
