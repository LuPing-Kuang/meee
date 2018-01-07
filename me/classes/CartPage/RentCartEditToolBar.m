//
//  RentCartEditToolBar.m
//  zhanmao
//
//  Created by bangju on 2017/11/1.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "RentCartEditToolBar.h"

@implementation RentCartEditToolBar

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.editing=NO;
}

-(void)setEditing:(BOOL)editing
{
    _editing=editing;
//    self.moneyBg.hidden=editing;
    self.normalView.hidden=editing;
    self.editingView.hidden=!editing;
}

-(void)setSeletedAll:(BOOL)seletedAll
{
    _seletedAll=seletedAll;
    
    self.selectAllButton.selected=seletedAll;
//    NSString* imgN=seletedAll?@"icon_search":@"eyeGray";
//    [self.selectAllButton setImage:[UIImage imageNamed:imgN] forState:UIControlStateNormal];
}

@end
