//
//  GoodsDetialViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/6/8.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//


#import "GoodsDetialViewController.h"
#import "ButtonView.h"
#import "GoodsDetialScrollerView.h"
#import "GoodsEvaluationView.h"
#import "GoodsView.h"
#import "GoodsDetialNavigationTitleView.h"
#import "BuyAndSendDetialViewController.h"
#import "PayAttentionShopViewController.h"
#import "PayAttentionGoodsViewController.h"
#import "ConfirmOrderViewController.h"
#import "StationMessageChatViewController.h"
#import "LoginViewController.h"
#import "GoodsDetialModel.h"
#import "ClassGoodsModel.h"
#import "GoodsParameterModel.h"
#import "ParameterDetialModel.h"
#import "PayAttentNetWork.h"
#import "AddCartNetWork.h"
#import "ShareView.h"
#import "EditAddressNewViewController.h"
#import "AddressManagerViewController.h"
#import "AppAsiaShare.h"
#import "PayHandle.h"


@interface GoodsDetialViewController ()<UIScrollViewDelegate,GoodsDetialNavigationTitleViewDelegate,GoodsViewDelegate,ShareViewDelegate>

@property(strong,nonatomic) GoodsDetialScrollerView * detialView;

@property(strong,nonatomic) GoodsEvaluationView * goodsEvaluationView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property(strong,nonatomic) GoodsView * goodsView;
@property (weak, nonatomic) IBOutlet UIScrollView *goodScrollerView;

@property (weak, nonatomic) IBOutlet UIButton *payAttentionButton;

@property (weak, nonatomic) IBOutlet UIScrollView *scrolleView;

@property (weak, nonatomic) IBOutlet UIButton *shopButton;

@property (weak, nonatomic) IBOutlet UIButton *customerserviceButton;

@property (weak, nonatomic) IBOutlet UILabel *CustomerserviceLabel;

@property (weak, nonatomic) IBOutlet UILabel *shopLabel;

@property (weak, nonatomic) IBOutlet UILabel *FocusonLabel;

@property (weak, nonatomic) IBOutlet UIButton *addCartButton;

@property (weak, nonatomic) IBOutlet UIButton *buyNowButton;
/** 数量 */
@property(strong,nonatomic) NSString * goodsnumber;
/** 规格 */
@property(strong,nonatomic) NSString * goodspamarID;



@property(strong,nonatomic) GoodsDetialModel * goodsDetialmodel;

@end

