//
//  ReportTakePhotoViewVariedHeight.m
//  nmjj_ios
//
//  Created by luo_Mac on 2017/6/14.
//  Copyright © 2017年 UI-5. All rights reserved.
//

#import "ReportTakePhotoViewVariedHeight.h"

#import "ImageCollectionViewCell.h"
#import "ItemPhotoBrowserController.h"
#import "CTAssetsPickerController.h"


static NSString *const cellIdentifier = @"cellIdentifier";
static NSInteger const limitTakePhotoCount = 6;

#define kCellWidth (((UIScreenWidth-85)/3.0)-10)
#define kCellHeight (DEVICE_IS_IPHONE_5?50:60)



@interface ReportTakePhotoViewVariedHeight()<UICollectionViewDelegate,UICollectionViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,CTAssetsPickerControllerDelegate>
@property (nonatomic,strong) UICollectionView *collectionView;



@property (nonatomic,strong)UIActionSheet *takePhotoSheet;
@property (nonatomic,strong)UIImagePickerController *imgPicController;
@property (nonatomic,strong)CTAssetsPickerController *libraryPicker;


@property (nonatomic,assign) CGFloat collectionVHeight;


@end

@implementation ReportTakePhotoViewVariedHeight


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(kCellWidth, kCellHeight);
//        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width,self.height_gst) collectionViewLayout:layout];
        self.collectionVHeight = self.height_gst;
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 5;
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.scrollsToTop = NO;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.pagingEnabled = NO;
//        collectionView.scrollEnabled = NO;
        
        
        self.collectionView = collectionView;

        
        //注册cell
        [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([ImageCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:cellIdentifier];
        
        self.takeImgs = [NSMutableArray array];
        
        [self addSubview:self.collectionView];
        
        
        self.takePhotoSheet = [[UIActionSheet alloc]initWithTitle:@"提示" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从手机相册选择", nil];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadImageUI:) name:@"ReloadImageCell" object:nil];
        
    }
    return self;
}





- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1.0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    CGFloat count = ceil(((self.takeImgs.count+1)/3.0));
    
    if (self.takeImgs.count == limitTakePhotoCount) {
        self.collectionVHeight = (count - 1)*kCellHeight+(count+1 - 1)*5;
    }else {
        self.collectionVHeight = count*kCellHeight+(count+1)*5;
    }
    
    
    
    if (self.resultHeight) {
        self.resultHeight(self.collectionVHeight);
    }
    
    collectionView.frame = CGRectMake(0, 0, self.bounds.size.width,self.collectionVHeight);
    self.height_gst = self.collectionVHeight;
    
    return self.takeImgs.count+1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (indexPath.row==self.takeImgs.count) {
        cell.backgroundImageView.hidden = NO;
        cell.ImageView.image = nil;
        cell.hidden = NO;
        if (self.takeImgs.count==limitTakePhotoCount) {
            cell.hidden = YES;
        }
    }else{
        cell.hidden = NO;
        cell.ImageView.image = self.takeImgs[indexPath.row];
        cell.backgroundImageView.hidden = YES;


    }
    
    return cell;
}


//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kCellWidth, kCellHeight);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==self.takeImgs.count) {
        [self takePhotoAction];
    }else{
        
        ItemPhotoBrowserController *vc = [[ItemPhotoBrowserController alloc]initControllerWithArray:self.takeImgs withSelectIndex:indexPath.row needDelBtn:YES];
        [self.viewController.navigationController pushViewController:vc animated:YES];
    }
    
}

- (void)reloadImageUI:(NSNotification *)no{
    NSNumber *index =no.object;
    [self.takeImgs removeObjectAtIndex:index.integerValue];
    [self.collectionView reloadData];
}


- (UIImagePickerController *)imgPicController
{
    if (!_imgPicController) {
        _imgPicController = [[UIImagePickerController alloc]init];
        _imgPicController.delegate = self;
        _imgPicController.sourceType = UIImagePickerControllerSourceTypeCamera;
        _imgPicController.allowsEditing = NO;
        
    }
    return _imgPicController;
}
- (CTAssetsPickerController *)libraryPicker{
    if (!_libraryPicker) {
        _libraryPicker = [[CTAssetsPickerController alloc]init];
        _libraryPicker.assetsFilter         = [ALAssetsFilter allPhotos];
        _libraryPicker.showsCancelButton    = (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad);
        _libraryPicker.delegate             = self;
        
    }
    return _libraryPicker;
}



