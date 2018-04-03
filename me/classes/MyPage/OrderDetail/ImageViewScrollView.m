//
//  ImageViewScrollView.m
//  me
//
//  Created by 邝路平 on 2018/4/1.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "ImageViewScrollView.h"
#import "ImageCollectionViewCell.h"
#import "YTAnimation.h"

@interface ImageViewScrollView()<UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) ImageViewScrollView *scrollView;

@property (nonatomic,strong)UIImagePickerController *imgPicController;
@property (nonatomic,assign) BOOL isVibrateAni;


@end

@implementation ImageViewScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGFloat w = (UIScreenWidth - 85 - 4*5) /3.0;
        
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(w, self.bounds.size.height);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
        
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width,self.bounds.size.height) collectionViewLayout:layout];
        collectionView.backgroundColor = RGB(250, 250, 250);
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.scrollsToTop = NO;
        collectionView.showsVerticalScrollIndicator = true;
        collectionView.showsHorizontalScrollIndicator = false;
        collectionView.pagingEnabled = true;
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        self.collectionView = collectionView;
        
        self.ImageArr = [NSMutableArray array];
        [self.ImageArr addObject:[UIImage imageNamed:@"相册"]];
        
        //注册cell
        [collectionView registerClass:[ImageCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([ImageCollectionViewCell class])];
        
        
        [self addSubview:self.collectionView];
    }
    return self;
}


- (void)addImageArr:(NSArray*)ImageArr{
    _ImageArr = ImageArr;
    [self.collectionView reloadData];
}




- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1.0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.ImageArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ImageCollectionViewCell class]) forIndexPath:indexPath];
//    cell.imageV.image = self.ImageArr[indexPath.row];
   
     
    
    
    return cell;
}


#pragma mark -
#pragma mark - 抖动
- (void)vibrateAni:(BOOL)isVibrate{
    self.isVibrateAni = isVibrate;
    [self.collectionView reloadData];
}





- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == self.ImageArr.count - 1) {
        [self goToSelectImage];
    }
    
}

- (void)goToSelectImage{
    MJWeakSelf;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"上传头像" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        weakSelf.imgPicController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [weakSelf.viewController.navigationController presentViewController:_imgPicController animated:YES completion:nil];
        
    }];
    
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"从相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        weakSelf.imgPicController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [weakSelf.viewController.navigationController presentViewController:_imgPicController animated:YES completion:nil];
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }];
    
    
    [alert addAction:photoAction];
    [alert addAction:albumAction];
    [alert addAction:cancelAction];
    
    [self.viewController.navigationController presentViewController:alert animated:YES completion:nil];
}


#pragma mark -
#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{

    [picker dismissViewControllerAnimated:YES completion:nil];
    NSData *cutimage = UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerEditedImage], 0.3);
    
    if (!cutimage) {
        cutimage = UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerOriginalImage], 0.3);
    }
    
    
    UIImage *img = [UIImage imageWithData:cutimage];
    
    [self.ImageArr insertObject:img atIndex:self.ImageArr.count - 1];
    [self.collectionView reloadData];
    
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
