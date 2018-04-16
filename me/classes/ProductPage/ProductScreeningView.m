//
//  ProductScreeningView.m
//  me
//
//  Created by KLP on 2018/1/21.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "ProductScreeningView.h"
#import "CartPageHttpTool.h"
#import "ProductionCategoryModel.h"

@interface ProductScreeningView()<UIPickerViewDelegate,UIPickerViewDataSource,UIGestureRecognizerDelegate>
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *BtnArr;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
//@property (nonatomic, strong) NSArray *titleArr;

@property (nonatomic, assign) NSInteger selectIndex;

@property (nonatomic, copy) NSString *cate;
@property (nonatomic, assign) BOOL isrecommand;
@property (nonatomic, assign) BOOL isnew;
@property (nonatomic, assign) BOOL ishot;
@property (nonatomic, assign) BOOL isdiscount;
@property (nonatomic, assign) BOOL issendfree;
@property (nonatomic, assign) BOOL istime;

@property (nonatomic,strong) NSArray <ProductionCategoryModel*>*categoryArr;



@end

@implementation ProductScreeningView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    for (NSInteger i=0; i<self.BtnArr.count; i++) {
        UIButton *btn = self.BtnArr[i];
        btn.layer.cornerRadius = 6.0;
        btn.layer.masksToBounds = YES;
        btn.layer.borderColor = [UIColor darkGrayColor].CGColor;
        btn.layer.borderWidth = 1.0;
        btn.selected = NO;
        btn.backgroundColor = [UIColor whiteColor];
    }
    
//    self.titleArr = @[@"合伙人",@"美容仪器",@"院装产品",@"操作耗材",];
    
//    self.cate = self.titleArr[0];
    self.isrecommand = NO;
    self.isnew = NO;
    self.ishot = NO;
    self.isdiscount = NO;
    self.issendfree = NO;
    self.istime = NO;

    
    
    
    self.pickerView.delegate = self;
    self.pickerView.showsSelectionIndicator = NO;
    self.selectIndex = 0;
//    [self.pickerView selectRow:self.selectIndex inComponent:0 animated:NO];
    
    [self getProductionCategory];
    
    
    
}



- (void)getProductionCategory{
    MJWeakSelf;
    [CartPageHttpTool getShopCategoryWithCompleted:^(id result, BOOL success) {
        
        if (success) {
            weakSelf.categoryArr = [ProductionCategoryModel mj_objectArrayWithKeyValuesArray:result[@"category"]];
            [weakSelf.pickerView reloadAllComponents];
        }
    }];
}




- (IBAction)TitleBtnClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        sender.layer.borderWidth = 0;
        sender.backgroundColor = RGB(67, 175, 248);
    }else{
        sender.layer.borderWidth = 1.0;
        sender.backgroundColor = [UIColor whiteColor];
    }
    
    if (sender.tag==0) {
        self.isrecommand = sender.selected;
    }else if (sender.tag==1){
        self.isnew = sender.selected;
    }else if (sender.tag==2){
        self.ishot = sender.selected;
    }else if (sender.tag==3){
        self.isdiscount = sender.selected;
    }else if (sender.tag==4){
        self.issendfree = sender.selected;
    }else if (sender.tag==5){
        self.istime = sender.selected;
    }
    
}




- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
//    return self.titleArr.count;
    return self.categoryArr.count;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1.0;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.selectIndex = row;
//    self.cate = self.titleArr[self.selectIndex];
    self.cate = self.categoryArr[self.selectIndex].ID;
    [self.pickerView reloadAllComponents];
}

- (UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    [[pickerView.subviews objectAtIndex:1] setHidden:YES];
    [[pickerView.subviews objectAtIndex:2] setHidden:YES];
    UILabel *lb = (UILabel*)view;
    if (!view) {
        lb = [[UILabel alloc]init];
        
        NSString *title = self.categoryArr[row].name;
        if (self.selectIndex == row) {
            NSAttributedString *string = [[NSAttributedString alloc]initWithString:title attributes:@{NSForegroundColorAttributeName:_redColor}];
            lb.attributedText = string;
        }else{
            NSAttributedString *string = [[NSAttributedString alloc]initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor]}];
            lb.attributedText = string;
        }
        
        [lb sizeToFit];
        
    }

    return lb ;
}


- (IBAction)cancelBtnClick:(UIButton *)sender {
    if (self.CancelBlock) {
        self.CancelBlock();
    }
}


- (IBAction)sureBtnClick:(UIButton *)sender {
    if (self.SureBlock) {
    self.SureBlock(self.cate,self.isrecommand,self.isnew,self.ishot,self.isdiscount,self.issendfree,self.istime);
    }
}


//调试中 手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"ProductScreeningView"]) {
        return NO;
    }
    return  YES;
}


- (void)resetStatues{
    
    for (NSInteger i=0; i<self.BtnArr.count; i++) {
        UIButton *btn = self.BtnArr[i];
        btn.layer.cornerRadius = 6.0;
        btn.layer.masksToBounds = YES;
        btn.layer.borderColor = [UIColor darkGrayColor].CGColor;
        btn.layer.borderWidth = 1.0;
        btn.selected = NO;
        btn.backgroundColor = [UIColor whiteColor];
    }
    
//    self.cate = self.titleArr[0];
    self.cate = self.categoryArr.firstObject.ID;
    self.isrecommand = NO;
    self.isnew = NO;
    self.ishot = NO;
    self.isdiscount = NO;
    self.issendfree = NO;
    self.istime = NO;

    self.selectIndex = 0;
    [self.pickerView selectRow:self.selectIndex inComponent:0 animated:NO];
    
}







@end
