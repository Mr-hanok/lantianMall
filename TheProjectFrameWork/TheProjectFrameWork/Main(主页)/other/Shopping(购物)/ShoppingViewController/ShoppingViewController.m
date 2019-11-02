//
//  ShoppingViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/6/3.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ShoppingViewController.h"
#import "ShoppingCartTableViewCell.h"
#import "ShoppingHeadView.h"
#import "ConfirmOrderViewController.h"
#import "LoginViewController.h"
#import "CartShopModel.h"
#import "CartGoodsModel.h"
#import "PayAttentionShopViewController.h"
#import "PayAttentNetWork.h"
#import "GoodsDetialViewController.h"
#import "EditAddressNewViewController.h"
#import "AddressManagerViewController.h"
#import "MessageCenterViewController.h"
#import "ShoppingNotView.h"
#import "AboutUsVCViewController.h"
static NSString * HeadIdentifier = @"ShoppingHeadView";
static NSString * cellIdentifier = @"ShoppingCartTableViewCell";
@interface ShoppingViewController ()<UITableViewDelegate,UITableViewDataSource,ShoppingCartTableViewCellDelegate,ShoppingHeadViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *gstLabel;
@property (weak, nonatomic) IBOutlet UILabel *costLabel;
@property (weak, nonatomic) IBOutlet UILabel *rmLabel;
/** 弹出视图 */
@property (weak, nonatomic) IBOutlet UIView *popCostView;
/** 购物车列表 */
@property(strong,nonatomic) UITableView *shoppingCartTableView;
/** 数据列表 */
@property(strong,nonatomic) NSMutableArray * dataArray;
/** 选择所有 */
@property (weak, nonatomic) IBOutlet UIButton *selectedAllButtn;
/** 合计价格 */
@property (weak, nonatomic) IBOutlet UILabel *totalPricesLabel;
/** <#注释#> */
@property (weak, nonatomic) IBOutlet UIView *shoppingView;
/** 支付按钮 */
@property (weak, nonatomic) IBOutlet UIButton *payForButton;
/** 选择分区 */
@property(strong,nonatomic) NSMutableArray * seletectArray;
/** 商品选中集合 */
@property(strong,nonatomic) NSMutableSet * seletectGoodsArray;

@property(strong,nonatomic) NSMutableArray * testArray;

