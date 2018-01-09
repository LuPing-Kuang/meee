//
//  ProductOrderComfirmTableViewController.m
//  me
//
//  Created by jam on 2018/1/9.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "ProductOrderComfirmTableViewController.h"

#import "ProductOrderTotalTableViewCell.h"
#import "ProductOrderAddressTableViewCell.h"
#import "ProductOrderDetailTableViewCell.h"
#import "ProductOrderMessageTableViewCell.h"
#import "ProductOrderGoodInfoTableViewCell.h"

#import "ProductComfirmOrderToolBarView.h"

#import "ProductPageHttpTool.h"

typedef NS_ENUM(NSInteger,ProductOrderTableViewSection)
{
    ProductOrderTableViewSectionAddress,
    ProductOrderTableViewSectionGoods,
    ProductOrderTableViewSectionMessage,
    ProductOrderTableViewSectionDetail,
    ProductOrderTableViewSectionTotalCount,
};

@interface ProductOrderComfirmTableViewController ()<ProductOrderMessageTableViewCellDelegate>
{
    NSArray<ProductionOrderGoodModel*>* goodModels;
    ProductionOrderDetailPriceModel* detailPriceModel;
    ProductionOrderAddressModel* addressModel;
    
    NSString* customMessage;
    
    ProductComfirmOrderToolBarView* bottomComfirmView;
}

@end

@implementation ProductOrderComfirmTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"确认订单";
    [self refresh];
