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
#import "MyPageHttpTool.h"
#import "RefundPageModel.h"
#import "ReportTakePhotoViewVariedHeight.h"

@interface ApplyRefundController ()



@property (nonatomic,strong) NSString *RefundDes;
@property (nonatomic,strong) NSString *RefundMoney;
@property (nonatomic,strong) NSArray *RefundReasonArr;
@property (nonatomic,strong) NSArray *handlingArr;

@property (nonatomic,strong) NSString *RefundReason;
@property (nonatomic,strong) NSString *handling;

@property (nonatomic,strong) ImageViewScrollView *scrollView;

@property (nonatomic,strong) RefundPageModel *pageModel;
@property (nonatomic,assign) BOOL ishasData;


@property (nonatomic,strong) NSString *rtypeIndex;
@property (nonatomic,strong) NSString *reasonIndex;

@property (nonatomic,strong) ReportTakePhotoViewVariedHeight *takePhotoView;
@property (nonatomic,assign) CGFloat cell2Height;

@end

@implementation ApplyRefundController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"退款申请";
    
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    NSArray *titleArr = @[@"取消申请",@"提交申请"];
    [self setupBottomViews:titleArr];
    
    NSArray *RefundReasonArr = @[@"退款(仅退款不退货)",@"退货退款",@"换货"];
    self.RefundReasonArr = RefundReasonArr;
    
    NSArray *handlingArr = @[@"不想要了",@"卖家缺货",@"拍错了/订单信息错误",@"其它"];
    self.handlingArr = handlingArr;
    
    [self refresh];
    
}


-(void)refresh
{
    [self loadingDataRefreshing:YES];
}


-(void)loadingDataRefreshing:(BOOL)refreshing
{
    MJWeakSelf;
    [MyPageHttpTool applyRefundPage:self.orderId withCompleted:^(id result, BOOL success) {
        
        if (success) {
            weakSelf.pageModel = [RefundPageModel mj_objectWithKeyValues:result];
        }else{
            [HUDManager showErrorMsg:result];
            weakSelf.ishasData = false;
            [weakSelf endRefresh];
        }
        
    }];
    
    
}


- (void)setPageModel:(RefundPageModel *)pageModel{
    _pageModel = pageModel;
    self.title = _pageModel.title;
    self.ishasData = true;
    [self.tableView reloadData];
    [self endRefresh];
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
    
    if (self.ishasData) {
        return 6;
    }else {
        return 0;
    }
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        ApplyRefundCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ApplyRefundItemCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.itemNameLb.text = @"处理方式";
        if (self.pageModel.refundtype == nil) {
            cell.itemMsglb.text = @"退款(仅退款不退货)";
            self.rtypeIndex = @"0";
        }else {
            if ([self.pageModel.rtypeIndex isEqualToString:@"0"]) {
                cell.itemMsglb.text = @"退款(仅退款不退货)";
                self.rtypeIndex = @"0";
            }else if ([self.pageModel.rtypeIndex isEqualToString:@"1"]) {
                cell.itemMsglb.text = @"换货";
                self.rtypeIndex = @"1";
            }else if ([self.pageModel.rtypeIndex isEqualToString:@"1"]) {
                cell.itemMsglb.text = @"退货退款";
                self.rtypeIndex = @"2";
            }
        }
        
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
        cell.itemMsglb.text = @"不想要了";
        
        if (self.pageModel.refundtype == nil) {
            cell.itemMsglb.text = @"不想要了";
            self.reasonIndex = @"0";
        }else {
            if ([self.pageModel.reasonIndex isEqualToString:@"0"]) {
                cell.itemMsglb.text = @"不想要了";
                self.reasonIndex = @"0";
            }else if ([self.pageModel.reasonIndex isEqualToString:@"1"]) {
                cell.itemMsglb.text = @"卖家缺货";
                self.reasonIndex = @"1";
            }else if ([self.pageModel.reasonIndex isEqualToString:@"2"]) {
                cell.itemMsglb.text = @"拍错了/订单信息错误";
                self.reasonIndex = @"2";
            }else if ([self.pageModel.reasonIndex isEqualToString:@"3"]) {
                cell.itemMsglb.text = @"其他";
                self.reasonIndex = @"3";
            }
        }
        
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
        
        if (!self.takePhotoView) {
            MJWeakSelf;
            self.takePhotoView = [[ReportTakePhotoViewVariedHeight alloc]initWithFrame:CGRectMake(85, 0, UIScreenWidth - 85, 100)];
            self.takePhotoView.resultHeight = ^(CGFloat height) {
                
                NSLog(@"height:%f",height);
                weakSelf.cell2Height = height;
                [weakSelf.tableView reloadData];
            };
            
        }
        
        [cell.contentView addSubview:self.takePhotoView];

        
        
        return cell;
    }else if (indexPath.row == 5) {
        ApplyRefundCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ApplyRefundFooterCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.RefundTipsLb.text = [NSString stringWithFormat:@"提示：您可退款的最大金额为¥%.2f",[self.pageModel.order.refundprice floatValue]];
        
        
        return cell;
    }
    
    return [[UITableViewCell alloc]init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 4) {
        CGFloat height = self.cell2Height==0?70:self.cell2Height;
        return height;
    }else {
        return UITableViewAutomaticDimension;
    }
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
