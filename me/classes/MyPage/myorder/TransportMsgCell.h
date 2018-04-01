//
//  TransportMsgCell.h
//  me
//
//  Created by KLP on 2018/2/3.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransportMsgCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *expressStatusLb;
@property (weak, nonatomic) IBOutlet UILabel *transportCompanyLb;
@property (weak, nonatomic) IBOutlet UILabel *orderNumLb;
@property (weak, nonatomic) IBOutlet UIImageView *productImageV;
@property (weak, nonatomic) IBOutlet UILabel *productNameLb;
@property (weak, nonatomic) IBOutlet UILabel *productCountLb;

@property (weak, nonatomic) IBOutlet UILabel *addressLb;
@property (weak, nonatomic) IBOutlet UILabel *timeLb;
@property (weak, nonatomic) IBOutlet UIView *dotV;

@end
