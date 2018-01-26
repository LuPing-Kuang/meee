//
//  ProductOrderBillViewController.m
//  me
//
//  Created by jam on 2018/1/12.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "ProductOrderBillViewController.h"

@interface ProductOrderBillViewController ()
@property (weak, nonatomic) IBOutlet UILabel *orderNumber;
@property (weak, nonatomic) IBOutlet UILabel *orderPrice;
@property (weak, nonatomic) IBOutlet UILabel *myBalance;

@end

@implementation ProductOrderBillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"收银台";
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell* thisCell=[tableView cellForRowAtIndexPath:indexPath];
    if ([thisCell.reuseIdentifier isEqualToString:@"PayWithBalanceCell"]) {
        NSLog(@"pay with balance");
    }
}

@end