/** 弹出视图 */
@property (weak, nonatomic) IBOutlet UIButton *popViewButton;
/** 高度 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shoppingViewheight;

@end

@implementation ShoppingViewController
{
    BOOL showPopView;
    BOOL selecteAll;
    BOOL isNotWork;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    if (!self.shoppingCartTableView)
    {
        self.shoppingCartTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 104, KScreenBoundWidth, self.view.frame.size.height-200) style:UITableViewStyleGrouped];
        self.shoppingCartTableView.separatorStyle= UITableViewCellSeparatorStyleNone;
        self.shoppingCartTableView.delegate = self;
        self.shoppingCartTableView.dataSource = self;
        self.shoppingCartTableView.sectionFooterHeight = 1;
        [self.view addSubview:self.shoppingCartTableView];
        [self.view sendSubviewToBack:self.shoppingCartTableView];
        [self.shoppingCartTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.view.mas_top);
            make.bottom.equalTo(self.shoppingView.mas_top);
        }];
    }
    self.totalPricesLabel.textColor = kNavigationColor;
    self.popCostView.alpha = 0;
    self.dataArray  = [NSMutableArray array];
    self.seletectGoodsArray = [NSMutableSet set];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.selectedAllButtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    UIBarButtonItem * delete = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"ic_delete_shopcar"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(delegateButton)];
    UIBarButtonItem * message = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"xinxi"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(messageButton)];
    self.navigationItem.rightBarButtonItems = @[message,delete];
    if (KScreenBoundWidth>320) {
    }
    else
    {
        self.totalPricesLabel.font = KSystemFont(13);
        self.gstLabel.font = KSystemFont(11);
    }
    self.seletectArray = [NSMutableArray array];
    self.view.backgroundColor = self.shoppingCartTableView.backgroundColor =kBGColor;
    [self.payForButton setBackgroundColor:kNavigationColor];
        // Do any additional setup after loading the view.
}
-(void)updateHeadView
{
    if ([UserAccountManager shareUserAccountManager].loginStatus||[UserAccountManager shareUserAccountManager].cartUserID)
    {
        [self NetWork];
    }
}
/** 删除按钮点击 */
-(void)delegateButton
{
    
    if (!self.seletectGoodsArray.count)
    {
        [HUDManager showWarningWithText:@"请选择商品"];
        return;
    }
    __block  NSString * deletes;
    [self.seletectGoodsArray enumerateObjectsUsingBlock:^(CartGoodsModel * obj, BOOL * _Nonnull stop) {
        if (!deletes) {
            deletes = obj.goodsCartId;
        }
        else
        {
            deletes = [NSString stringWithFormat:@"%@,%@",deletes,obj.goodsCartId];
        }
    }];
    //TODO: 上部分
    if (!deletes) {
        deletes = @"";
    }
    [self deleteGoodWithCartwithshopmodel:deletes withBlock:^(BOOL success) {
        if (success) {
            [self NetWork];
        }
    }];
}
/** 消息 */
-(void)messageButton
{
    MessageCenterViewController * view = [[MessageCenterViewController alloc] init];
    self.tabBarController.tabBar.hidden = YES;
    view.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:view animated:YES];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    if (!kIsChiHuoApp) {
        UITabBarController * tabController = (UITabBarController*)kRootViewController;
        [tabController.tabBar hideBadgeOnItemIndex:2];
    }
    [super viewWillAppear:animated];
    if ([UserAccountManager shareUserAccountManager].loginStatus||[UserAccountManager shareUserAccountManager].cartUserID)
    {
        [self NetWork];
    }

}
/** 网络请求 */
-(void)NetWork
{
    [self updataHeader:self.shoppingCartTableView];
    NSDictionary * dic;
    if ([UserAccountManager shareUserAccountManager].loginStatus)
    {
        dic =@{@"user_id":kUserId,
               @"cart_type":@"1"};
    }
    else{
        dic =@{@"cart_session_id":[UserAccountManager shareUserAccountManager].cartUserID,
                @"cart_type":@"2"};
    }
    [NetWork PostNetWorkWithUrl:@"/goods/cart_list" with:dic successBlock:^(NSDictionary *dic)
    {
        [self endRefresh];
        
        [HUDManager hideHUDView];
        [self.dataArray removeAllObjects];
        [self.seletectArray removeAllObjects];
        [self.seletectGoodsArray removeAllObjects];
        if ([dic[@"status"] boolValue])
        {
            self.dataArray = [CartShopModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
            NSMutableArray * array = [NSMutableArray array];
            for (CartShopModel * models in self.dataArray) {
                if (models.goodsCarts.count==0)
                {
                    [array addObject:models];
                }
            }
            [self.dataArray removeObjectsInArray:array];
            isNotWork = NO;
        }
        [self RemoveAllSellectet];
        if (!kIsChiHuoApp) {
            [UserAccountManager shareUserAccountManager].cartnumber =self.seletectGoodsArray.count>99?@"99+":[NSString stringWithFormat:@"%ld",(unsigned long)self.seletectGoodsArray.count];
        }
        [self loadDatasource];
    } errorBlock:^(NSString *error)
    {
        [self endRefresh];
        isNotWork = YES;
        [HUDManager hideHUDView];
    }];
}
/** 刷新 */
-(void)BaseLoadView
{
    if (self.NotShowTabar) {
        [self loadNavBarButton];
        [self loadLeftnavigabarTouchEvent];
        self.tabBarController.tabBar.hidden = YES;
        if (kIsChiHuoApp) {
           self.shoppingCartTableView.frame = CGRectMake(0, 50, KScreenBoundWidth, self.view.frame.size.height-100-kNavigaTionBarHeight);
        }else{
           self.shoppingCartTableView.frame = CGRectMake(0, 104, KScreenBoundWidth, self.view.frame.size.height-200+KTabBarHeight);
        }
        

    }
    else
    {
        self.tabBarController.tabBar.hidden = NO;
    }
    self.view.backgroundColor = [UIColor whiteColor];
    [self.payForButton setTitle:LaguageControl(@"结算") forState:UIControlStateNormal];
    [self loadDatasource];

}
/** 获取全选价格 */
-(NSString *)selecteAllPrices{
    CGFloat price = 0;
    CGFloat theprice = 0;
    for (CartGoodsModel * model in self.seletectGoodsArray)
    {
        if ([model.goods_status isEqualToString:@"0"]&&[model.goods_inventory integerValue]>=1)
        {
            price +=[model.price floatValue] * [model.count integerValue];
            theprice +=[model.tax_rate floatValue] * [model.count integerValue];
        }
        else
        {
            
        }

    }
    if (price) {
        return [NSString stringWithFormat:@"%.2f",price];
    }
    return [NSString stringWithFormat:@"0.00"];;
}
/** 获取全选税费 */
-(NSString *)selectTaxAllPrices{
    CGFloat theprice = 0;
    for (CartGoodsModel * model in self.seletectGoodsArray) {
        theprice +=[model.tax_rate floatValue] * [model.count integerValue];
    }
    if (theprice) {
        return [NSString stringWithFormat:@"%.2f",theprice];
    }
    return [NSString stringWithFormat:@""];;
}
/**
 *  计算合计
 */
-(void)loadAllGoodPrices
{
    NSString * strin = [NSString stringWithFormat:@"%@%@",LaguageControl(@"￥"),[self selecteAllPrices]];
    self.totalPricesLabel.text =LaguageControlAppendStrings(@"合计",strin );
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:self.totalPricesLabel.text];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(0,3)];
    self.totalPricesLabel.attributedText = text;

    self.costLabel.text =[NSString stringWithFormat:@"%@：%@",[LaguageControl languageWithString:@"￥"],[self selecteAllPrices]];
}
/** 加载数据源刷新 */
-(void)loadDatasource
{
    self.title = [LaguageControl languageWithString:@"购物车"];
    if (!self.seletectArray) {
        self.seletectArray = [NSMutableArray array];
    }
    if (self.dataArray.count) {
        self.shoppingView.alpha = 1;
        self.shoppingViewheight.constant = 50;
    }
    else{
        self.shoppingViewheight.constant = 0;
        self.shoppingView.alpha = 0;
    }
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    if (self.seletectArray.count == self.dataArray.count) {
        selecteAll = YES;
        self.selectedAllButtn.selected = YES;

    }
    else
    {
        selecteAll = NO;
        self.selectedAllButtn.selected = NO;
    }
    [self.payForButton setTitle:[NSString stringWithFormat:@"%@(%ld)",[LaguageControl languageWithString:@"结算"],[self CalulateCount]] forState:UIControlStateNormal];
    self.payForButton.backgroundColor = KAppRootNaVigationColor ;

    [self loadAllGoodPrices];
    [self.shoppingCartTableView reloadData];
}
/** 计算选择数目 */
-(NSInteger)CalulateCount
{
    NSInteger m = 0;
    for (CartGoodsModel * modes in self.seletectGoodsArray)
    {
        if ([modes.goods_status isEqualToString:@"0"]&&[modes.goods_inventory integerValue]>=1)
        {
            m++;
        }
    }
    return m;
}

