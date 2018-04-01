//
//  SelectedAllActionView.m
//  me
//
//  Created by jam on 2018/1/11.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "SelectedAllActionView.h"

@implementation SelectedAllActionView

-(void)setSelectedAll:(BOOL)selectedAll
{
    _selectedAll=selectedAll;
    self.selectAllButton.selected=selectedAll;
}



@end
