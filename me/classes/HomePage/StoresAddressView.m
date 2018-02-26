//
//  StoresAddressView.m
//  me
//
//  Created by KLP on 2018/2/7.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "StoresAddressView.h"
#import "HomePageHttpTool.h"
@interface StoresAddressView()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableV;
@property (nonatomic,strong) NSArray <StoreModel*>*dataArr;
@property (nonatomic,assign) BOOL isShow;

@end

@implementation StoresAddressView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self addDefaultShadow];
    
    [self setupTableV];
    
}

- (void)setupTableV{
    self.tableV.tableFooterView = [[UIView alloc]init];
    self.tableV.delegate = self;
    self.tableV.dataSource = self;
    self.tableV.showsVerticalScrollIndicator = NO;
    self.tableV.separatorInset = UIEdgeInsetsMake(0, 0, 0, 10);
    self.tableV.separatorColor = RGB(235, 235, 241);
    self.tableV.showsVerticalScrollIndicator = YES;
}


#pragma mark -
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    StoreModel *model = self.dataArr[indexPath.row];
    cell.textLabel.text = model.storename;
    cell.textLabel.center = cell.center;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:15];
    cell.textLabel.textColor = [UIColor lightGrayColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.dataArr.count>0 && self.selectblock) {
        StoreModel *model = self.dataArr[indexPath.row];
        self.selectblock(model);
    }
    
    [self dismiss];
}


#pragma mark -
#pragma mark - 外部方法
- (void)searchWithKeyword:(NSString *)keyword{
    
    if (keyword==nil || [keyword isEqualToString:@""]) {
        self.dataArr = nil;
        [self.tableV reloadData];
        return;
    }
    MJWeakSelf;
    [HomePageHttpTool getAllStoreListWithKeyWord:keyword WithCompleted:^(id result, BOOL success) {
        if (success) {
            weakSelf.dataArr = result;
            [weakSelf.tableV reloadData];
        }else{
            [HUDManager showErrorMsg:result];
        }
    }];
    
    
    
}


#pragma mark -
#pragma mark - 动画
- (void)showInView:(UIView *)view{
    
    if (self.isShow) {
        return;
    }
    
    if (self.dataArr.count>0) {
        self.dataArr = nil;
        [self.tableV reloadData];
    }
    
    self.frame = CGRectMake(30, UIScreenHeight, UIScreenWidth-2*30, 270);
    
    // 弹簧动画，参数分别为：时长，延时，弹性（越小弹性越大），初始速度
    [UIView animateWithDuration: 0.7 delay:1 usingSpringWithDamping:0.7 initialSpringVelocity:0.2 options:0 animations:^{
        // 弹簧弹起来
        self.frame = CGRectMake(self.frame.origin.x, 64-5, self.frame.size.width, self.frame.size.height);
        
    } completion:^(BOOL finished) {
        self.isShow = YES;
    }];
    
}


- (void)dismiss{
    
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(30, UIScreenHeight, UIScreenWidth-2*30, 270);
    } completion:^(BOOL finished) {
        self.isShow = NO;
        //        [self removeFromSuperview];
        [[UIApplication sharedApplication].keyWindow endEditing:YES];
    }];
    
}



@end
