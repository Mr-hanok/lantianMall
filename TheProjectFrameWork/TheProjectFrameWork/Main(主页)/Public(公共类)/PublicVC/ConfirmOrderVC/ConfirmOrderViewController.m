//
//  ConfirmOrderViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/25.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ConfirmOrderViewController.h"
#import "BuyAndSendAddressTableViewCell.h"
#import "BuyAndSendSizeTableViewCell.h"
#import "BuyAndSendCostTableViewCell.h"
#import "ShoppingCostDetialsView.h"
#import "MywalletViewController.h"
#import "BuyAndSendTouristsTableViewCell.h"
#import "OrderTableHeadView.h"
#import "OrderTableViewCell.h"
#import "DistributionFootView.h"
#import "DistributionTypeSelectVCViewController.h"
#import "ShippingDetailVCViewController.h"
#import "GoodsDetialViewController.h"
#import "EditAddressNewViewController.h"
#import "ConfirmOrderModel.h"
#import "StoreOrderModel.h"
#import "GoodsOrderModel.h"
#import "AddressModel.h"
#import "AddressManagerViewController.h"
#import "BuyerOrderModel.h"
#import "SelectVipPriceListViewController.h"

static NSString * CellIdentifier = @"OrderTableViewCell";
static NSString * AddressCellIdentifier = @"BuyAndSendAddressTableViewCell";
static NSString * TouristsAddressCellIdentifier = @"BuyAndSendTouristsTableViewCell";
static NSString * ConstCellIdentifier = @"BuyAndSendCostTableViewCell";
static NSString * SizeCellIdentifier = @"BuyAndSendSizeTableViewCell";
static NSString * HeadIdentifier = @"OrderTableHeadView";
static NSString * FootIdentifier = @"DistributionFootView";


@interface ConfirmOrderViewController ()<UITableViewDelegate,UITableViewDataSource,BuyAndSendCostTableViewCellDelegate,DistributionFootViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *confirmtableView;

@property (weak, nonatomic) IBOutlet UIButton *SubmitordersButton;

@property (weak, nonatomic) IBOutlet UILabel *TheactualpaymentLabel;
/** 提交 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *submitButtonWidth;

@property (nonatomic, strong) AddressModel *adressmodel;

@property(strong,nonatomic) ConfirmOrderModel * model;
@property (weak, nonatomic) IBOutlet UILabel *taxLabel;
/**优惠券参数*/
@property (nonatomic, strong) NSMutableDictionary *mapJson;

/**发票抬头*/
@property (nonatomic, copy) NSString *invoice;
/**营业税号*/
@property (nonatomic, copy) NSString *taxPayerNum;
/**发票类型 0 个人 1 公司 2 不开*/
@property (nonatomic, copy) NSString *invoiceType;
@end