#pragma mark --UITableViewDelegate && UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.dataArray.count==0)
    {
        self.backview = [ShoppingNotView loadView];
        [self.backview LoadNetWorkError:isNotWork];
        self.shoppingCartTableView.backgroundView = self.backview;
    }
    else
    {
        self.shoppingCartTableView.backgroundView = [UIView new];
    }
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CartShopModel * model = self.dataArray[section];
    return model.goodsCarts.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CartShopModel * model = self.dataArray[indexPath.section];
    CartGoodsModel * modes = model.goodsCarts[indexPath.row];
    BOOL selected = NO;
    if ([self.seletectGoodsArray containsObject:modes]) {
        selected = YES;
    }
    if (selecteAll)
    {
        selected = YES;
    }
    ShoppingCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:nil options:nil] firstObject];
    }
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell goodsLoadShoppingCartWithModel:modes andIndexPath:indexPath ISselect:selected];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CartShopModel * model = self.dataArray[section];
    ShoppingHeadView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:HeadIdentifier];
        if (!view) {
            [tableView registerNib:[UINib nibWithNibName:HeadIdentifier bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:HeadIdentifier];
            view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeadIdentifier];
        }
        if ([self.seletectArray containsObject:model])
        {
            view.selectedButton.selected = YES;
        }
        else{
            view.selectedButton.selected = NO;
        }
    if (selecteAll) {
        view.selectedButton.selected = YES;
    }
        [view loadDataWith:model andsection:section];
        view.delegate = self;
        view.contentView.backgroundColor = [UIColor clearColor];
        return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
