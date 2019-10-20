//
//  PayAttentionShopViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/13.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "PayAttentionShopViewController.h"

#import "PayAttentionGoodsViewController.h"

#import "VipPriceModel.h"
#import "PayAttentionCollectionViewCell.h"
#import "ShopHeadCollectionReusableView.h"
#import "BaviTitleView.h"
#import "StationMessageChatViewController.h"
#import "PopPayAttentionView.h"
#import "ClassGoodsViewController.h"
#import "ShopDetialViewController.h"
#import "AttentShopModel.h"
#import "ShopGoodsModel.h"
#import "GoodsDetialViewController.h"
#import "PayAttentNetWork.h"
#import "YBPopupMenu.h"

#import <SDWebImage/UIImageView+WebCache.h>
#import "LoginViewController.h"
static NSString * CellIdentifier = @"PayAttentionCollectionViewCell";

static NSString * HeadIdentifier = @"ShopHeadCollectionReusableView";

@interface PayAttentionShopViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,PopPayAttentionViewDelegate,UISearchBarDelegate,YBPopupMenuDelegate,ShopHeadCollectionReusableViewDelegate>

/** 商铺列表 */
@property (weak, nonatomic) IBOutlet UICollectionView *attentCollectionView;

@property (weak, nonatomic) IBOutlet UIButton *shopDetialButton;

@property (weak, nonatomic) IBOutlet UIButton *connectToSeversButton;

@property (weak, nonatomic) IBOutlet UIButton *PopularcategoriesButton;
/** 数组 */
@property(strong,nonatomic) NSMutableArray * dataArray;

@property(strong,nonatomic) AttentShopModel * model;



@end