@implementation GoodsDetialViewController
{
    BOOL isSelected;
    ButtonView * cartbuttonview;
    BOOL isScrollerAnimation;
    GoodsDetialNavigationTitleView * goodsDetialNavigationTitleView;
}
-(GoodsView *)goodsView
{
    if (!_goodsView) {
        _goodsView =[GoodsView loadView];
        _goodsView.ViewController = self;
        _goodsView.model = self.goodsDetialmodel;
        _goodsView.frame = CGRectMake(0, 0, self.bottomView.frame.size.width, self.goodScrollerView.frame.size.height);
    }
    return _goodsView;
}
-(GoodsDetialScrollerView *)detialView{
    if (!_detialView) {
        _detialView =[GoodsDetialScrollerView loadView];
        [_detialView.goodsDescriptionButton setTitle:[LaguageControl languageWithString:@"商品介绍"] forState:UIControlStateNormal];
        [_detialView.specificationButton setTitle:[LaguageControl languageWithString:@"参数规格"] forState:UIControlStateNormal];
        [_detialView.PackingparametersButton setTitle:[LaguageControl languageWithString:@"包装售后"] forState:UIControlStateNormal];
        if (KScreenBoundWidth>320)
        {
        }
        else
        {
            _detialView.goodsDescriptionButton.titleLabel.font = KSystemFont(11);
            _detialView.specificationButton.titleLabel.font = KSystemFont(11);
            _detialView.PackingparametersButton.titleLabel.font = KSystemFont(11);
        }
        _detialView.ViewController = self;
        _detialView.frame = CGRectMake(KScreenBoundWidth, 0,self.bottomView.frame.size.width, self.goodScrollerView.frame.size.height);
        _detialView.detialWebView.scrollView.scrollEnabled = NO;
    }
    return _detialView;
}
-(GoodsEvaluationView *)goodsEvaluationView{
    if (!_goodsEvaluationView) {
        _goodsEvaluationView = [GoodsEvaluationView loadView];
        _goodsEvaluationView.ViewController = self;
        _goodsEvaluationView.frame = CGRectMake(2*KScreenBoundWidth, 0, self.bottomView.frame.size.width, self.goodScrollerView.frame.size.height);
    }
    return _goodsEvaluationView;
}
- (void)viewDidLoad {
    NSString *temprooturl = [[KAppRootUrl componentsSeparatedByString:@"/mobile"] firstObject];
     self.webUrl = [NSString stringWithFormat:@"%@/phoneh5_zh/product.html?goods_id=%@",temprooturl,self.goodsModelID];
    [super viewDidLoad];
//    self.CustomerserviceLabel.text = [LaguageControl languageWithString:@"客服"];
//    self.shopLabel.text = [LaguageControl languageWithString:@"店铺"];
//    self.FocusonLabel.text = [LaguageControl languageWithString:@"关注"];
//    [self.addCartButton setTitle:[LaguageControl languageWithString:@"加入购物车"] forState:UIControlStateNormal];
//    [self.buyNowButton setTitle:[LaguageControl languageWithString:@"立即购买"] forState:UIControlStateNormal];
//    [self.buyNowButton setBackgroundColor:kNavigationColor];
//    if (KScreenBoundWidth>320)
//    {
//    }
//    else
//    {
//        self.CustomerserviceLabel.font = KSystemFont(11);
//        self.shopLabel.font = KSystemFont(11);
//        self.FocusonLabel.font = KSystemFont(11);
//        self.addCartButton.titleLabel.font = KSystemFont(11);
//        self.buyNowButton.titleLabel.font = KSystemFont(11);
//    }
//    isScrollerAnimation = NO;
//    goodsDetialNavigationTitleView = [GoodsDetialNavigationTitleView loadView];
//    goodsDetialNavigationTitleView.delegate = self;
//    goodsDetialNavigationTitleView.frame = CGRectMake(0, 0, 201, 40);
//    goodsDetialNavigationTitleView.center = self.navigationItem.titleView.center;
//    cartbuttonview  = [ButtonView loadButtonViewWith:nil andbadgeValue:nil andFreme:CGRectMake(0, 0, 60, 40)];
//    self.navigationItem.titleView = goodsDetialNavigationTitleView;
//    [cartbuttonview.clickButton addTarget:self action:@selector(shareButton) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:cartbuttonview];
//    cartbuttonview.ButtonImageView.image = [UIImage imageNamed: kIsChiHuoApp ? @"chtt_minewaitpay" : @"goodsgouwuche"];
//    cartbuttonview.ButtonImageView.contentMode = UIViewContentModeScaleAspectFit;
//    self.scrolleView.contentSize = CGSizeMake(KScreenBoundWidth*3, 0);
//    self.scrolleView.scrollEnabled = YES;
//    [self.scrolleView addSubview:self.detialView];
//    [self.scrolleView addSubview:self.goodsEvaluationView];
//    [self.scrolleView addSubview:self.goodsView];
//    self.goodsView.delegate = self;
//    //设置在拖拽的时候是否显示滚动条
//    self.scrolleView.showsHorizontalScrollIndicator = NO;
//    self.scrolleView.pagingEnabled = YES;
//    self.scrolleView.delegate = self;
//    if ([UserAccountManager shareUserAccountManager].cartnumber) {
//        [cartbuttonview setBadegeValue:[UserAccountManager shareUserAccountManager].cartnumber];
//    }
//    [self NetWork];
           // Do any additional setup after loading the view from its nib.
}
-(void)BaseLoadView
{
    [self GetCart_list];
    self.tabBarController.tabBar.hidden = YES;
}
-(void)SetCartButton
{
    if ([[UserAccountManager shareUserAccountManager].cartnumber integerValue])
    {
        [cartbuttonview setBadegeValue:[UserAccountManager shareUserAccountManager].cartnumber];
    }
    else{
        [cartbuttonview setBadegeValue:@""];
    }
}
#pragma mark - 右上角购物车
/**
 *  购入车
 */
-(void)shareButton
{
  
}

-(void)ShopViewClicked
{

}