#pragma tableViewDidselected

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CartShopModel * model = self.dataArray[indexPath.section];
    CartGoodsModel * modes = model.goodsCarts[indexPath.row];
    self.tabBarController.tabBar.hidden = YES;
    GoodsDetialViewController * view = [GoodsDetialViewController new];
    view.goodsModelID = modes.goodsId;
    view.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:view animated:YES];

}
/** 删除选中 */
-(void)deleteGoodWithCartwithshopmodel:(NSString*)goodid withBlock:(void(^)(BOOL success))block;
{
    NSDictionary * dic =@{@"id":goodid,};
    [HUDManager showLoadingHUDView:self.view];
    [NetWork PostNetWorkWithUrl:@"/goods/remove_goods_cart" with:dic successBlock:^(NSDictionary *dic)
    {
        [HUDManager hideHUDView];
        if ([dic[@"status"] boolValue])
        {
            block(YES);
        }
        else{
            [HUDManager showWarningWithText:dic[@"message"]];
            block(NO);
            
        }
    } errorBlock:^(NSString *error)
     {
        [HUDManager hideHUDView];
    }];
}
#pragma mark --ShoppingCartTableViewCellDelegate
-(void)goodsNumberChangeedWith:(NSString*)goodsmodel withIndexPath:(NSIndexPath*)indexPath
{
    CartShopModel * model = self.dataArray[indexPath.section];
    CartGoodsModel * modes = model.goodsCarts[indexPath.row];
    __weak ShoppingViewController *weakself = self;
    if (goodsmodel&&[goodsmodel integerValue]>0)
    {
        [HUDManager showLoadingHUDView:self.view];
        NSDictionary *dic = @{@"goods_cart_id":modes.goodsCartId,
                              @"abs":goodsmodel,
                              @"user_id":kUserId
                              };
        [NetWork PostNetWorkWithUrl:@"/goods/update_cart_goods" with:dic successBlock:^(NSDictionary *dic)
        {
            [HUDManager hideHUDView];
            if ([dic[@"status"] boolValue])
            {
                modes.count = [NSString stringWithFormat:@"%@",dic[@"data"][@"count"]];
                [weakself.shoppingCartTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                [weakself loadAllGoodPrices];
            }
        } errorBlock:^(NSString *error) {
        }];
    }    

}
-(void)goodsButtonSelected:(UIButton *)button withIndexPath:(NSIndexPath *)indexPath
{
    
    CartShopModel * model = self.dataArray[indexPath.section];
    CartGoodsModel * modes = model.goodsCarts[indexPath.row];
    if ([self.seletectGoodsArray containsObject:modes])
    {
        [self.seletectGoodsArray removeObject:modes];
        if ([self.seletectArray containsObject:model])
        {
            [self.seletectArray removeObject:model];
        }
        if (selecteAll)
        {
            selecteAll = NO;
            self.selectedAllButtn.selected = selecteAll;
        }
    }
    else
    {
        [self.seletectGoodsArray addObject:modes];
        //判断是否存在
        if ([self containsObjects:model.goodsCarts])
        {
            [self.seletectArray addObject:model];
            if (self.seletectArray.count==self.dataArray.count)
            {
                    selecteAll = YES;
                    self.selectedAllButtn.selected = selecteAll;
            }
        }
        
    }
    [self loadDatasource];
}


-(BOOL)containsObjects:(NSMutableArray*)array
{
    for (CartGoodsModel * modes in array) {
        if (![self.seletectGoodsArray containsObject:modes])
        {
            return NO;
        }
    }
    return YES;
}
/**
 *  弹出视图
 *
 *  @param sender
 */

- (IBAction)popDetialView:(UIButton *)sender
{
    
    showPopView = !showPopView;
    sender.selected = showPopView;
    if (showPopView) {
        self.popCostView.alpha = 1;
        [UIView animateWithDuration:0.5 animations:^{
            self.popCostView.center = CGPointMake(self.popCostView.center.x, self.popCostView.center.y-90);
        } completion:^(BOOL finished) {

        }];
     }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            self.popCostView.center = CGPointMake(self.popCostView.center.x, self.popCostView.center.y+90);
        } completion:^(BOOL finished) {
        }];
        
    }
}
/** 选中 */
- (IBAction)selectedAllGoods:(UIButton *)sender
{
    if (self.seletectArray.count==self.dataArray.count)
    {
        [self.seletectArray removeAllObjects];
        [self.seletectGoodsArray removeAllObjects];
       selecteAll = NO;
    }
    else
    {
        [self selectAllGoods];
    }
    sender.selected = selecteAll;
    [self loadDatasource];
}
/** 选中所有 */
-(void)selectAllGoods
{
    [self.seletectArray removeAllObjects];
    [self.seletectGoodsArray removeAllObjects];
    [self.dataArray enumerateObjectsUsingBlock:^(CartShopModel * model, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.seletectArray addObject:model];
        [self.seletectGoodsArray addObjectsFromArray:model.goodsCarts];
    }];
    selecteAll = YES;
}
/** 移除所以选中 */
-(void)RemoveAllSellectet
{
    [self.seletectArray removeAllObjects];
    [self.seletectGoodsArray removeAllObjects];
    selecteAll = NO;
}
-(NSString*)GetGoodsID
{
    __block NSString * goodsID;
    [self.seletectGoodsArray enumerateObjectsUsingBlock:^(CartGoodsModel * model, BOOL * _Nonnull stop)
    {
        if ([model.goods_status isEqualToString:@"0"]&&[model.goods_inventory integerValue]>=1)
        {
            if (!goodsID)
            {
                goodsID = model.goodsId;
            }
            else
            {
                goodsID = [NSString stringWithFormat:@"%@,%@",goodsID,model.goodsId];
            }
        }
    }];
    return goodsID?goodsID:@"";
}