- (void)takePhotoAction{
    if (self.takeImgs.count == limitTakePhotoCount) {
        
        NSString *notice = [NSString stringWithFormat:@"最多可上传%ld张",(long)limitTakePhotoCount];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:notice delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
        
    }
    
    [self.takePhotoSheet showInView:[UIApplication sharedApplication].keyWindow];

}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    NSLog(@"info:%@",info);
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSData *data = [self imageCompressToData:img];    //压缩图片
    img = [UIImage imageWithData:data];
    
    
    CGFloat count = ceil((self.takeImgs.count+1)/5);
    
    if (self.resultHeight) {
        self.resultHeight(count*kCellHeight);
    }
    
    if (img) {
        if (self.takeImgs.count==limitTakePhotoCount) {
            [self.takeImgs removeAllObjects];
        }
        
//        [self.takeImgs addObject:[img limitImgWithLen:600]];
        [self.takeImgs addObject:img];
        [self.collectionView reloadData];
        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
    }
}


///压缩图片
- (NSData *)imageCompressToData:(UIImage *)image{
    NSData *data=UIImageJPEGRepresentation(image, 1.0);
    if (data.length>300*1024) {
        if (data.length>1024*1024) {//1M以及以上
            data=UIImageJPEGRepresentation(image, 0.1);
        }else if (data.length>512*1024) {//0.5M-1M
            data=UIImageJPEGRepresentation(image, 0.5);
        }else if (data.length>300*1024) {//0.25M-0.5M
            data=UIImageJPEGRepresentation(image, 0.9);
        }
    }
    return data;
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            self.imgPicController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self.viewController.navigationController presentViewController:self.imgPicController animated:YES completion:nil];
            
            break;
        case 1:
            self.libraryPicker.selectedAssets = [[NSMutableArray alloc]init];
            
            [self.viewController.navigationController presentViewController:self.libraryPicker animated:YES completion:nil];
            
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
            
            //            self.imgPicController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            //            [MAIN_NAVI_CONTROLLER presentViewController:self.imgPicController animated:YES completion:nil];
            
            break;
        default:
            break;
    }
}


#pragma mark - Assets Picker Delegate

- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker isDefaultAssetsGroup:(ALAssetsGroup *)group
{
    return ([[group valueForProperty:ALAssetsGroupPropertyType] integerValue] == ALAssetsGroupSavedPhotos);
}

- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
    [assets enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ALAsset *asset = obj;
        
        CGFloat size = [[asset defaultRepresentation] size] ;
        NSString *imageSize = [NSString stringWithFormat:@"%f",size];
        
        
        
        ALAssetRepresentation *repr = asset.defaultRepresentation;
        UIImage *img = [UIImage imageWithCGImage:repr.fullScreenImage];
        
        if (imageSize.integerValue/1024/1024>1) {  //大于1MB就进行图片压缩
            NSData *data = UIImageJPEGRepresentation(img, 0.6);    //压缩图片
            img = [UIImage imageWithData:data];
        }
        
        
//        [self.takeImgs addObject:[img limitImgWithLen:800]];
        [self.takeImgs addObject:img];
    }];
    
    [self.collectionView reloadData];
    
}

- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldEnableAsset:(ALAsset *)asset
{
    // Enable video clips if they are at least 5s
    if ([[asset valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo])
    {
        NSTimeInterval duration = [[asset valueForProperty:ALAssetPropertyDuration] doubleValue];
        return lround(duration) >= 5;
    }
    else
    {
        return YES;
    }
}

- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldSelectAsset:(ALAsset *)asset
{
    if (picker.selectedAssets.count >= limitTakePhotoCount-self.takeImgs.count)
    {
        NSString*count = [NSString stringWithFormat:@"只能选择%ld张",(long)(limitTakePhotoCount - self.takeImgs.count)];
        UIAlertView *alertView =
        [[UIAlertView alloc] initWithTitle:@"提示"
                                   message:count
                                  delegate:nil
                         cancelButtonTitle:nil
                         otherButtonTitles:@"确定", nil];
        
        [alertView show];
    }
    
    if (!asset.defaultRepresentation)
    {
        UIAlertView *alertView =
        [[UIAlertView alloc] initWithTitle:@"提示"
                                   message:@"没有数据"
                                  delegate:nil
                         cancelButtonTitle:nil
                         otherButtonTitles:@"OK", nil];
        
        [alertView show];
    }
    
    return (picker.selectedAssets.count < (limitTakePhotoCount - self.takeImgs.count) && asset.defaultRepresentation != nil);
}



@end
