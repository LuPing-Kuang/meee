//
//  ApplyItemSelectView.m
//  me
//
//  Created by 邝路平 on 2018/4/1.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "ApplyItemSelectView.h"

@interface ApplyItemSelectView()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@property (nonatomic,strong) UITableView *tableV;
@property (nonatomic,assign) CGRect rect;
@property (nonatomic,strong) NSArray *titleArr;

@property (nonatomic, strong) UIView *contentV;


@property (nonatomic,copy) void(^selectBlock)(NSInteger index);

@end

@implementation ApplyItemSelectView

+ (void)showWithButtonRect:(CGRect)rect SelectBlock:(void(^)(NSInteger index))selectBlock TitleArr:(NSArray*)titelArr{
    ApplyItemSelectView *v = [[ApplyItemSelectView alloc]initWithButtonRect:rect TitleArr:titelArr];
    v.selectBlock = selectBlock;
    [[UIApplication sharedApplication].keyWindow addSubview:v];
    
    [UIView animateWithDuration:0.2 animations:^{
        v.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    } completion:^(BOOL finished) {
        
    }];
}

- (instancetype)initWithButtonRect:(CGRect)rect TitleArr:(NSArray*)titelArr{
    self = [super initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
    if (self) {
        self.rect = rect;
        self.titleArr = titelArr;
        [self setupSubViews];
    }
    return self;
    
}

- (void)setTitleArr:(NSArray *)titleArr{
    _titleArr = titleArr;
    if (_titleArr.count != 0) {
        [self.tableV reloadData];
    }
}

- (void)setupSubViews{
    
    CGFloat navH = 64;
    if (DEVICE_IS_IPHONE_X) {
        navH = 84;
    }
    
    CGFloat x = self.rect.origin.x + 85;
    CGFloat y = self.rect.origin.y + 40 + navH;
    CGFloat w = 180;
    CGFloat h = 40 * self.titleArr.count;
    self.backgroundColor = [UIColor clearColor];
    
    //    MJWeakSelf;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(HandleTap)];
    tap.delegate = self;
    tap.numberOfTouchesRequired = 1.0;
    [self addGestureRecognizer:tap];
    
    self.contentV = [[UIView alloc]initWithFrame:CGRectMake(x, y, w, h)];
    self.contentV.backgroundColor = [UIColor clearColor];
    

    
    [self addSubview:self.contentV];
    
    self.contentV.layer.cornerRadius = 8.0;
    self.contentV.layer.masksToBounds = true;
    self.contentV.layer.borderWidth = 1.0;
    self.contentV.layer.borderColor = _redColor.CGColor;
    
    UITableView *tableV = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableV.tableHeaderView = [[UIView alloc]init];
    tableV.tableFooterView = [[UIView alloc]init];
    tableV.rowHeight = 44;
    [tableV registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.separatorColor = RGB(240, 240, 240);
    tableV.rowHeight = 40;
    tableV.showsVerticalScrollIndicator = false;
    
    self.tableV = tableV;
    self.tableV.frame = self.contentV.bounds;
    [self.contentV addSubview:self.tableV];
    
}


- (void)HandleTap{
    [self removeFromSuperview];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArr.count;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.text = self.titleArr[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.selectBlock) {
        self.selectBlock(indexPath.row);
    }
    [self removeFromSuperview];
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}


- (void)dealloc{
    NSLog(@"[ApplyItemSelectView dealloc]");
}







@end