/** 获取购物车数量 */
-(void)GetCart_list
{
    __weak GoodsDetialViewController * weakself = self;
    NSDictionary * dic = @{@"user_id":[UserAccountManager shareUserAccountManager].loginStatus?kUserId:@"",
                           @"sessioncart_id":[UserAccountManager shareUserAccountManager].loginStatus?@"":[UserAccountManager shareUserAccountManager].cartUserID};
    [NetWork PostNetWorkWithUrl:@"/get_cart_number" with:dic successBlock:^(NSDictionary *dic)
     {
         
         [UserAccountManager shareUserAccountManager].cartnumber =[NSString stringWithFormat:@"%@",dic[@"data"]];
         [weakself SetCartButton];
      
    } errorBlock:^(NSString *error) {
        
    }];
    
}

/**
 *  网络请求
 */

-(void)NetWork
{
    [HUDManager showLoadingHUDView:self.view];
    if (!self.goodsModelID.length)
    {
        [self GoodsloadView];
    }
    else{
        
        NSDictionary * dic = @{@"goods_id":self.goodsModelID,
                               @"user_id":[UserAccountManager shareUserAccountManager].loginStatus?kUserId:@""};
        [NetWork PostNetWorkWithUrl:@"/goods/category_details" with:dic successBlock:^(NSDictionary * dic)
        {
            [HUDManager hideHUDView];
            if (![dic[@"status"] boolValue])
            {
                [HUDManager showWarningWithText:dic[@"message"]];
                [self backToPresentViewController];

            }
            else{
                if (dic[@"data"])
                {
                    GoodsDetialModel * model = [GoodsDetialModel mj_objectWithKeyValues:dic[@"data"]];
                    self.goodsDetialmodel = model;
                    [self.goodsEvaluationView SetGoodIDWithString:self.goodsDetialmodel.goodsID];
                    [self.detialView SetWebViewLoadUrl:model];
                    [self GoodsloadView];
                    
                    /**获取sku信息*/
                    [NetWork PostNetWorkWithUrl:@"/goods/load_goods_sku" with:@{@"id":self.goodsModelID} successBlock:^(NSDictionary *dic) {
                        model.skuArray = [SkuModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
                    } FailureBlock:^(NSString *msg) {
                        
                    } errorBlock:^(id error) {
                        
                    }];

                }
                else
                {
                    [self backToPresentViewController];
                }
            }
          
        } errorBlock:^(NSString *error) {
            [HUDManager hideHUDView];
//            [HUDManager showWarningWithText:@"请检查网络"];
            [self backToPresentViewController];
        }];
    }

    
}
-(void)GoodsloadView
{
    self.goodsView.model = self.goodsDetialmodel;
    self.payAttentionButton.selected = [self.goodsDetialmodel.favorite boolValue];
    [self.goodsView LoadData:self.goodsDetialmodel.photos];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  加入购物车
 *
 *  @param sender <#sender description#>
 */
- (IBAction)addToShoppingCart:(UIButton *)sender
{
    if (![self loginAction]) {
        return;
    }
    if (!([self.goodsDetialmodel.goods_inventory integerValue]>=1))
    {
        [HUDManager showWarningWithText:@"库存不足"];
        return ;
    }
    if ([UserAccountManager shareUserAccountManager].loginStatus) {
        if (!isSelected) {
            __weak GoodsDetialViewController * weakself = self;
            [self.goodsView PopShowViewWith:PoPTypesAddShopCart andblock:^(id model, BOOL success)
             {
                 if (success)
                 {    isSelected = YES;
                     [weakself addShopCart:^(BOOL success)
                     {
                         
                     }];
                 }
             }];
        }
        else
        {
            [self addShopCart:^(BOOL success)
            {
                
            }];
        }

    }
    else
    {
        UIStoryboard * loginStoryBoard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
        UINavigationController *nav = loginStoryBoard.instantiateInitialViewController;
        LoginViewController * view = (LoginViewController*)nav.topViewController;
        view.isPrompt = YES;
        __weak GoodsDetialViewController * weakself = self;
        [view getisToturBuy:^(BOOL isBuy)
        {
            if (isBuy) {
                [weakself addShopCart:^(BOOL success) {
                    
                }];
            }
        }];
        [self presentViewController:nav animated:YES completion:^{
        }];
    }
 
}

/**
 *  立即购买
 *
 *  @param sender <#sender description#>
 */
- (IBAction)buyNowButton:(UIButton *)sender
{
    if (![self loginAction]) {
        return;
    }
    if (!([self.goodsDetialmodel.goods_inventory integerValue]>=1))
    {
        [HUDManager showWarningWithText:@"库存不足"];
        return ;
    }
    if ([UserAccountManager shareUserAccountManager].loginStatus)
    {
        if (isSelected)
        {
            [self AddAddressWithID];
        }
        else
        {
//            __weak typeof(self) weakSelf = self;
//            __weak GoodsDetialViewController * weakself = self;
            WeakSelf(self);
            [self.goodsView PopShowViewWith:PoPTypesBuyNow andblock:^(id model, BOOL success)
             {
                 
                 if (success)
                 {
                     isSelected = YES;

                     StrongSelf(weakSelf);
//                     __strong
                     [strongSelf AddAddressWithID];
                     
                 }
             }];
        }
    }
    else
    {
        UIStoryboard * loginStoryBoard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
        UINavigationController *nav = loginStoryBoard.instantiateInitialViewController;
        LoginViewController * view = (LoginViewController*)nav.topViewController;
        view.isPrompt = YES;
        WeakSelf(self);
        [view getisToturBuy:^(BOOL isBuy)
        {
            if (isBuy) {
                if (isSelected)
                {
                    [weakSelf AddAddressWithID];
                }
                else{
                    [weakSelf.goodsView PopShowViewWith:PoPTypesBuyNow andblock:^(id model, BOOL success)
                     {
                         
                         if (success)
                         {
                             isSelected = YES;
                             [weakSelf AddAddressWithID];
                         }
                         
                     }];
                }
            }
        }];
        [self presentViewController:nav animated:YES completion:^{
        }];
        
    }

}


-(void)PushToConfirmViewController
{
    
    
    if ([UserAccountManager shareUserAccountManager].cartUserAddress)
    {
        ConfirmOrderViewController * view = [[ConfirmOrderViewController alloc] init];
        view.isBuyNow = YES;
        view.gsp = self.goodspamarID;
        view.goodsID = self.goodsDetialmodel.goodsID;
        view.StoreID = self.goodsDetialmodel.goods_Store_ID;
        view.count = self.goodsnumber;
        self.tabBarController.tabBar.hidden = YES;
        [self.navigationController pushViewController:view animated:YES];
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
        if ([UserAccountManager shareUserAccountManager].userModel.address.length)
        {
            [UserAccountManager shareUserAccountManager].cartUserAddress =[UserAccountManager shareUserAccountManager].userModel.address;
            [self PushTOConfirmViewContrller];
        }
        else
        {
            
//            __weak GoodsDetialViewController * weakself = self;
            WeakSelf(self);
            AddressManagerViewController * view = [AddressManagerViewController new];
            view.isSelect = YES;
            view.block = ^(AddressModel *addressModel){
                [UserAccountManager shareUserAccountManager].cartUserAddress =addressModel.adressId;
                [weakSelf PushTOConfirmViewContrller];
            };
            self.tabBarController.tabBar.hidden = YES;
            [self.navigationController pushViewController:view animated:YES];
            
        }
    }
    else
    {
//        __weak GoodsDetialViewController * weakself = self;
        WeakSelf(self);
        EditAddressNewViewController * address = [EditAddressNewViewController new];
        [address GetBlocksWIth:^(AddressModel *adressModel)
         {
             [weakSelf PushToConfirmViewController];
         }];
        self.tabBarController.tabBar.hidden = YES;
        [self.navigationController pushViewController:address animated:YES];
    }
}




/** 添加了地址 */
-(void)AddAddressWithID
{
    NSString *tempcaraddres = [UserAccountManager shareUserAccountManager].cartUserAddress;
    NSString *tempdefaultaddress = [UserAccountManager shareUserAccountManager].userModel.defaultAdddress;
    if (tempdefaultaddress) {
        [UserAccountManager shareUserAccountManager].cartUserAddress = tempdefaultaddress;
    }
    if ((tempcaraddres && ![tempcaraddres isEqualToString:@""]) ||(tempdefaultaddress && ![tempdefaultaddress isEqualToString:@""]) )
    {
        [self PushTOConfirmViewContrller];
    }
    else
    {
        if ([UserAccountManager shareUserAccountManager].loginStatus) {
            
            __weak GoodsDetialViewController * weakself = self;
            AddressManagerViewController * view = [AddressManagerViewController new];
            view.isSelect = YES;
            view.block = ^(AddressModel *addressModel){
                [UserAccountManager shareUserAccountManager].cartUserAddress =addressModel.adressId;
                [weakself PushTOConfirmViewContrller];
            };
            self.tabBarController.tabBar.hidden = YES;
            [self.navigationController pushViewController:view animated:YES];
            return;
        }
        
        __weak GoodsDetialViewController * weakself = self;
        EditAddressNewViewController * address = [EditAddressNewViewController new];
        [address GetBlocksWIth:^(AddressModel *adressModel)
         {
             if (adressModel.adressId)
             {
                 [UserAccountManager shareUserAccountManager].cartUserAddress =adressModel.adressId;
                 [weakself PushTOConfirmViewContrller];
             }
         }];
        [self.navigationController pushViewController:address animated:YES];
    }
}


-(void)PushTOConfirmViewContrller
{
    ConfirmOrderViewController * view = [[ConfirmOrderViewController alloc] init];
    view.isBuyNow = YES;
    view.gsp = self.goodspamarID;
    view.goodsID = self.goodsDetialmodel.goodsID;
    view.StoreID = self.goodsDetialmodel.goods_Store_ID;
    view.count = self.goodsnumber;
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController pushViewController:view animated:YES];
}
-(void)addShopCart:(void(^)(BOOL success))blcok;
{
    [HUDManager showLoadingHUDView:self.view];
//    __weak GoodsDetialViewController * weakself = self;
    WeakSelf(self);
    [AddCartNetWork AddCartNetWorkgoodid:self.goodsDetialmodel.goodsID number:self.goodsnumber specifi:self.goodspamarID block:^(BOOL success,NSString * number) {
        [HUDManager hideHUDView];
        blcok(success);
        if (success)
        {
//            StrongSelf(weakSelf);
            
            [weakSelf shpopingaddAnimatedWithFrame:CGRectMake(0, 0, KScreenBoundWidth, KScreenBoundHeight) blocks:^{
                [weakSelf GetCart_list];
            }];

        }
    }];
}
/**
 *  商店
 *
 *  @param sender <#sender description#>
 */
- (IBAction)ContactTheShopper:(UIButton *)sender
{
//    if (![self loginAction]) {
//        return;
//    }
//    [PayHandle PayWith:PayTypeWeChat];
    PayAttentionShopViewController * view = [[PayAttentionShopViewController alloc] init];
    view.storeID = self.goodsDetialmodel.goods_Store_ID;
    [self.navigationController pushViewController:view animated:YES];
}
/**
 *  客服
 *
 *  @param sender <#sender description#>
 */
- (IBAction)CustomerService:(UIButton *)sender
{
    if (![self loginAction]) {
        return;
    }
    if ([UserAccountManager shareUserAccountManager].loginStatus)
    {
        if ([self.goodsDetialmodel.store_userId isEqualToString:kUserId])
        {
            [HUDManager showWarningWithText:@"你不能和自己聊天"];
            return;
        }
        {
            StationMessageChatViewController * view = [[StationMessageChatViewController alloc] init];
            view.type = @"0";
            view.toUserID = self.goodsDetialmodel.store_userId;
            view.title = self.goodsDetialmodel.store_userName;
            [self.navigationController pushViewController:view animated:YES];
        }

    }
    else
    {
        UIStoryboard * loginStoryBoard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
        UINavigationController *nav = loginStoryBoard.instantiateInitialViewController;
        LoginViewController * view = (LoginViewController*)nav.topViewController;
        [view getisToturBuy:^(BOOL isBuy) {
            
        }];
        [self presentViewController:nav animated:YES completion:^{
        }];
        
    }

}

/**
 *  关注
 *
 *  @param sender <#sender description#>
 */
- (IBAction)payAttentionButtonClicked:(UIButton *)sender
{
    if (![self loginAction]) {
        return;
    }
    if ([UserAccountManager shareUserAccountManager].loginStatus)
    {
        if ([self.goodsDetialmodel.store_userId isEqualToString:kUserId])
        {
            [HUDManager showWarningWithText:@"不能关注自己的商品"];
            return;
        }
        if (sender.selected)
        {
            [PayAttentNetWork CancelPayAttentNetWorkisGoods:YES withtypeid:self.goodsModelID Success:^(BOOL success) {
                sender.selected = NO;
            }];
        }
        else
        {
            [PayAttentNetWork PayAttentNetWorkisGoods:YES
                                           withtypeid:self.goodsModelID Success:^(BOOL success) {
                                               sender.selected = YES;
                                           }];
        }

    }
    else
    {
        UIStoryboard * loginStoryBoard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
        UINavigationController *nav = loginStoryBoard.instantiateInitialViewController;
        LoginViewController * view = (LoginViewController*)nav.topViewController;
        [view getisToturBuy:^(BOOL isBuy)
         {
            
        }];
        [self presentViewController:nav animated:YES completion:^{
        }];
    }
}


-(void)shpopingaddAnimatedWithFrame:(CGRect)frame blocks:(void (^)(void))block{
    UIImageView * move = [[UIImageView alloc] initWithFrame:CGRectMake(60 , 0, KScreenBoundWidth/2, 100)];
    [move sd_setImageWithURL:[NSURL URLWithString:self.goodsDetialmodel.goodsImageUrl] placeholderImage:[UIImage imageNamed:@"defaultImgGoodsdetail"]];
    move.contentMode = UIViewContentModeScaleAspectFit;
    [[UIApplication sharedApplication].keyWindow addSubview:move];
    // 加入购物车动画效果
    [UIView animateWithDuration:0.5 animations:^{
        move.frame = CGRectMake(KScreenBoundWidth/4*3,KScreenBoundHeight/5,KScreenBoundWidth/4, 60);

    } completion:^(BOOL finished) {
       [UIView animateWithDuration:0.5 animations:^{
           move.frame = CGRectMake(KScreenBoundWidth-40,20,20,20);
       } completion:^(BOOL finished) {
           [move removeFromSuperview];
           block();
       }];
    }];


}

#pragma mark -- GoodsDetialNavigationTitleViewDelegate

-(void)GoodsDetialNavigationTitleViewButtionClicked:(UIButton *)button
{
    [self.scrolleView setContentOffset:CGPointMake((button.tag-1000)*self.scrolleView.frame.size.width,0) animated:YES];
    isScrollerAnimation = YES;

}

#pragma mark --UIScrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    isScrollerAnimation = NO;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (!isScrollerAnimation) {
         NSInteger m = scrollView.contentOffset.x/scrollView.frame.size.width;
         [goodsDetialNavigationTitleView setScrollerWith:m];
    }
    if (!self.goodsEvaluationView.ishowed) {
        [self.goodsEvaluationView loadDatawith:self.goodsDetialmodel.goodsID];
    }
}
#pragma mark-- GoodsViewDelegate
-(void)GoodsViewscrollerToNext
{
    [self.scrolleView setContentOffset:CGPointMake(1*self.scrolleView.frame.size.width,0) animated:YES];
}
-(void)GoodsViewSelected:(NSString *)number andpamar:(NSString *)pamara andpamarID:(NSString *)pamarID with:(PoPTypes)types
{

    self.goodsnumber =number;
    self.goodspamarID = pamarID;
    if (pamara.length)
    {
        isSelected = YES;
    }

}
/**
 *  分享
 */
