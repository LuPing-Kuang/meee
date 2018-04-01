//
//  ModifyMyAvatarAndNickNameController.m
//  me
//
//  Created by KLP on 2018/2/26.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "ModifyMyAvatarAndNickNameController.h"
#import "MyPageHttpTool.h"
#import "PartnerMaterialModel.h"

@interface ModifyMyAvatarAndNickNameController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *iconImageV;
@property (weak, nonatomic) IBOutlet UITextField *nickNameTf;
@property (weak, nonatomic) IBOutlet UITextField *mobileTf;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@property (nonatomic,strong)UIImagePickerController *imgPicController;


@property (nonatomic, strong) PartnerMaterialModel *model;
@property (nonatomic,assign) BOOL hasData;

@end

@implementation ModifyMyAvatarAndNickNameController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"编辑用户头像";
    
    [self.iconImageV setImageUrl:self.avatar];
    self.nickNameTf.text = self.nickName;
    self.mobileTf.text = self.mobile;
    
    self.saveBtn.layer.cornerRadius = 5.0;
    self.saveBtn.layer.masksToBounds = YES;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    MJWeakSelf;
    [self.iconImageV setTapAction:^(UITapGestureRecognizer *tap) {
        [weakSelf goToSelectImage];
    }];
    
    
    if (self.isFromHome) {
        [self refresh];
    }
    
    
}

-(void)refresh
{
    if (self.isFromHome) {
        [self loadDataFromLocal:NO];
    }
    
}

-(void)loadDataFromLocal:(BOOL)local
{
    MJWeakSelf;
    [MyPageHttpTool getMyMaterialPartnerCache:local token:[UserModel token] success:^(PartnerMaterialModel *model) {
        weakSelf.model = model;
        
        [weakSelf endRefresh];
        weakSelf.hasData = true;
        [weakSelf.tableView reloadData];
    } failure:^(NSString *errormsg) {
        
        [weakSelf showErrorMsg:errormsg];
        [weakSelf endRefresh];
        weakSelf.hasData = false;
    }];
}


- (void)setModel:(PartnerMaterialModel *)model{
    _model = model;
    
    self.nickName = _model.nickname;
    self.avatar = _model.avatar;
    self.mobile = _model.mobile;
    
    [self.iconImageV setImageUrl:self.avatar];
    self.nickNameTf.text = self.nickName;
    self.mobileTf.text = self.mobile;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (self.isFromHome) {
        if (self.hasData) {
            return 2.0;
        }else{
            return 0.0;
        }
    }else{
        return 2.0;
    }
    
    
}




- (IBAction)saveBtnClick:(UIButton *)sender {
    if (self.nickNameTf.text.length==0) {
        [self showErrorMsg:@"请输入您的昵称"];
        return;
    }
    if (self.avatar.length==0) {
        [self showErrorMsg:@"请从相册中选择头像"];
        return;
    }
    [self showLoading:@"保存中..."];
    MJWeakSelf;
    [MyPageHttpTool saveMyNickName:self.nickNameTf.text avatar:self.avatar withCompleted:^(id result, BOOL success) {
        if (success) {
            if (weakSelf.needToReload) {
                weakSelf.needToReload();
            }
            [weakSelf showSuccessMsg:@"保存成功"];
            
            if (weakSelf.isFromHome) {
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            }
            
        }else{
            [weakSelf showErrorMsg:result];
        }
    }];
    
}


- (void)goToSelectImage{
    MJWeakSelf;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"上传头像" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        weakSelf.imgPicController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [weakSelf.navigationController presentViewController:_imgPicController animated:YES completion:nil];
        
    }];
    
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"从相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        self.imgPicController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self.navigationController presentViewController:_imgPicController animated:YES completion:nil];
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    
    
    [alert addAction:photoAction];
    [alert addAction:albumAction];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)uploadUserIcon:(UIImage*)image{
    [self showLoading:@"上传中..."];
    MJWeakSelf;
    [MyPageHttpTool uploadMyIcon:image withCompleted:^(id result, BOOL success) {
        if (success) {
            NSString *url = result[@"url"];
            weakSelf.avatar = [NSString stringWithFormat:@"http://ewei.bangju.com/attachment/%@",url];
            
            [weakSelf.iconImageV setImageUrl:weakSelf.avatar];
            [weakSelf showSuccessMsg:@"上传成功"];
            
        }else{
            [weakSelf showErrorMsg:result];
        }
    }];
}

#pragma mark -
#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSData *cutimage = UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerEditedImage], 0.3);
    
    if (!cutimage) {
        cutimage = UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerOriginalImage], 0.3);
    }
    
    
    UIImage *img = [UIImage imageWithData:cutimage];
    
    [self uploadUserIcon:img];
    
}


#pragma mark -
#pragma mark - 懒加载
- (UIImagePickerController*)imgPicController{
    if (_imgPicController==nil) {
        _imgPicController = [[UIImagePickerController alloc]init];
        _imgPicController.delegate = self;
        _imgPicController.allowsEditing = YES;
    }
    return _imgPicController;
}





@end