@implementation ConfirmOrderViewController
{
    ShoppingCostDetialsView * shoppingCostDetialsView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.invoiceType = @"2";
    [self.SubmitordersButton setTitle:LaguageControl(@"提交订单") forState:UIControlStateNormal];
    self.mapJson = [NSMutableDictionary dictionary];
    self.TheactualpaymentLabel.textColor = kNavigationColor;
    self.SubmitordersButton.backgroundColor = KAppRootNaVigationColor;
    CGSize submitSize = [NSString sizeWithString:LaguageControl(@"提交订单") font:KSystemFont(15) maxHeight:20 maxWeight:KScreenBoundWidth];
    self.submitButtonWidth.constant = MAX(submitSize.width+20, 70);
    self.title = [LaguageControl languageWithString:@"确认订单"];
    [self NetWork];
    self.confirmtableView.backgroundColor = kBGColor;
    [self updataHeader:self.confirmtableView];
}
-(void)updateHeadView
{
    if (self.model)
    {
        [self NetWorkReloadDataWithAddressID:@"" andCartID:@"" withType:NO];
    }
}
-(void)NetWork
{
    [HUDManager showLoadingHUDView:self.view];
    NSDictionary * dic = @{@"goods_id":self.goodsID,
                           @"store_id":self.StoreID,
                           @"user_id":[UserAccountManager shareUserAccountManager].loginStatus? kUserId:[UserAccountManager shareUserAccountManager].cartUserID,
                           @"addr_id":[UserAccountManager shareUserAccountManager].cartUserAddress,
                           @"count":self.count?self.count:@"",
                           @"invoiceAddr":@"",
                           @"gsp":self.gsp?self.gsp:@"",
                           @"goodscart_id":self.goodsCartID?self.goodsCartID:@"",
                           @"sku_id":self.gsp?self.gsp:@""
                           };
    [NetWork PostNetWorkWithUrl:@"/buyer/buy_now" with:dic successBlock:^(NSDictionary *dic)
     {
         [HUDManager hideHUDView];
         [self endRefresh];
         if ([dic[@"status"] boolValue])
         {
             self.model = [ConfirmOrderModel mj_objectWithKeyValues:dic[@"data"]];
             
             __block NSMutableArray *array = [NSMutableArray array];
             [self.model.dateInfo enumerateObjectsUsingBlock:^(StoreOrderModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                 if (!obj.goodsCarts.count)
                 {
                     [array addObject:obj];
                 }
             }];
             [self.model.dateInfo removeObjectsInArray:array];
             
             [self ReloadTableView];
         }
         else
         {
             [HUDManager showWarningWithText:dic[@"message"]];
             [UserAccountManager shareUserAccountManager].userModel.address = nil;
             [UserAccountManager shareUserAccountManager].cartUserAddress = nil;
             [self backToPresentViewController];
         }
         
     } errorBlock:^(NSString *error) {
         [HUDManager hideHUDView];
         [self backToPresentViewController];
     }];
}
-(void)ReloadTableView
{
    float tempshipprice = [[self getAllShipPrice] floatValue];
    float tempAllprice = [[self getALlPrice]floatValue];
    float tempManjianprice = [self.model.fullcutPrice?:@"0" floatValue];
    float tempyouhuiprice = [[self getViPALLPrice]floatValue];
    
    
    NSString * strings = [NSString stringWithFormat:@"￥ %.2f", tempAllprice +tempshipprice -tempManjianprice-tempyouhuiprice];
    if (self.model.dateInfo.count)
    {
        self.TheactualpaymentLabel.text = LaguageControlAppendStrings(@"合计",strings);
    }
    else
    {
        self.TheactualpaymentLabel.text = LaguageControlAppendStrings(@"实付款", strings);
    }
    [self.confirmtableView reloadData];
    
}
- (NSString *)finishPrice{
    float tempshipprice = [[self getAllShipPrice] floatValue];
    float tempAllprice = [[self getALlPrice]floatValue];
    float tempManjianprice = [self.model.fullcutPrice?:@"0" floatValue];
    float tempyouhuiprice = [[self getViPALLPrice]floatValue];
    
    
    NSString * strings = [NSString stringWithFormat:@"%.2f", tempAllprice +tempshipprice -tempManjianprice-tempyouhuiprice];
    return strings;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden =YES;
}
- (IBAction)confirmButtonClicked:(UIButton *)sender
{
    __weak ConfirmOrderViewController * weakself = self;
    
    [self Submitorders:^(BOOL success, NSString *order, NSString *price, BOOL isOffline) {
        if (success)
        {
            MywalletViewController * view = [[MywalletViewController alloc] init];
            if (self.FatherVC)
            {
                view.FatherVC = self.FatherVC;
            }
            view.isOffline = isOffline;
            view.orderPayMoney = price;
            view.orderNumber = order;
            weakself.tabBarController.tabBar.hidden =YES;
            [weakself.navigationController pushViewController:view animated:YES];
        }
    }];
}
/** 获取订单信息 */
-(NSDictionary*)GetInfoDic
{
    __block NSString * leavemessages;
    __block NSString * sendtype;
    __block NSString * sendTime;
    __block NSString * StoreID;
    __block NSString * goodsID;
    __block NSString * GoodsCartID;
    __block NSString * shipPrice;
    
    [self.model.dateInfo enumerateObjectsUsingBlock:^(StoreOrderModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop)
     {
         model.sendtype = model.sendtype?model.sendtype:@"1";
         leavemessages = leavemessages?[NSString stringWithFormat:@"%@,%@_%@",leavemessages,model.storeCartID,model.leaveMessage?model.leaveMessage:@""]:[NSString stringWithFormat:@"%@_%@",model.storeCartID,model.leaveMessage?model.leaveMessage:@""];
         model.sendtype = model.sendtype?model.sendtype:@"1";
         sendtype = sendtype?sendtype = [NSString stringWithFormat:@"%@,%@_%@",sendtype,model.storeCartID,model.sendtype]:[NSString stringWithFormat:@"%@_%@",model.storeCartID,model.sendtype];
         shipPrice = shipPrice?[NSString stringWithFormat:@"%@,%@/%@",shipPrice,model.storeCartID,model.sendtime.length?model.zoomPrice:model.storeShipPrice]:[NSString stringWithFormat:@"%@/%@",model.storeCartID,model.sendtime.length?model.zoomPrice:model.storeShipPrice];
         NSString * string = model.sendtime?model.sendtime:@"";
         if (!sendTime)
         {
             NSString * string = model.sendtime?model.sendtime:@"";
             if (string.length) {
                 NSMutableString * muStr = [NSMutableString stringWithString:string];
                 NSRange range = [muStr rangeOfString:@"("];
                 NSRange range1 = [muStr rangeOfString:@")"];
                 NSRange ranges = NSMakeRange(range.location , range1.location-range.location+range1.length);
                 [muStr replaceCharactersInRange:ranges withString:@"/"];
                 string = muStr;
             }
             sendTime = [NSString stringWithFormat:@"%@_%@",model.storeCartID,string];
         }
         else
         {
             sendTime = [NSString stringWithFormat:@"%@,%@_%@",sendTime,model.storeCartID,string];
         }
         StoreID = StoreID?[NSString stringWithFormat:@"%@,%@",StoreID,model.storeId]:model.storeId;
         for (GoodsOrderModel * themodel in model.goodsCarts)
         {
             goodsID=goodsID?[NSString stringWithFormat:@"%@,%@",goodsID,themodel.goodsid]:themodel.goodsid;
             GoodsCartID = GoodsCartID?[NSString stringWithFormat:@"%@,%@",GoodsCartID,themodel.goodsCartID]:themodel.goodsCartID;
         }
         
     }];
    NSDictionary * dic = @{@"leavemessages":leavemessages?leavemessages:@"",
                           @"sendtype":sendtype?sendtype:@"",
                           @"sendTime":sendTime?sendTime:@"",
                           @"StoreID":StoreID?StoreID:@"",
                           @"goodsID":goodsID?goodsID:@"",
                           @"GoodsCartID":GoodsCartID?GoodsCartID:@"",
                           @"shipPrice":shipPrice?shipPrice:@""};
    return dic;
}