//    [self.refreshControl beginRefreshing];
    
    bottomComfirmView=[[[UINib nibWithNibName:@"ProductComfirmOrderToolBarView" bundle:nil]instantiateWithOwner:nil options:nil]firstObject];
    CGRect fra=[self bottomFrame];
    bottomComfirmView.frame=fra;
    [self setBottomSubView:bottomComfirmView];
    [bottomComfirmView.buyButton addTarget:self action:@selector(buyIt) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refresh
{
    NSString* url=self.url;
    NSString* idd=[url stringValueFromUrlParamsKey:@"id"];
    NSString* optionid=[url stringValueFromUrlParamsKey:@"optionid"];
    NSString* total=[url stringValueFromUrlParamsKey:@"total"];
    NSString* gdid=[url stringValueFromUrlParamsKey:@"gdid"];
    NSString* giftid=[url stringValueFromUrlParamsKey:@"giftid"];
    NSString* liveid=[url stringValueFromUrlParamsKey:@"liveid"];
    
    //do get order comfirm detail
    
    [ProductPageHttpTool getCreateOrderDetailCache:NO token:[UserModel token] idd:idd optionid:optionid total:total gdid:gdid giftid:giftid liveid:liveid success:^(NSArray *goods, ProductionOrderAddressModel *address, ProductionOrderDetailPriceModel *pricedetail) {
        goodModels=goods;
        detailPriceModel=pricedetail;
        addressModel=address;
        
        bottomComfirmView.money.text=[NSString stringWithFloat:detailPriceModel.realprice.doubleValue headUnit:@"¥" tailUnit:nil];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [self.tableView reloadData];
    }];
    
}

-(void)buyIt
{
    NSLog(@"buy");
    [MBProgressHUD showSuccessMessage:@"买"];
}

#pragma mark tableview datasource delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return ProductOrderTableViewSectionTotalCount;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==ProductOrderTableViewSectionAddress) {
        return 1;
    }
    else if(section==ProductOrderTableViewSectionGoods)
    {
        return goodModels.count+2;
    }
    else if(section==ProductOrderTableViewSectionMessage)
    {
        return 1;
    }
    else if(section==ProductOrderTableViewSectionDetail)
    {
        return detailPriceModel.sectionShowingCount;
    }
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section=indexPath.section;
    NSInteger row=indexPath.row;
    if (section==ProductOrderTableViewSectionAddress) {
        ProductOrderAddressTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"ProductOrderAddressTableViewCell" forIndexPath:indexPath];
        cell.addNewView.hidden=addressModel.idd.length>0;
        cell.normalView.hidden=addressModel.idd.length==0;
        cell.name.text=addressModel.realname;
        cell.phone.text=addressModel.mobile;
        
        NSString* addressStr=@"";
        if (addressModel.province.length>0) {
            addressStr=[addressStr stringByAppendingString:addressModel.province];
        }
        if (addressModel.city.length>0) {
            addressStr=[addressStr stringByAppendingString:addressModel.city];
        }
        if (addressModel.area.length>0) {
            addressStr=[addressStr stringByAppendingString:addressModel.area];
        }
        if (addressModel.street.length>0) {
            addressStr=[addressStr stringByAppendingString:addressModel.street];
        }
        cell.address.text=addressStr;
        
        return cell;
    }
    else if(section==ProductOrderTableViewSectionGoods)
    {
        if (row==0) {
            return [tableView dequeueReusableCellWithIdentifier:@"ProductOrderListHeaderTableViewCell" forIndexPath:indexPath];
        }
        else if(row==[tableView numberOfRowsInSection:section]-1)
        {
            ProductOrderTotalTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"ProductOrderTotalTableViewCell" forIndexPath:indexPath];
            cell.count.text=[NSString stringWithFormat:@"%ld",(long)detailPriceModel.total.integerValue];
            cell.price.text=[NSString stringWithFloat:detailPriceModel.goodsprice.doubleValue headUnit:@"¥" tailUnit:nil];
            return cell;
        }
        ProductOrderGoodInfoTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"ProductOrderGoodInfoTableViewCell" forIndexPath:indexPath];
        ProductionOrderGoodModel* goo=[goodModels objectAtIndex:row-1];
        [cell.image setImageUrl:goo.thumb];
        cell.title.text=goo.title;
        cell.option.text=goo.optiontitle;
        cell.price.text=[NSString stringWithFloat:goo.price.doubleValue headUnit:@"¥" tailUnit:nil];
        cell.count.text=[NSString stringWithFormat:@"x%ld",(long)goo.total.integerValue];
        return cell;
    }
    else if(section==ProductOrderTableViewSectionMessage)
    {
        ProductOrderMessageTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"ProductOrderMessageTableViewCell" forIndexPath:indexPath];
        cell.delegate=self;
        cell.message=customMessage;
        return cell;
    }
    else if(section==ProductOrderTableViewSectionDetail)
    {
        ProductOrderDetailTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"ProductOrderDetailTableViewCell" forIndexPath:indexPath];
        cell.title.text=nil;
        cell.money.text=nil;
        if(row==0)
        {
            cell.title.text=@"商品小计";
            cell.money.text=[NSString stringWithFloat:detailPriceModel.goodsprice.doubleValue headUnit:@"¥" tailUnit:nil];
        }
        else if(row==[tableView numberOfRowsInSection:section]-1)
        {
            cell.title.text=@"运费";
            cell.money.text=[NSString stringWithFloat:detailPriceModel.dispatch_price.doubleValue headUnit:@"¥" tailUnit:nil];
        }
        else if(row==[tableView numberOfRowsInSection:section]-2)
        {
            cell.title.text=[NSString stringWithFormat:@"商城优惠：满%.0f立减%.0f",detailPriceModel.enoughmoney.doubleValue,detailPriceModel.enoughdeduct.doubleValue];
            double showingDiscountMoney=0;
            if (detailPriceModel.showenough.boolValue) {
                showingDiscountMoney=-detailPriceModel.enoughdeduct.doubleValue;;
            }
            cell.money.text=[NSString stringWithFloat:showingDiscountMoney headUnit:@"¥" tailUnit:nil];
        }
        else
        {
            cell.title.text=@"会员优惠";
            cell.money.text=[NSString stringWithFloat:-detailPriceModel.discountprice.doubleValue headUnit:@"¥" tailUnit:nil];
        }
        return cell;
    }
    
    return [[UITableViewCell alloc]init];
}

#pragma mark ProductOrderMessageTableViewCellDelegate

-(void)productOrderMessageTableViewCell:(ProductOrderMessageTableViewCell *)cell textViewTextDidChanged:(UITextView *)textView
{
    customMessage=textView.text;
}

@end