@implementation PayAttentionShopViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        if ([[NSUserDefaults standardUserDefaults]boolForKey:kIsB2cStr]) {
            return nil;
        }
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.attentCollectionView.alwaysBounceVertical = YES;
    self.attentCollectionView.backgroundColor = kBGColor;
    self.dataArray = [NSMutableArray array];
    [self.shopDetialButton setTitle:LaguageControl(@"店铺详情") forState:UIControlStateNormal];
    [self.connectToSeversButton setTitle:LaguageControl(@"联系客服") forState:UIControlStateNormal];
    [self.PopularcategoriesButton setTitle:LaguageControl(@"热门分类") forState:UIControlStateNormal];
    if (KScreenBoundWidth>320)
    {
        self.PopularcategoriesButton.titleLabel.font = KSystemFont(12);
        self.connectToSeversButton.titleLabel.font = KSystemFont(12);
        self.shopDetialButton.titleLabel.font = KSystemFont(12);
    }
    else
    {
        self.PopularcategoriesButton.titleLabel.font = KSystemFont(11);
        self.connectToSeversButton.titleLabel.font = KSystemFont(11);
        self.shopDetialButton.titleLabel.font = KSystemFont(11);
    }
    [self.attentCollectionView registerNib:[UINib nibWithNibName:CellIdentifier bundle:nil] forCellWithReuseIdentifier:CellIdentifier];
    [self.attentCollectionView registerNib:[UINib nibWithNibName:HeadIdentifier bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeadIdentifier];
    if (self.storeID) {

        [self updataHeader:self.attentCollectionView];
    }
    
    // Do any additional setup after loading the view from its nib.
}
-(void)updateHeadView{
    [self NetWork];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.storeID) {
        [self beginRefresh];
    }
}
-(void)loadNavigabarTitleView{
    BaviTitleView * view  = [BaviTitleView loadView];
    self.navigationItem.titleView = view;
    view.searchBar.layer.cornerRadius = 5;
    view.searchBar.delegate = self;
    view.searchBar.layer.masksToBounds = YES;
    view.searchBar.backgroundImage = [UIImage new];
}
-(void)NetWork
{
    if (self.storeID) {
    }
    NSDictionary * dic = @{@"id":self.storeID,
                           @"user_id":[UserAccountManager shareUserAccountManager].loginStatus?kUserId:@""};
    [NetWork PostNetWorkWithUrl:@"/store_class/store_info" with:dic successBlock:^(NSDictionary *dic)
    {
        [self endRefresh];
        [HUDManager hideHUDView];
        if ([dic[@"status"] boolValue])
        {
             AttentShopModel * model = [AttentShopModel mj_objectWithKeyValues:dic[@"data"]];
             self.dataArray = [ShopGoodsModel mj_objectArrayWithKeyValuesArray:model.goodsInfoArray];
             self.title = model.store_name;
             self.model = model;
            if (!self.model.viePriceArray.count) {
                if (!kIsHaveCoupon) {
                    [self.attentCollectionView reloadData];
                }else{
                    [self getViePricelist];
                }
            }else{
            }
        }
        else
        {
            [HUDManager showWarningWithText:dic[@"message"]];
            [self backToPresentViewController];
        }
    } errorBlock:^(NSString *error)
     {
         [self endRefresh];
        [HUDManager hideHUDView];
        [HUDManager showWarningWithText:@"店铺信息获取失败"];
        [self backToPresentViewController];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadRightnavigabarTouchEvent
{
    [self.navigationTitleview.rightButton setTitle:@"" forState:UIControlStateNormal];
}
-(void)rightButtonClicked
{
    
}
- (IBAction)shopfordetailsButtonClicked:(UIButton *)sender
{
    ShopDetialViewController * view = [ShopDetialViewController new];
    view.storeModel = self.model;
    [self.navigationController pushViewController:view animated:YES];
}
- (IBAction)popularCategoriesButtonClicked:(UIButton *)sender
{
    
    YBPopupMenu *tempview = [YBPopupMenu showRelyOnView:sender
                                                 titles:@[@"    全部    ",@"    价格    ",@"    销量    "]
                                                  icons:@[@"",@""]
                                              menuWidth:100
                                               delegate:self];
    tempview.fontSize = 12;
    
//    PopPayAttentionView * view = [PopPayAttentionView loadView];
//    view.delegate = self;
//    [view showView];
}

-(void)ybPopupMenuDidSelectedAtIndex:(NSInteger)index ybPopupMenu:(YBPopupMenu *)ybPopupMenu{
    [self ClickedWithSection:index];
}
- (IBAction)contactCustomerServiceButtonClicked:(UIButton *)sender
{
    if ([UserAccountManager shareUserAccountManager].loginStatus)
    {
        if ([self.model.store_userId isEqualToString:kUserId])
        {
            [HUDManager showWarningWithText:@"你不能和自己聊天"];
            return;
        }
        {
            StationMessageChatViewController * view = [StationMessageChatViewController new];
            view.type = @"0";
            view.toUserID = self.model.store_userId;
            view.title =self.model.store_userName;
            [self.navigationController pushViewController:view animated:YES];
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

#pragma mark -- UICollectionViewDelegate && UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return  self.model?1:0;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShopGoodsModel * model = self.dataArray[indexPath.row];
    PayAttentionCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    if ([model.activity_status isEqualToString:@"2"]) {
        /**活动商品*/
        NSString *tempstr = [@"[活动]" stringByAppendingString:model.goods_name];
        NSMutableAttributedString *attristring = [[NSMutableAttributedString alloc]initWithString:tempstr];
        [attristring addAttribute:NSForegroundColorAttributeName value:kNavigationColor range:NSMakeRange(0, 4)];
        cell.goodsName.attributedText = attristring;
    }else{
        cell.goodsName.text = model.goods_name;
    }
    [cell.goodImageView sd_setImageWithURL:[NSURL URLWithString:model.goods_logo] placeholderImage:[UIImage imageNamed:@"defaultImgForGoods"]];
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:@"UICollectionElementKindSectionHeader"]) {
        ShopHeadCollectionReusableView * headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:HeadIdentifier forIndexPath:indexPath];
        //TODO: 暂无轮播图
        [headView loadViewWith:self.model.storeSlideArray vipPrice:self.model.viePriceArray];
        headView.delegate = self;
        headView.shopTitleLabel.text =self.model.store_name;
        headView.attentNumberLabel.text = [NSString stringWithFormat:@"%@  关注", self.model.favorite_count];
        headView.attentionButton.selected = [self.model.favorite boolValue];
        [headView.attentionButton addTarget:self action:@selector(guanzhuButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [headView.shopImageView sd_setImageWithURL:[NSURL URLWithString:self.model.store_logo] placeholderImage:[UIImage imageNamed:@"defaultImgbanner"]];

        [headView.backGroundImageView sd_setImageWithURL:[NSURL URLWithString:self.model.store_banner] placeholderImage:[UIImage imageNamed:@"fixBanner"]];
            headView.backGroundImageView.backgroundColor = KArc4andomColor;
        return headView;
    }
    else{
        return nil;
    }

}

#pragma mark -- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.frame.size.width/2 ,collectionView.frame.size.width/2);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (!self.model.viePriceArray.count) {
        return CGSizeMake(collectionView.frame.size.width, 425-85);
 
    }else{
        return CGSizeMake(collectionView.frame.size.width, 425);
    }
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShopGoodsModel * model = self.dataArray[indexPath.row];
    GoodsDetialViewController * view = [GoodsDetialViewController new];
    view.goodsModelID =model.goodsID;
    [self.navigationController pushViewController:view animated:YES];
    
}
#pragma mark -- PopPayAttentionViewDelegate
-(void)ClickedWithSection:(NSInteger)section
{

    ClassGoodsViewController * view = [ClassGoodsViewController new];
    view.title = self.model.store_name;

    if (section==0)
    {
        view.sortSting = @"1";
    }
    else if(section==1)
    {
        view.sortSting = @"2";
    }
    else if(section==2)
    {
        view.sortSting = @"3";
    }
    else{
        view.sortSting = @"3";
    }
    view.goodID = self.storeID;
    view.isSTore = YES;
    [self.navigationController pushViewController:view animated:YES];
    
}
#pragma mark -- UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    ClassGoodsViewController * view = [ClassGoodsViewController new];
    view.title = self.model.store_name;
    view.goodID = self.storeID;
    view.isSTore = YES;
    [self.navigationController pushViewController:view animated:YES];
    return NO;
}
- (void)guanzhuButtonClicked:(UIButton *)sender
{
    if (![self loginAction]) {
            return;
    }
    if ([self.model.store_userId isEqualToString:kUserId])
    {
        [HUDManager showWarningWithText:@"不能关注自己的店铺"];
        return;
    }
    if (!sender.selected)
    {
        [PayAttentNetWork  PayAttentNetWorkisGoods:NO withtypeid:self.storeID Success:^(BOOL success) {
            if (success) {
                sender.selected = YES;
                self.model.favorite = @"1";
                self.model.favorite_count = [[NSNumber numberWithInteger:[self.model.favorite_count integerValue]+1] stringValue];
                [self.attentCollectionView reloadData];
            }
            
        }];
    }
    else
    {
        [PayAttentNetWork  CancelPayAttentNetWorkisGoods:NO withtypeid:self.storeID Success:^(BOOL success) {
            if (success) {
                sender.selected = NO;
                self.model.favorite = @"0";
                self.model.favorite_count = [[NSNumber numberWithInteger:[self.model.favorite_count integerValue]-1] stringValue];
                [self.attentCollectionView reloadData];
            }
            
        }];
    }
}

#pragma mark - 点击优惠券
-(void)shopHeadCollectionReusableView:(ShopHeadCollectionReusableView *)head indexparRow:(NSInteger)row{
    if (![self loginAction]) {
        return;
    }
    if ([self.model.store_userId isEqualToString:kUserId])
    {
        [HUDManager showWarningWithText:@"自己的店铺不能领取"];
        return;
    }
    VipPriceShopModel *m = self.model.viePriceArray[row];
    
    [self getViPriceMoneyWithVipPriceId:m.modelId];
}

#pragma mark - 获取优惠券
- (void)getViePricelist{
    
    
    [NetWork PostNetWorkWithUrl:@"/coupon/getCouponByStoreId" with:@{@"storeId":self.storeID,@"userId":kUserId} successBlock:^(NSDictionary *dic) {
        
        NSArray *temparray = [VipPriceShopModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
        self.model.viePriceArray = temparray;
        [self.attentCollectionView reloadData];
        
    } FailureBlock:^(NSString *msg) {
        [HUDManager showWarningWithText:msg];
        [self backToPresentViewController];
    } errorBlock:^(id error) {
        
    }];
}
- (void)getViPriceMoneyWithVipPriceId:(NSString *)vipId{
    
    [NetWork PostNetWorkWithUrl:@"/coupon/reciveStoreCoupon" with:@{@"couponId":vipId,@"userId":kUserId} successBlock:^(NSDictionary *dic) {
        [HUDManager showWarningWithText:dic[@"data"]?:@"领取成功"];
        
    } FailureBlock:^(NSString *msg) {
        [HUDManager showWarningWithText:msg?:@"优惠券抢光了"];
    } errorBlock:^(id error) {
        
    }];
}

@end
