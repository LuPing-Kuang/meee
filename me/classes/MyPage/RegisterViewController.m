//
//  RegisterViewController.m
//  me
//
//  Created by jam on 2018/1/11.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIView *otherLoginWayView;
@property (weak, nonatomic) IBOutlet UIButton *codeButton;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closelogin:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)gologin:(id)sender {
}


- (IBAction)wechatLogin:(id)sender {
}
- (IBAction)getVerifyCode:(id)sender {
}

@end
