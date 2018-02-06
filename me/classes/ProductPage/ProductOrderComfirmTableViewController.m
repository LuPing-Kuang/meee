//
//  ProductOrderComfirmTableViewController.m
//  me
//
//  Created by jam on 2018/1/9.
//  Copyright © 2018年 bangju. All rights reserved.
//

#import "ProductOrderComfirmTableViewController.h"

#import "MyAddressesTableViewController.h"
#import "ProductOrderBillViewController.h"

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

@interface ProductOrderComfirmTableViewController ()<ProductOrderMessageTableViewCellDelegate,MyAddressesTableViewControllerDelegate>
{
    NSArray<ProductionOrderGoodModel*>* goodModels;
    ProductionOrderDetailPriceModel* detailPriceModel;
    ProductionOrderAddressModel* addressModel;
    
    NSString* customMessage;
    
    ProductComfirmOrderToolBarView* bottomComfirmView;
    
}

@property (nonatomic, strong) NSString *optionid;
@property (nonatomic, strong) NSString *total;
@property (nonatomic, strong) NSString *gdid;
@property (nonatomic, strong) NSString *giftid;
@property (nonatomic, strong) NSString *liveid;


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
    
    self.optionid = optionid;
    self.total = total;
    self.gdid = gdid;
    self.giftid = giftid;
    self.liveid = liveid;

    //do get order comfirm detail
    MJWeakSelf;
    [ProductPageHttpTool getCreateOrderDetailCache:NO token:[UserModel token] idd:idd optionid:optionid total:total gdid:gdid giftid:giftid liveid:liveid success:^(NSArray *goods, ProductionOrderAddressModel *address, ProductionOrderDetailPriceModel *pricedetail) {
        goodModels=goods;
        detailPriceModel=pricedetail;
        addressModel=address;
        
        bottomComfirmView.money.text=[NSString stringWithFloat:detailPriceModel.realprice.doubleValue headUnit:@"¥" tailUnit:nil];
        [weakSelf.tableView reloadData];
        [weakSelf endRefresh];
    } failure:^(NSError *error) {
        [weakSelf endRefresh];
    }];
    
}

