//
//  BaseTableViewController.h
//  yangsheng
//
//  Created by jam on 17/7/6.
//  Copyright © 2017年 jam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdvertiseView.h"

@interface BaseTableViewController : UITableViewController<AdvertiseViewDelegate>

@property (nonatomic,strong) NSMutableArray* dataSource;
@property (nonatomic,strong) NSMutableArray* advsArray;
//@property (nonatomic,strong) NSString* urlString;

@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,assign) NSInteger pageSize;
@property (nonatomic,assign) BOOL shouldLoadMore;

-(void)firstLoad;
-(void)refresh;
-(void)stopRefreshAfterSeconds;

-(void)loadMore;

-(void)setAdvertiseHeaderViewWithPicturesUrls:(NSArray*)picturesUrls;

-(void)showLoadMoreView;
-(void)hideLoadMoreView;

-(void)tableViewReloadData;

- (void)startAnimation;
- (void)stopAnimation;
-(void)showMessage:(NSString *)msg;
- (void)showErrorMsg:(NSString *)errmsg;
- (void)showSuccessMsg:(NSString *)msg;
- (void)showLoading:(NSString *)msg;

-(void)showSystemAlertWithTitle:(NSString *)title
                        message:(NSString*)message
                    buttonTitle:(NSString *)btntitle
                needDestructive:(BOOL)needDistory
                    cancleBlock: (void (^)(UIAlertAction *action))cancleBlock
                       btnBlock:(void (^)(UIAlertAction *action))btnBlock ;

- (void)showloginVc;



@end