/** 提交订单 */
-(void)Submitorders:(void(^)(BOOL success,NSString * order,NSString * price,BOOL isOffline))block
{
    NSString * usercat_id = [UserAccountManager shareUserAccountManager].loginStatus?kUserId:[UserAccountManager shareUserAccountManager].cartUserID;
    NSDictionary * infodic = [self GetInfoDic];
    NSString * storeId =  infodic[@"StoreID"];
    if (storeId.length<=0)
    {
        [HUDManager showWarningWithText:@""];
        return ;
    }
    if (self.model.addId.length<=0)
    {
        [HUDManager showWarningWithText:@"请选择收货地址"];
        return ;
    }
    if (![self.invoiceType isEqualToString:@"1"]) {
        self.invoice = self.taxPayerNum =@"";
    }
    NSDictionary * dic = @{
                           @"store_id":infodic[@"StoreID"],
                           @"invoiceAddr":self.model.addrInvoId,
                           @"addr_id":self.model.addId,
                           @"goods_id":infodic[@"goodsID"],
                           @"user_id":usercat_id,
                           @"goodsCartId":infodic[@"GoodsCartID"],
                           @"message":infodic[@"leavemessages"],
                           @"shipping":infodic[@"sendtype"],
                           @"shippingTime":infodic[@"sendTime"],
                           @"shipPrice":infodic[@"shipPrice"],
                           @"map2json":self.mapJson.mj_JSONString,
                           @"invoice":self.invoice,
                           @"taxPayerNum":self.taxPayerNum,
                           @"invoiceType":self.invoiceType
                           };
    [HUDManager showLoadingHUDView:self.view];
    [NetWork PostNetWorkWithUrl:@"/buyer/goods_cart3" with:dic successBlock:^(NSDictionary *dic)
     {
         [HUDManager hideHUDView];
         if ([dic[@"status"] boolValue])
         {
             NSString * orederNumber = [NSString stringWithFormat:@"%@",dic[@"data"][@"orderId"]];
             //            NSString * price = [NSString stringWithFormat:@"%@",dic[@"data"][@"totalPrice"]];
             NSString * price = [self finishPrice];
             
             //            NSString * stringprice = [NSString stringWithFormat:@"%.2f",[[self getAllShipPrice]floatValue] + [[self getALlPrice]floatValue]];
             block(YES,orederNumber,price,[dic[@"data"][@"lineType"] boolValue]);
         }
         else
         {
             [HUDManager showWarningWithText:dic[@"message"]];
         }
     } errorBlock:^(NSString *error)
     {
         [HUDManager hideHUDView];
     }];
}
/** 获取总价 */
-(NSString*)getALlPrice
{
    CGFloat m =0.00 ;
    for (StoreOrderModel * model in self.model.dateInfo)
    {
        if (model.sendtime.length)
        {
            m+=[model.zoomtotalPrice floatValue];
        }
        else
        {
            m += [model.totalPrice floatValue];
        }
    }
    return [NSString stringWithFormat:@"%.2f",m];
    
}
/** 获取总运费 */
-(NSString*)getAllShipPrice
{
    CGFloat m =0.00 ;
    for (StoreOrderModel * model in self.model.dateInfo)
    {
        if (model.sendtime.length)
        {
            m+=[model.zoomPrice floatValue];
        }
        else
        {
            m = [self.model.shipPrice floatValue];
        }
        
    }
    return [NSString stringWithFormat:@"%.2f",m];
}
/** 商品价格 */
-(NSString*)getGoodsPrice
{
    //    return [NSString stringWithFormat:@"%.2f",[[self getALlPrice] floatValue]-[[self getAllShipPrice] floatValue]];
    return [NSString stringWithFormat:@"%.2f",[[self getALlPrice] floatValue]];
}
#pragma mark--UITableViewDelegate && UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    if (section&&section<self.model.dateInfo.count+1)
    {
        StoreOrderModel * model = self.model.dateInfo[section-1];
        return model.goodsCarts.count;
    }
    else if (section)
    {
        return 1;
    }
    else
    {
        /**return 2  老版马来有发票地址*/
        return 1;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.model.dateInfo.count?self.model.dateInfo.count+2:0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    if (indexPath.section==0)
    {
        BuyAndSendAddressTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:AddressCellIdentifier];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:AddressCellIdentifier bundle:nil] forCellReuseIdentifier:AddressCellIdentifier];
            cell = [tableView dequeueReusableCellWithIdentifier:AddressCellIdentifier];
        }
        [cell configCellWithAdressModel:self.model];
        
        if (indexPath.row)
        {
            cell.addressnameLabel.text = self.model.addrInvoName;
            cell.addressPhoneNumber.text = self.model.addrInvoMobile;
            cell.addresDetailLabel.text = self.model.addInfoInvo;
            cell.postNumberLabel.text = self.model.addrInvoZip;
            cell.defaultLabel.hidden = YES;
            cell.addreslabel.text = LaguageControl(@"发票地址");
        }
        else
        {
            cell.addressnameLabel.text = self.model.addName;
            cell.addressPhoneNumber.text = self.model.addMobile;
            cell.addresDetailLabel.text = self.model.addInfo;
            cell.postNumberLabel.text = self.model.addZip;
            cell.addreslabel.text = LaguageControl(@"收货地址");
        }
        return cell;
    }
    else if (indexPath.section==self.model.dateInfo.count+1)
    {
        BuyAndSendCostTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ConstCellIdentifier];
        
        if (!cell)
        {
            [tableView registerNib:[UINib nibWithNibName:ConstCellIdentifier bundle:nil] forCellReuseIdentifier:ConstCellIdentifier];
            cell = [tableView dequeueReusableCellWithIdentifier:ConstCellIdentifier];
        }
        //        cell.contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        //        cell.contentView.layer.borderWidth = 1;
        if (self.model.pingtaiVipModel) {
            [cell.selvippricebtn setTitle:self.model.pingtaiVipModel.tempstr forState:UIControlStateNormal];
        }else{
            [cell.selvippricebtn setTitle:@"" forState:UIControlStateNormal];
            
        }
        cell.totalLabel.text = [@"¥" stringByAppendingString: [self getGoodsPrice]];
        cell.shipLabel.text = [@"¥" stringByAppendingString: [self getAllShipPrice]];
        //        cell.totalLabel.text = [self.model.totalPrice caculateFloatValue];
        //        cell.shipLabel.text = [self.model.shipPrice caculateFloatValue];
        
        if ([self.model.fullcutPrice?:@"0" isEqualToString:@"0"]) {
            cell.manJianMoneyLabel.text = [NSString stringWithFormat:@"¥%.2f",[self.model.fullcutPrice floatValue]];
            
        }else{
            cell.manJianMoneyLabel.text = [NSString stringWithFormat:@"-¥%.2f",[self.model.fullcutPrice floatValue]];
            
        }
        NSString *tempprc = [self getViPALLPrice];
        if ([tempprc floatValue] == 0) {
            cell.vipPriceMoneyLabel.text = [@"¥" stringByAppendingString:tempprc?:@"0"];;
            
        }else{
            cell.vipPriceMoneyLabel.text = [@"-¥" stringByAppendingString:tempprc?:@"0"];;
            
        }
        cell.delegate = self;
        WeakSelf(self)
        
        [cell.fapiaoHeadTF addTarget:self action:@selector(textfiledtexcChange:) forControlEvents:UIControlEventEditingChanged];
        [cell.fapiaoPersonTF addTarget:self action:@selector(textfiledtexcChange:) forControlEvents:UIControlEventEditingChanged];
        cell.fapiaoPersonTF.delegate = self;
        cell.fapiaoHeadTF.delegate = self;
        
        __strong typeof(cell) strongccell = cell;
        cell.selKaiFaPiaoBlock = ^(BOOL isSel) {
            if (!isSel) {
                weakSelf.invoiceType = @"2";
                strongccell.kaifapiaoLabel.text = @"";
                strongccell.companyBtn.selected = strongccell.personBtn.selected = NO;
                strongccell.companyBtn.layer.borderColor = strongccell.personBtn.layer.borderColor = kTextDeepDarkColor.CGColor;
            }
        };
        cell.selKaiFaPiaoTypeBlocy = ^(NSString *isCompany) {
            weakSelf.invoiceType = isCompany;
        };
        
        return cell;
    }
    else
    {
        StoreOrderModel * model = self.model.dateInfo[indexPath.section-1];
        GoodsOrderModel * models = model.goodsCarts[indexPath.row];
        OrderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell)
        {
            [tableView registerNib:[UINib nibWithNibName:CellIdentifier bundle:nil] forCellReuseIdentifier:CellIdentifier];
            cell  = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        }
        [cell loadCartData:models andindex:indexPath];
        return cell;
    }
}
- (void)textfiledtexcChange:(UITextField *)textFiled{
    if (textFiled.text.length > 20) {
        textFiled.text = [textFiled.text substringToIndex:20];
    }
    if (textFiled.tag == 101) {
        /**抬头*/
        self.invoice = textFiled.text;
    }else{
        /**纳税人号*/
        self.taxPayerNum = textFiled.text;
        
    }
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (![self.invoiceType isEqualToString:@"1"]) {
        [HUDManager showWarningWithText:@"请选择发票类型为单位!"];
        return  NO;
    }
    return YES;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    if (indexPath.section==0)
    {
        return 130;
    }
    else if (indexPath.section==self.model.dateInfo.count+1)
    {
        NSInteger tempheight;
        if (!kIsHaveCoupon) {
            tempheight = 90+44*4;
        }else{
            tempheight = 222+44*4;
        }
        return tempheight;
    }
    else{
        return 120;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (section==0||section==self.model.dateInfo.count+1)
    {
        return 15;
    }
    else
    {
        if (!kIsHaveCoupon) {
            return 44+15;
        }else{
            return 88+15;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0||section==self.model.dateInfo.count+1)
    {
        return 0.01;
    }
    else{
        return 40;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==0||section==self.model.dateInfo.count+1)
    {
        return nil;
    }
    else
    {
        StoreOrderModel * model = self.model.dateInfo[section-1];
        BuyerOrderModel * models = [BuyerOrderModel new];
        models.store_name = model.storeName;
        
        OrderTableHeadView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:HeadIdentifier];
        if (!view) {
            [tableView registerNib:[UINib nibWithNibName:HeadIdentifier bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:HeadIdentifier];
            view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeadIdentifier];
        }
        
        view.shopImageView.alpha = 0;
        [view LoadData:models with:OrderTypesAllTypes];
        /**店铺领取优惠券*/
        WeakSelf(self)
        if (!kIsHaveCoupon) {
            view.selVipPriceBtn.hidden = YES;
        }else{
            view.selVipPriceBtn.hidden = NO;
        }
        view.selVipPriceBtn.tag = section;
        view.selectVipPrictBlock = ^(NSInteger section) {
            SelectVipPriceListViewController *vc = [[SelectVipPriceListViewController alloc]init];
            vc.storeID = model.storeId;
            vc.isLingQu = YES;
            vc.useV = model.totalPrice;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        return view;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==0||section==self.model.dateInfo.count+1)
    {
        return nil;
    }
    else
    {
        StoreOrderModel * model = self.model.dateInfo[section-1];
        BOOL  isShow = YES;
        for (GoodsOrderModel * themodels in model.goodsCarts)
        {
            if ([themodels.goods_choice_type isEqualToString:@"1"])
            {
                isShow = NO;
            }
        }
        DistributionFootView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:FootIdentifier];
        if (!view) {
            [tableView registerNib:[UINib nibWithNibName:FootIdentifier bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:FootIdentifier];
            view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:FootIdentifier];
        }
        
        [view LoadDataWith:model andSection:section];
        if (isShow) {
            view.deliveryTypeLabel.alpha=1;
        }
        else{
            view.deliveryTypeLabel.alpha=0;
        }
        view.delegate = self;
        return view;
        
    }
}
/**
 *  点击选中事件
 *
 *  @param tableView <#tableView description#>
 *  @param indexPath <#indexPath description#>
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    StoreOrderModel * model = [self.model.dateInfo firstObject];
    GoodsOrderModel * models = [model.goodsCarts firstObject];
    if (indexPath.section==0)
    {
        BOOL isAddress = YES;
        if (indexPath.row)
        {
            isAddress = NO;
        }
        if ([UserAccountManager shareUserAccountManager].loginStatus) {
            __weak ConfirmOrderViewController * weakself = self;
            AddressManagerViewController * view = [AddressManagerViewController new];
            view.isSelect = YES;
            view.block = ^(AddressModel *addressModel){
                [weakself NetWorkReloadDataWithAddressID:addressModel.adressId andCartID:models.goodsCartID withType:isAddress];
            };
            view.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:view animated:YES];
        }
        else
        {
            __weak ConfirmOrderViewController * weakself = self;
            EditAddressNewViewController * edit = [[EditAddressNewViewController alloc] init];
            [edit GetBlocksWIth:^(AddressModel *adressModel)
             {
                 [weakself NetWorkReloadDataWithAddressID:adressModel.adressId andCartID:models.goodsCartID withType:isAddress];
             }];
            edit.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:edit animated:YES];
        }
    }
    else if (indexPath.section!=self.model.dateInfo.count+1)
    {
        StoreOrderModel * model = self.model.dateInfo[indexPath.section-1];
        GoodsOrderModel * models = model.goodsCarts[indexPath.row];
        GoodsDetialViewController *detialVC = [[GoodsDetialViewController alloc] init];
        detialVC.goodsModelID = models.goodsid;
        self.tabBarController.tabBar.hidden =YES;
        [self.navigationController pushViewController:detialVC animated:YES];
    }
}


-(void)NetWorkReloadDataWithAddressID:(NSString*)addressID andCartID:(NSString*)goodsCartID
                             withType:(BOOL)isSendAddress;
{
    if (self.isBuyNow)
    {
        self.goodsCartID = goodsCartID;
        self.count = @"";
    }
    NSString * theaddress = self.model.addId;
    NSString * sendAddresID = self.model.addrInvoId;
    if (isSendAddress)
    {
        if (addressID.length) {
            theaddress = addressID;
        }
    }
    else
    {
        if (addressID.length)
        {
            sendAddresID = addressID;
        }
    }
    NSDictionary * infodic = [self GetInfoDic];
    
    NSDictionary * dic = @{@"goods_id":self.goodsID,
                           @"store_id":self.StoreID,
                           @"user_id":[UserAccountManager shareUserAccountManager].loginStatus?kUserId:@"",
                           @"addr_id":theaddress,
                           @"invoiceAddr":sendAddresID,
                           @"count":self.count?self.count:@"",
                           @"gsp":self.gsp?self.gsp:@"",
                           @"goodscart_id":infodic[@"GoodsCartID"],
                           @"cart_session_id":[UserAccountManager shareUserAccountManager].loginStatus?@"":[UserAccountManager shareUserAccountManager].cartUserID,
                           };
    [HUDManager showLoadingHUDView:self.view];
    [NetWork PostNetWorkWithUrl:@"/buyer/buy_now" with:dic successBlock:^(NSDictionary *dic)
     {
         [HUDManager hideHUDView];
         self.model = [ConfirmOrderModel mj_objectWithKeyValues:dic[@"data"]];
         
         __block NSMutableArray *array = [NSMutableArray array];
         [self.model.dateInfo enumerateObjectsUsingBlock:^(StoreOrderModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
             if (!obj.goodsCarts.count)
             {
                 [array addObject:obj];
             }
         }];
         [self.model.dateInfo removeObjectsInArray:array];
         [self.confirmtableView.mj_header endRefreshing];
         [self ReloadTableView];
     } errorBlock:^(NSString *error) {
         [self.confirmtableView.mj_header endRefreshing];
         [HUDManager hideHUDView];
     }];
    
}

#pragma mark -- DistributionFootViewDelegate
-(void)DistributionFootViewDidSelectedWithSection:(NSInteger)section andDistrbutionView:(DistributionFootView*)view
{
    StoreOrderModel * model = self.model.dateInfo[section-1];
    
    if (model.isShow)
    {
        DistributionTypeSelectVCViewController * views = [[DistributionTypeSelectVCViewController alloc] init];
        __weak ConfirmOrderViewController *weakself = self;
        views.selectedType =model.sendtype;
        views.array = model.etList;
        [views GetSendType:^(NSDictionary *dictionary, BOOL Fast)
         {
             model.sendtime = dictionary[@"content"];
             model.sendtype = dictionary[@"name"];
             [weakself ReloadTableView];
         }];
        self.tabBarController.tabBar.hidden =YES;
        [self.navigationController pushViewController:views animated:YES];
        
    }
    
}
-(void)TextFieldEndinputSelectedWithSection:(NSInteger)section andTextField:(UITextField *)textfield
{
    StoreOrderModel * model = self.model.dateInfo[section-1];
    model.leaveMessage = textfield.text;
    
}
/**店铺优惠券点击事件*/
-(void)DistributionFootViewDidSelectedWithSection:(NSInteger)section andDistrbutionView:(DistributionFootView *)view selbtn:(UIButton *)btn{
    StoreOrderModel * model = self.model.dateInfo[section-1];
    SelectVipPriceListViewController *vc = [[SelectVipPriceListViewController alloc]init];
    vc.storeID = model.storeId;
    vc.isLingQu = NO;
    vc.useV = model.totalPrice;
    WeakSelf(self)
    vc.selectVipPriceBlock = ^(VipPriceShopModel *m) {
        __block BOOL isselllll= NO;
        [weakSelf.model.dateInfo enumerateObjectsUsingBlock:^(StoreOrderModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.storeId isEqualToString: model.storeId]) {
                if (obj.vipshopmodel && [obj.vipshopmodel.modelId isEqualToString:m.modelId]) {
                    isselllll = YES;
                }
            }
            
        }];
        if (isselllll) {
            [HUDManager showWarningWithText:@"已经选择这种优惠券"];
            return ;
        }
        [weakSelf.mapJson setObject:m.modelId?:@"" forKey:model.storeCartID];
        [btn setTitle:m.tempstr?:@"" forState:UIControlStateNormal];
        model.vipshopmodel = m;
        [weakSelf getvippricerole:m isPingTai:NO];
        [weakSelf ReloadTableView];
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark -- BuyAndSendCostTableViewCellDelegate
/**平台通用优惠券点击事件*/
-(void)buyAndSendCostTableViewCell:(BuyAndSendCostTableViewCell *)cell btn:(UIButton *)btn{
    SelectVipPriceListViewController *vc = [[SelectVipPriceListViewController alloc]init];
    vc.storeID = @"";
    vc.isLingQu = NO;
    vc.useV = [self getViPALLShopPrice];
    WeakSelf(self)
    vc.selectVipPriceBlock = ^(VipPriceShopModel *m) {
        [weakSelf.mapJson setObject:m.modelId?:@"" forKey:@"tongyong"];
        [btn setTitle:m.tempstr?:@"" forState:UIControlStateNormal];
        weakSelf.model.pingtaiVipModel = m;
        [weakSelf ReloadTableView];
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)BuyAndSendCostTableShowCostButtonClicked:(TaxTypes)type
{
    ShippingDetailVCViewController * view = [[ShippingDetailVCViewController alloc] init];
    view.model = self.model;
    view.hidesBottomBarWhenPushed =YES;
    [self presentViewController:view animated:YES completion:^{
    }];
}

/** 获取优惠总价 */
-(NSString*)getViPALLPrice
{
    CGFloat m =0.00 ;
    for (StoreOrderModel * model in self.model.dateInfo)
    {
        if (model.sendtime.length)
        {
            m+=[model.vipshopmodel.coupon_amount floatValue];
        }
        else
        {
            m += [model.vipshopmodel.coupon_amount floatValue];
        }
    }
    if (self.model.pingtaiVipModel) {
        m = [self.model.pingtaiVipModel.coupon_amount floatValue]+m;
    }else{
        
    }
    if (m<=0) {
        m = 0;
    }
    return [NSString stringWithFormat:@"%.2f",m];
    
}
/** 获取优惠总价店铺的 */
-(NSString*)getViPALLShopPrice
{
    float totale = [[self getGoodsPrice]floatValue];
    CGFloat m =0.00 ;
    for (StoreOrderModel * model in self.model.dateInfo)
    {
        if (model.sendtime.length)
        {
            m+=[model.vipshopmodel.coupon_amount floatValue];
        }
        else
        {
            m += [model.vipshopmodel.coupon_amount floatValue];
        }
    }
    m = totale -m;
    return [NSString stringWithFormat:@"%.2f",m];
    
}

- (void)getvippricerole:(VipPriceShopModel *)m isPingTai:(BOOL)isPingtai{
    
    if (isPingtai) {
        /**平台*/
    }else{
        /**店铺*/
        if (self.model.pingtaiVipModel) {
            /**已选择平台优惠券*/
            if ([[self getALlPrice]floatValue]-[m.coupon_amount floatValue]< [self.model.pingtaiVipModel.coupon_order_amountss floatValue]) {
                /**优惠券不能用*/
                self.model.pingtaiVipModel = nil;
            }else{
                
            }
        }
        
    }
    
}
@end
