//
//  HomeFourCollectionViewCell.h
//  me
//
//  Created by jam on 2017/12/27.
//  Copyright © 2017年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimpleButtonsTableViewCell.h"

@interface HomeFourCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet SimpleButtonsTableViewCell *buttonsCell;

-(void)setButtons:(NSArray<SimpleButtonModel*>*)buttons;
-(void)setDelegate:(id<SimpleButtonsTableViewCellDelegate>)delegate;

@end
