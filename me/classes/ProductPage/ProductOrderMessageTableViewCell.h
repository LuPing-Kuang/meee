//
//  ProductOrderMessageTableViewCell.h
//  me
//
//  Created by jam on 2018/1/9.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProductOrderMessageTableViewCell;

@protocol ProductOrderMessageTableViewCellDelegate <NSObject>

-(void)productOrderMessageTableViewCell:(ProductOrderMessageTableViewCell*)cell textViewTextDidChanged:(UITextView*)textView;

@end

@interface ProductOrderMessageTableViewCell : UITableViewCell

@property (nonatomic,strong) NSString* message;
@property (nonatomic,weak) id<ProductOrderMessageTableViewCellDelegate> delegate;

@end
