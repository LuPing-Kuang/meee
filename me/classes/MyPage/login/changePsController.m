//
//  changePsController.m
//  me
//
//  Created by KLP on 2018/1/27.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "changePsController.h"
#import "changePsCell.h"
#import "UserDataLoader.h"
@interface changePsController ()

@property (strong, nonatomic)  UITextField *phoneTf;
@property (strong, nonatomic)  UITextField *codeTf;
@property (strong, nonatomic)  UITextField *theNewPsTf;
@property (strong, nonatomic)  UITextField *againPsTf;
@property (strong, nonatomic)  UIButton *codeBtn;

@property (nonatomic,strong) NSTimer *countDownTimer;
@property (nonatomic,assign) NSInteger count;

@end

@implementation changePsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        changePsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"changePsCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.phoneTf = cell.phoneTf;
        self.phoneTf.text = [AccountManager sharedInstance].currentUser.mobile;
        self.codeTf = cell.codeTf;
        self.theNewPsTf = cell.theNewPsTf;
        self.againPsTf = cell.againPsTf;
        self.codeBtn = cell.codeBtn;
        MJWeakSelf;
        cell.codeBlock = ^{
            [weakSelf getVerifyCode];
        };
        
        return cell;
    }else if (indexPath.section==1){
        changePsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"changePsFooterCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        MJWeakSelf;
        cell.sureBlock = ^{
            [weakSelf sureBtnClick];
        };
        return cell;
    }
    return [[UITableViewCell alloc]init];
}





- (void)sureBtnClick {
    
    if (self.phoneTf.text.length!=11) {
        [HUDManager showErrorMsg:@"请输入11位手机号"];
        return;
    }
    
    if (self.codeTf.text.length!=6) {
        [HUDManager showErrorMsg:@"请输入6位验证码"];
        return;
    }
    
    if (self.theNewPsTf.text.length==0) {
        [HUDManager showErrorMsg:@"请输入新密码"];
        return;
    }
    
    if (self.againPsTf.text.length==0) {
        [HUDManager showErrorMsg:@"请输入确认密码"];
        return;
    }
    
    
    if (![self.theNewPsTf.text isEqualToString:self.againPsTf.text]) {
        [HUDManager showErrorMsg:@"两次输入密码不一致，请重新输入"];
        return;
    }
    
    [HUDManager showLoading:@"修改中..."];
    MJWeakSelf;
    [UserDataLoader changePsWithMobile:self.phoneTf.text WithPwd:self.theNewPsTf.text WithVerifycode:self.codeTf.text withCompleted:^(id result, BOOL success) {
        if (success) {
            [HUDManager showSuccessMsg:@"修改成功"];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            [HUDManager showErrorMsg:result];
        }
    }];
    
    
}


- (void)getVerifyCode {
    
    if (self.phoneTf.text.length!=11) {
        [HUDManager showErrorMsg:@"请输入11位手机号"];
        return;
    }
    
    [HUDManager showLoading:@"发送中..."];
    MJWeakSelf;
    [UserDataLoader getCodeWithMobile:self.phoneTf.text WithTemp:@"sms_changepwd" withCompleted:^(id result, BOOL success) {
        if (success) {
            [HUDManager showSuccessMsg:@"发送成功"];
            weakSelf.count = DefaultCountDownSecond;
            weakSelf.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(sendSMSSuccess) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:weakSelf.countDownTimer forMode:NSRunLoopCommonModes];
            [weakSelf.countDownTimer fire];
        }else{
            [HUDManager showErrorMsg:result];
        }
    }];
    
}

#pragma mark -
#pragma mark - 发送短信
- (void)sendSMSSuccess{
    if (self.count == 0) {
        [_countDownTimer invalidate];
        _countDownTimer = nil;
        [self.codeBtn setEnabled:YES];
        [self.codeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.codeBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        
    }else{
        [self.codeBtn setEnabled:NO];
        NSString *sting = [NSString stringWithFormat:@"%lu秒",(NSInteger)self.count];
        [self.codeBtn setTitle:sting forState:UIControlStateNormal];
        [self.codeBtn setTitleColor:RGB(184, 184, 184) forState:UIControlStateNormal];
    }
    self.count --;
    
}


- (void)dealloc{
    [self.countDownTimer invalidate];
    self.countDownTimer = nil;
}


@end
