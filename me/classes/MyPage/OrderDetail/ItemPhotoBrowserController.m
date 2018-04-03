//
//  ItemPhotoBrowserController.m
//  main
//
//  Created by URoad_MP on 15/5/26.
//  Copyright (c) 2015年 com.URoad. All rights reserved.
//

#import "ItemPhotoBrowserController.h"
#import "ItemPhotoBrowserImageView.h"
@interface ItemPhotoBrowserController ()<UIScrollViewDelegate,UIActionSheetDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scView;
@property (strong, nonatomic) IBOutlet UILabel *contentLb;
@property (strong, nonatomic) IBOutlet UIPageControl *pageC;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (nonatomic,strong)NSMutableArray *attachArray;
@property (nonatomic,strong)NSArray *titles;
@property (nonatomic,assign)NSInteger startIndex;
@property (nonatomic,strong)NSMutableArray *imgs;
@end

@implementation ItemPhotoBrowserController{
    BOOL markStyle2;
    
}
- (id)initControllerWithArray:(NSArray *)array withSelectIndex:(NSInteger)index needDelBtn:(BOOL)IsNeed{
    self = [super init];
    if (self) {
        self.title = @"查看图片";
        if (IsNeed) {
            UIButton *delBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
            [delBtn setTitle:@"删除" forState:UIControlStateNormal];
            [delBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [delBtn addTarget:self action:@selector(deleteSelector) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *deleteItem = [[UIBarButtonItem alloc]initWithCustomView:delBtn];
            self.navigationItem.rightBarButtonItem = deleteItem;
        }
        _attachArray = [[NSMutableArray alloc]initWithArray:array];
        if (SYSTEM_VERSION_LATER_THAN_7_0) {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _startIndex= index;
    }
    return self;
}
-(void)confiStyle2{
    markStyle2=true;
}

- (void)deleteSelector{
    UIActionSheet *delete = [[UIActionSheet alloc]initWithTitle:@"确定删除吗？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [delete showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        NSLog(@"删除");
        
        [self.attachArray removeObjectAtIndex:_startIndex];
        [_imgs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UIView *v = obj;
            [v removeFromSuperview];
            
        }];
       
        [[NSNotificationCenter defaultCenter]postNotificationName:@"ReloadImageCell" object:[NSNumber numberWithInteger:_startIndex]];
        
        _startIndex = 0;
        [_imgs removeAllObjects];
        if (_imgs.count == 0) {
            [self.navigationController popViewControllerAnimated:true];
            
            return;
        }
        _scView.contentSize = CGSizeMake(0, 0);
        [self configUI];
        
    }
}

- (void)configUI{
    _imgs = [NSMutableArray array];
    __block CGFloat x = 0;
    CGFloat top = 0;
    if (SYSTEM_VERSION_LATER_THAN_7_0) {
        top = 40;
    }
    [_attachArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        ItemPhotoBrowserImageView *subV = [[ItemPhotoBrowserImageView alloc]initViewWithImage:obj];
//        [subV setImgClickBlock:^{
//            if(markStyle2){
//                raiseBlockVoid(style2ImgVClick);
//            }else{
//              [[GlobalObjEty sharedNaviController]dismissViewControllerAnimated:YES completion:nil];
//            }
//            
//        }];
        subV.frame = CGRectMake(x, top, UIScreenWidth, _scView.height_gst-40);
        subV.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [_scView addSubview:subV];
        x = CGRectGetMaxX(subV.frame);
        subV.tapBlock = ^{
            BOOL hidden = self.navigationController.navigationBarHidden;
            [self.navigationController setNavigationBarHidden:!hidden animated:YES];
            
            [UIView animateWithDuration:0.3 animations:^{
                if (hidden) {
                    self.bottomView.top_gst = self.view.height_gst - 45;
                }else{
                    self.bottomView.top_gst = self.view.height_gst;
                }
            }];
        };
        [_imgs addObject:subV];
    }];
    _scView.delegate = self;
    _pageC.numberOfPages = _attachArray.count;
    _scView.contentSize = CGSizeMake(x, _scView.height_gst);
    
    [self showContentTitleWithIndex:_startIndex];
    [_scView setContentOffset:CGPointMake(UIScreenWidth*_startIndex, 0)];
    _pageC.currentPage = _startIndex;
    self.contentLb.text = [NSString stringWithFormat:@"照片数量:%lu/%lu",_startIndex+1,self.attachArray.count];
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self configUI];

    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat off_x = scrollView.contentOffset.x;
    NSInteger page = off_x / UIScreenWidth;
    _pageC.currentPage = page;
    _startIndex = page;
//    [self showContentTitleWithIndex:page];
    self.contentLb.text = [NSString stringWithFormat:@"照片数量:%lu/%lu",page+1,self.attachArray.count];
}

- (void)showContentTitleWithIndex:(NSInteger)index{
//    NSString *ety = _titles[index];
//    _contentLb.text = SAFE_STRING(ety);
    
//    ItemPhotoBrowserImageView *imgV = _imgs[index];
//    [imgV startLoad];
}
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
