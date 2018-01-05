//
//  MySimpleTableViewCell.m
//  me
//
//  Created by jam on 2018/1/5.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "MySimpleTableViewCell.h"

@interface MySimpleTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *badgeLabel;
@property (weak, nonatomic) IBOutlet UIView *badgeBackground;


@end

@implementation MySimpleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setBadge:(NSInteger)badge
{
    _badge=badge;
    
    self.badgeLabel.text=[NSString stringWithFormat:@"%ld",(long)_badge];
    if (badge>99) {
        self.badgeLabel.text=@"99+";
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.badgeBackground.hidden=_badge<=0;
    self.detail.hidden=!self.badgeBackground.hidden;
    self.badgeBackground.layer.cornerRadius=self.badgeBackground.frame.size.height/2;
    self.badgeBackground.clipsToBounds=YES;
}

@end
