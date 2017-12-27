//
//  HomeFourCollectionViewCell.m
//  me
//
//  Created by jam on 2017/12/27.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import "HomeFourCollectionViewCell.h"

@implementation HomeFourCollectionViewCell

-(void)setButtons:(NSArray<SimpleButtonModel *> *)buttons
{
    self.buttonsCell.buttons=buttons;
}

-(void)setDelegate:(id<SimpleButtonsTableViewCellDelegate>)delegate
{
    self.buttonsCell.delegate=delegate;
}

@end