/** 获取店铺ID */
-(NSString*)GetStoreID
{
   __block NSString * storeID;
    [self.seletectArray enumerateObjectsUsingBlock:^(CartShopModel * model, NSUInteger idx, BOOL * _Nonnull stop)
     {
         BOOL isUnderline = NO;
         for (CartGoodsModel * themodel in model.goodsCarts)
         {
             if ([themodel.goods_status isEqualToString:@"0"]&&[themodel.goods_inventory integerValue]>=1)
             {
                 isUnderline = YES;
             }
         }
         if (isUnderline)
         {
             if (!storeID)
             {
                 storeID =model.storeId;
             }
             else{
                 storeID = [NSString stringWithFormat:@"%@,%@",storeID,model.storeId];
             }
         }
       
    }];
    return storeID?storeID:@"";
   
}
/** 获取商品购物车ID */
-(NSString*)GetGoodCartID
{
    __block NSString * goodsID;
    [self.seletectGoodsArray enumerateObjectsUsingBlock:^(CartGoodsModel * model, BOOL * _Nonnull stop)
     {
         if ([model.goods_status isEqualToString:@"0"]&&[model.goods_inventory integerValue]>=1)
         {
             if (!goodsID)
             {
                 goodsID = model.goodsCartId;
             }
             else
             {
                 goodsID = [NSString stringWithFormat:@"%@,%@",goodsID,model.goodsCartId];
             }
         }
    }];
    return goodsID?goodsID:@"";
}
/** 点击结算 */
- (IBAction)payForButtonClicked:(UIButton *)sender
{
    
    if ([self CalulateCount])
    {
        if ([UserAccountManager shareUserAccountManager].loginStatus||[UserAccountManager shareUserAccountManager].isLogin)
        {
            [self PushToConfirmViewController];
        }
        else{
            UIStoryboard * loginStoryBoard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
            UINavigationController *nav = loginStoryBoard.instantiateInitialViewController;
            LoginViewController * view = (LoginViewController*)nav.topViewController;
            view.isPrompt = YES;
            __weak ShoppingViewController *weakself = self;
            [view getisToturBuy:^(BOOL isBuy) {
                if (isBuy)
                {
                    [weakself PushToConfirmViewController];
                }
            }];
            [self presentViewController:nav animated:YES completion:^{
            }];
        }   

    }
    else
    {
        [HUDManager showWarningWithText:@"请选择商品"];
    }
    
   }
