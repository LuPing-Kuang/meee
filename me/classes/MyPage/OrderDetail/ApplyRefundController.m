//
//  ApplyRefundController.m
//  me
//
//  Created by 邝路平 on 2018/4/1.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "ApplyRefundController.h"
#import "ApplyRefundCell.h"
#import "MyOrderDetailBottomView.h"
#import "ApplyItemSelectView.h"
#import "MyPageHttpTool.h"
#import "ImageViewScrollView.h"

@interface ApplyRefundController ()



@property (nonatomic,strong) NSString *RefundDes;
@property (nonatomic,strong) NSString *RefundMoney;
@property (nonatomic,strong) NSArray *RefundReasonArr;
@property (nonatomic,strong) NSArray *handlingArr;

@property (nonatomic,strong) NSString *RefundReason;
@property (nonatomic,strong) NSString *handling;

@property (nonatomic,strong) ImageViewScrollView *scrollView;


@end

@implementation ApplyRefundController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"退款申请";
    
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    NSArray *titleArr = @[@"取消申请",@"提交申请"];
    [self setupBottomViews:titleArr];
    
    NSArray *RefundReasonArr = @[@"退款(仅退款不退货)",@"退货退款",@"换货"];
    self.RefundReasonArr = RefundReasonArr;
    
    NSArray *handlingArr = @[@"不想要了",@"卖家缺货",@"拍错了/订单信息错误",@"其它"];
    self.handlingArr = handlingArr;
    
}

- (void)setupBottomViews:(NSArray*)titleArr{
    
    MyOrderDetailBottomView *v = LOAD_XIB_CLASS(MyOrderDetailBottomView);
    CGRect fra=[self bottomFrame];
    v.frame = fra;
    v.firstColorTitleArr = titleArr;
    MJWeakSelf;
    v.selectBlock = ^(NSInteger index) {
        if (index == 0) {
            [weakSelf.navigationController popViewControllerAnimated:true];
        }else{
            
        }

    };
    [self setBottomSubView:v];
    
}


#pragma mark -
#pragma mark - tableViewDelegate和tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        ApplyRefundCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ApplyRefundItemCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.itemNameLb.text = @"处理方式";
        cell.itemMsglb.text = @"退款(仅退款不退货)";
        MJWeakSelf;
        if (self.handling) {
            cell.itemMsglb.text = self.handling;
        }
        cell.itemBtnClick = ^(CGRect rect) {
            
            [ApplyItemSelectView showWithButtonRect:rect SelectBlock:^(NSInteger index) {
                weakSelf.handling = weakSelf.handlingArr[index];
                [weakSelf.tableView reloadData];
                
            } TitleArr:weakSelf.handlingArr];
            
                        
        };
        
        return cell;
    }else if (indexPath.row == 1) {
        ApplyRefundCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ApplyRefundItemCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.itemNameLb.text = @"退款原因";
        cell.itemMsglb.text = @"不想买了";
        if (self.RefundReason) {
            cell.itemMsglb.text = self.RefundReason;
        }
        MJWeakSelf;
        cell.itemBtnClick = ^(CGRect rect) {
            
            [ApplyItemSelectView showWithButtonRect:rect SelectBlock:^(NSInteger index) {
                weakSelf.RefundReason = weakSelf.RefundReasonArr[index];
                [weakSelf.tableView reloadData];
                
            } TitleArr:weakSelf.RefundReasonArr];
            
        };
        
        return cell;
    }else if (indexPath.row == 2) {
        ApplyRefundCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ApplyRefundInput1Cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        MJWeakSelf;
        
        cell.RefundDescriptionTf.text = self.RefundDes;
        
        cell.RefundDesDidChange = ^(NSString *text) {
            weakSelf.RefundDes = text;
        };
        
        return cell;
    }else if (indexPath.row == 3) {
        ApplyRefundCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ApplyRefundInput2Cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.RefundMoneyTf.text = self.RefundMoney;
        MJWeakSelf;
        cell.RefundMoneyDidChange = ^(NSString *text) {
            weakSelf.RefundMoney = text;
        };
        
        return cell;
    }else if (indexPath.row == 4) {
        ApplyRefundCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ApplyRefundImageCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        MJWeakSelf;
        cell.imageBtnClick = ^{

        };
        
        [cell.contentView addSubview:self.scrollView];
        
        return cell;
    }else if (indexPath.row == 5) {
        ApplyRefundCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ApplyRefundFooterCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        
        return cell;
    }
    
    return [[UITableViewCell alloc]init];
}




- (void)uploadUserIcon:(UIImage*)image{
    [self showLoading:@"上传中..."];
    MJWeakSelf;
    [MyPageHttpTool uploadMyIcon:image withCompleted:^(id result, BOOL success) {
        if (success) {
//            NSString *url = result[@"url"];
//            weakSelf.avatar = [NSString stringWithFormat:@"http://ewei.bangju.com/attachment/%@",url];
//
//            [weakSelf.iconImageV setImageUrl:weakSelf.avatar];
            [weakSelf showSuccessMsg:@"上传成功"];

        }else{
            [weakSelf showErrorMsg:result];
        }
    }];
}




- (ImageViewScrollView *)scrollView {
    if (_scrollView == nil) {
        _scrollView = [[ImageViewScrollView alloc]initWithFrame:CGRectMake(85, 0, UIScreenWidth - 85, 100)];
//        NSMutableArray *arr = [NSMutableArray array];
//        for (NSInteger i = 0; i<6; i++) {
//            UIImage *image = [UIImage imageNamed:@"成功"];
//            [arr addObject:image];
//        }
//        _scrollView.backgroundColor = _redColor;
//        [_scrollView addImageArr:arr];
        
        
    }
    return _scrollView;
}







@end