-(void)shareButtonClicked
{
    if (self.goodsDetialmodel.goods_status == 1) {
        
        [HUDManager showWarningWithText:@"对不起该商品已下架，请联系管理员"];
        return;
    }
    ShareView * share = [[ShareView alloc] init];
    share.delegate = self;
    [share displayToWindow];
}

#pragma mark--ShareViewDelgate
- (void)shareEventWithView:(ShareView *)view
                      type:(ShareTypes)type
{
    NSString *title;
    NSString *text;
    NSString * urlString = KAppRootUrl;
    if([KAppRootUrl hasSuffix:@"/mobile"])
    {
        urlString = [urlString stringByReplacingOccurrencesOfString:@"/mobile" withString:@""];
    }
    NSString * shareUrl = [NSString stringWithFormat:@"%@/phoneh5_zh/a_ftproduct.html?signType=1&goods_id=%@",urlString,self.goodsModelID];
    
    if (type == ShareTypeQQTypeWechatSession) {
        /**微信好友*/
        title = @"我在吃货头条发现一样好东西想跟你分享~";
        text = self.goodsDetialmodel.goods_name;
        
    }else{
        /**微信朋友圈*/
        title = self.goodsDetialmodel.goods_name;
        text = @"";
        
    }
    [AppAsiaShare shareType:type title:title text:text WithContentUrl:shareUrl imagePath:self.goodsDetialmodel.goodsImageUrl success:^{
        [HUDManager showWarningWithText:@"分享成功"];
        [view removeFromWindow];
    } fail:^(NSString *errorMessage) {
        [HUDManager showWarningWithText:errorMessage];
        [view removeFromWindow];
    } cancel:^{
        [view removeFromWindow];
    }];
    
}


@end