-(void)PushToConfirmViewController
{
    NSString *tempcaraddres = [UserAccountManager shareUserAccountManager].cartUserAddress;
    NSString *tempdefaultaddress = [UserAccountManager shareUserAccountManager].userModel.defaultAdddress;
    if (tempdefaultaddress) {
        [UserAccountManager shareUserAccountManager].cartUserAddress = tempdefaultaddress;
    }
    if ((tempcaraddres && ![tempcaraddres isEqualToString:@""]) ||(tempdefaultaddress && ![tempdefaultaddress isEqualToString:@""]) )
    {
        if ([self CalulateCount])
        {
            ConfirmOrderViewController * view = [[ConfirmOrderViewController alloc] init];
            view.goodsCartID = [self GetGoodCartID];
            view.goodsID = [self GetGoodsID];
            view.StoreID = [self GetStoreID];
            view.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:view animated:YES];
        }
        else
        {
            [HUDManager showWarningWithText:@"请选择商品"];
        }

    }
    else
    {
        [self EditAddressViewController];
    }
}
/** 获取地址 */
-(void)EditAddressViewController
{
    if ([UserAccountManager shareUserAccountManager].loginStatus)
    {
        NSString *tempcaraddres = [UserAccountManager shareUserAccountManager].cartUserAddress;
        NSString *tempdefaultaddress = [UserAccountManager shareUserAccountManager].userModel.defaultAdddress;
        if (tempdefaultaddress) {
            [UserAccountManager shareUserAccountManager].cartUserAddress = tempdefaultaddress;
        }
        if ((tempcaraddres && ![tempcaraddres isEqualToString:@""]) ||(tempdefaultaddress && ![tempdefaultaddress isEqualToString:@""]) )
        {
            [self PushToConfirmViewController];
        }else{
            __weak ShoppingViewController * weakself = self;
            AddressManagerViewController * view = [AddressManagerViewController new];
            view.isSelect = YES;
            view.block = ^(AddressModel *addressModel){
                [UserAccountManager shareUserAccountManager].cartUserAddress =addressModel.adressId;
                [weakself PushToConfirmViewController];
            };
            self.tabBarController.tabBar.hidden = YES;
            view.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:view animated:YES];
            
        }
    }
    else
    {
        __weak ShoppingViewController * weakself = self;
        EditAddressNewViewController * address = [EditAddressNewViewController new];
        [address GetBlocksWIth:^(AddressModel *adressModel)
         {
             [weakself PushToConfirmViewController];
         }];
        self.tabBarController.tabBar.hidden = YES;
        address.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:address animated:YES];
    }
}
#pragma mark--ShoppingHeadViewDelegate
/** <#注释#> */
-(void)ShoppingHeadViewDidSelected:(NSInteger)section with:(UIButton*)button
{
    CartShopModel * model = self.dataArray[section];

    if ([self.seletectArray containsObject:model])
    {
        [self.seletectArray removeObject:model];
        for (CartGoodsModel * themodel  in model.goodsCarts)
        {
            [self.seletectGoodsArray removeObject:themodel];
        }
        if (selecteAll) {
            selecteAll = NO;
            self.selectedAllButtn.selected = selecteAll;
        }
    }
    else
    {
        [self.seletectArray addObject:model];
        [self.seletectGoodsArray addObjectsFromArray:model.goodsCarts];
        if (self.seletectArray.count ==self.dataArray.count) {
            selecteAll = YES;
            self.selectedAllButtn.selected = selecteAll;
        }
    }
    [self loadDatasource];
}
/** 店铺详情 */
-(void)ShoppingHeadViewLookDetialSelected:(NSInteger)section
{
    CartShopModel * model = self.dataArray[section];
    PayAttentionShopViewController * view = [PayAttentionShopViewController new];
    view.storeID = model.storeId;
    self.tabBarController.tabBar.hidden = YES;
    view.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:view animated:YES];
    
}


@end
