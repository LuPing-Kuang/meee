//
//  MyFavouriteSelectedAllActionView.m
//  me
//
//  Created by KLP on 2018/1/27.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "MyFavouriteSelectedAllActionView.h"

@implementation MyFavouriteSelectedAllActionView

-(void)setSelectedAll:(BOOL)selectedAll
{
    _selectedAll=selectedAll;
    self.selectAllButton.selected=selectedAll;
}

@end