-(void)buyIt
{
    
    /*
     关于参数，除了必传参数外，其他参数，秉持有就传,没有就不传的原则
     两个参数尤为重要：1.gdid(用户填写表单返回的id) 2.fromcart( 0:非购物车;1:从购物车 )
     1.立即购买:gdid有参数且不能等于0，fromcart=0; 2.购物车内购买:gdid=0,fromcart=1。
     如果是购物车内购买，goods[]数组可以传多个，需要注意。
     */
    
    if (!addressModel) {
        [self showErrorMsg:@"请选择收货地址"];
        return;
    }
    
    NSLog(@"buy");
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:[NSNumber numberWithInt:0] forKey:@"orderid"];
    
    if (detailPriceModel.fromcart.integerValue==1) {
        [dic setValue:[NSNumber numberWithInt:0] forKey:@"id"];
    }else{
        [dic setValue:goodModels.firstObject.goodsid forKey:@"id"];
    }
    
    [dic setValue:self.gdid forKey:@"gdid"];
    [dic setValue:detailPriceModel.fromcart forKey:@"fromcart"];
    [dic setValue:addressModel.idd forKey:@"addressid"];
    
    
    for (NSInteger i=0; i<goodModels.count; i++) {
        ProductionOrderGoodModel *model = goodModels[i];

        [dic setValue:model.goodsid forKey:
         [NSString stringWithFormat:@"goods[%lu][goodsid]",i]];
        
        [dic setValue:model.total forKey:
         [NSString stringWithFormat:@"goods[%lu][total]",i]];
        
        [dic setValue:model.optionid forKey:
         [NSString stringWithFormat:@"goods[%lu][optionid]",i]];
        
        [dic setValue:model.marketprice forKey:
         [NSString stringWithFormat:@"goods[%lu][marketprice]",i]];
        
        [dic setValue:model.merchid forKey:
         [NSString stringWithFormat:@"goods[%lu][merchid]",i]];
        
        [dic setValue:model.cates forKey:
         [NSString stringWithFormat:@"goods[%lu][cates]",i]];
        
        [dic setValue:@"" forKey:
         [NSString stringWithFormat:@"goods[%lu][discounttype]",i]];
        
        [dic setValue:@"" forKey:
         [NSString stringWithFormat:@"goods[%lu][isdiscountprice]",i]];
        
        [dic setValue:@"" forKey:
         [NSString stringWithFormat:@"goods[%lu][discountprice]",i]];
        
        [dic setValue:@"" forKey:
         [NSString stringWithFormat:@"goods[%lu][isdiscountunitprice]",i]];
        
        [dic setValue:@"" forKey:
         [NSString stringWithFormat:@"goods[%lu][discountunitprice]",i]];
        
        [dic setValue:@"" forKey:
         [NSString stringWithFormat:@"goods[%lu][type]",i]];
        
        [dic setValue:@"" forKey:
         [NSString stringWithFormat:@"goods[%lu][intervalfloor]",i]];
        
        [dic setValue:@"" forKey:
         [NSString stringWithFormat:@"goods[%lu][intervalprice1]",i]];
        
        [dic setValue:@"" forKey:
         [NSString stringWithFormat:@"goods[%lu][intervalnum1]",i]];
        
        [dic setValue:@"" forKey:
         [NSString stringWithFormat:@"goods[%lu][intervalprice2]",i]];
        
        [dic setValue:@"" forKey:
         [NSString stringWithFormat:@"goods[%lu][intervalnum2]",i]];
        
        [dic setValue:@"" forKey:
         [NSString stringWithFormat:@"goods[%lu][intervalprice3]",i]];
        
        [dic setValue:@"" forKey:
         [NSString stringWithFormat:@"goods[%lu][intervalnum3]",i]];
        
        [dic setValue:@"" forKey:
         [NSString stringWithFormat:@"goods[%lu][wholesaleprice]",i]];
        
        [dic setValue:@"" forKey:
         [NSString stringWithFormat:@"goods[%lu][goodsalltotal]",i]];

        
    }
    
    
    [dic setValue:self.giftid forKey:@"giftid"];
    [dic setValue:@"" forKey:@"liveid"];
    [dic setValue:@"" forKey:@"dispatchtype"];
    [dic setValue:(customMessage==nil?@"":customMessage) forKey:@"remark"];
    [dic setValue:@"" forKey:@"diydata"];
    [dic setValue:@"" forKey:@"carrierid"];
    [dic setValue:@"" forKey:@"carriers"];
    [dic setValue:@"" forKey:@"deduct"];
    [dic setValue:@"" forKey:@"deduct2"];
    [dic setValue:@"" forKey:@"contype"];
    [dic setValue:@"" forKey:@"couponid"];
    [dic setValue:@"" forKey:@"wxid"];
    [dic setValue:@"" forKey:@"wxcardid"];
    [dic setValue:@"" forKey:@"wxcode"];
    [dic setValue:@"" forKey:@"submit"];
    [dic setValue:@"" forKey:@"packageid"];
    [dic setValue:@"" forKey:@"fromquick"];
    
    MJWeakSelf;
    [ProductPageHttpTool CreateOrderIdCache:NO token:[UserModel token] Param:dic success:^(NSString *orderId) {
        
        ProductOrderBillViewController* bill=[[UIStoryboard storyboardWithName:@"ProductPage" bundle:nil]instantiateViewControllerWithIdentifier:@"ProductOrderBillViewController"];
        bill.orderId = orderId;
        [weakSelf.navigationController pushViewController:bill animated:YES];
        
    } failure:^(NSString *errorMsg) {
        [weakSelf showErrorMsg:errorMsg];
    }];
    
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
        if (addressModel.address.length>0) {
            addressStr=[addressStr stringByAppendingString:addressModel.address];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==ProductOrderTableViewSectionAddress) {
        MyAddressesTableViewController* myadd=[[UIStoryboard storyboardWithName:@"MyPage" bundle:nil]instantiateViewControllerWithIdentifier:@"MyAddressesTableViewController"];
        myadd.delegate=self;
        [self.navigationController pushViewController:myadd animated:YES];
    }
}

#pragma mark ProductOrderMessageTableViewCellDelegate

-(void)productOrderMessageTableViewCell:(ProductOrderMessageTableViewCell *)cell textViewTextDidChanged:(UITextView *)textView
{
    customMessage=textView.text;
}

#pragma mark AddressTableviewController delegate

-(void)myAddressesTableViewController:(MyAddressesTableViewController *)controller didSelectedAddress:(ProductionOrderAddressModel *)address
{
    addressModel=address;
    [self.tableView reloadData];
    [self endRefresh];
}

@end
