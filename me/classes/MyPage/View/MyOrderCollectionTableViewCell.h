//
//  MyOrderCollectionTableViewCell.h
//  me
//
//  Created by jam on 2018/1/5.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimpleButtonsTableViewCell.h"
#import "LinedTableViewCell.h"

@interface MyOrderCollectionTableViewCell : LinedTableViewCell
@property (weak, nonatomic) IBOutlet SimpleButtonsTableViewCell *buttonsView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstraint;

-(void)setButtons:(NSArray<SimpleButtonModel*>*)buttons;
-(void)setDelegate:(id<SimpleButtonsTableViewCellDelegate>)delegate;

@end
