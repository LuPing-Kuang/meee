//
//  ReportNewsCell.m
//  me
//
//  Created by KLP on 2018/1/29.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "ReportNewsCell.h"

@interface ReportNewsCell()
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageV;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *timeLb;



@end

@implementation ReportNewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setReportModel:(ReportNewsModel *)reportModel{
    _reportModel = reportModel;
    [self.avatarImageV setImageUrl:_reportModel.thumb];
    self.titleLb.text = _reportModel.title;
    self.timeLb.text = _reportModel.createtime;
}

@end
