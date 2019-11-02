//
//  IntegralMallHomeViewController.m
//  TheProjectFrameWork
//
//  Created by yuntai on 16/7/26.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "IntegralMallHomeViewController.h"
#import "IntegralHomeGoodsCell.h"
#import "IntegralMallHeadView.h"
#import "IntegralHomeGoodsHorizontalCell.h"
#import <MJExtension.h>
#import "IntegralHomeModel.h"
#import "IntegralBannerModel.h"
#import "BaseWebViewController.h"
#import "PayAttentionShopViewController.h"
#import "PromotionGoodsViewController.h"
#import "ShufflingManager.h"
#import "NSDate+Conversion.h"

static NSString * cellIdentifierH = @"IntegralHomeGoodsCell";
static NSString * headIdentifier = @"IntegralMallHeadView";
static NSString * cellIdentifierW = @"IntegralHomeGoodsHorizontalCell";

@interface IntegralMallHomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,IntegralHomeGoodsHorizontalCellDelegate,IntegralHomeGoodsCellDelegate,UISearchBarDelegate,IntegralMallHeadViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *integralLabel;//积分label
@property (weak, nonatomic) IBOutlet UILabel *myIntegralLabel;
@property (weak, nonatomic) IBOutlet UIButton *convertRecordBtn;//兑换记录按钮

@property (weak, nonatomic) IBOutlet UICollectionView *collectionview;
@property (nonatomic, strong) NSMutableArray *array;//数据源
@property (nonatomic, strong) NSMutableArray *bannerArray;//轮播图数组
@property (nonatomic, assign) BOOL isHorizontal;
@end

@implementation IntegralMallHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.array = [NSMutableArray array];
    self.bannerArray = [NSMutableArray array];
    self.collectionview.backgroundColor = kBGColor;
    self.integralLabel.textColor  = kNavigationColor;
    [self.convertRecordBtn setTitleColor:kNavigationColor forState:UIControlStateNormal];
    [self updataNewData:self.collectionview];
    
    self.convertRecordBtn.layer.borderColor = kNavigationCGColor;
    self.convertRecordBtn.layer.borderWidth = 1.f;
    
    [self.collectionview registerNib:[UINib nibWithNibName:cellIdentifierH bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:cellIdentifierH];
    [self.collectionview registerNib:[UINib nibWithNibName:cellIdentifierW bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:cellIdentifierW];
    
    [self.collectionview registerNib:[UINib nibWithNibName:headIdentifier bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headIdentifier];
    
    self.navigationTitleview.searchBar.delegate = self;
    
    WeakSelf(self)
    [self setCenterSearchViewWithDelegete:self];
    [self setRightBtnImage:[UIImage imageNamed:@"jf-shu"] Size:CGSizeMake(20, 20) eventHandler:^(id sender) {
        [weakSelf naviRightBtnClick:sender];
    }];
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"integralStoreSwitch"]) {
        [self setLeftBtnImage:[UserAccountManager shareUserAccountManager].logoImageUrl?: @"logo" eventHandler:^(id sender) {
            
        }];

    }else{
        [self setLeftBtnImage: @"fanhui" eventHandler:^(id sender) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];

        
    }
    
    /**请求数据*/
    [HUDManager showLoadingHUDView:self.view];
    self.currentPage = 1;
    /**商品列表*/
    [self getdatahomeFromServer];
    /**轮播图请求*/
    [self getdataBannerIntegralFromServer];
//    [self getdataMyIntegralFromServer];
    
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    IntegralSearchViewController * vc = [IntegralSearchViewController new];
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];
    
    return NO;
}
/** 导航栏左侧去掉返回 */
-(void)loadLeftnavigabarTouchEvent{
    if (self.isNotFromRoot) {
        [super loadLeftnavigabarTouchEvent];
    }
}
/** 加载导航栏左侧 */
- (void)loadNavBarButton{
    if (!self.navigationBarView) {
        self.navigationBarView = [NavigationBarView loadView];
    }
    self.navigationBarView .frame = CGRectMake(0, 0, 80, 32);
//    [self.navigationBarView .leftButton addTarget:self action:@selector(PopView) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationBarView .leftButton setImage:[UIImage imageNamed:@"hanli"] forState:UIControlStateNormal];
    self.navigationBarView .backgroundColor = [UIColor colorWithWhite:0.1 alpha:0];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView: self.navigationBarView ];

}

/** 加载导航栏右侧按钮 */
-(void)loadRightnavigabarTouchEvent{

    [self.navigationTitleview.rightButton addTarget:self action:@selector(naviRightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationTitleview.rightButton setImage:[UIImage imageNamed:@"jf-heng"] forState:UIControlStateNormal];//changeProductListGrid
}

/**
 *  导航栏右侧按钮点击->改变页面样式
 *
 *  @param sender sender description
 */
- (void)naviRightBtnClick:(UIButton *)sender
{
    self.isHorizontal = !self.isHorizontal;
    [self.collectionview reloadData];
    if (self.isHorizontal) {
        [sender setImage:[UIImage imageNamed:@"jf-heng"] forState:UIControlStateNormal];
    }else{
        [sender setImage:[UIImage imageNamed:@"jf-shu"] forState:UIControlStateNormal];
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.myIntegralLabel.text = LaguageControlAppend(@"我的积分");
    [self.convertRecordBtn setTitle:LaguageControl(@"兑换记录") forState:UIControlStateNormal];
    if ([UserAccountManager shareUserAccountManager].loginStatus) {
        self.integralLabel.text = [UserAccountManager shareUserAccountManager].userModel.integral?:@"0";
    }else{
        self.integralLabel.text = @"0";
    }
    [self.collectionview reloadData];
    self.navigationTitleview.searchBar.placeholder = LaguageControl(@"搜索");
}
#pragma mark - CollectionDataSource代理
//CollectionView的Section数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
// 设计每个section的Item数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.array.count;
//    return 10;
}
// 加载CollectionViewCell的数据
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isHorizontal) {//水平
        IntegralHomeGoodsHorizontalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([IntegralHomeGoodsHorizontalCell class]) forIndexPath:indexPath];
        cell.delegate = self;
        [cell configGoodsCellWithGoodsModel:self.array[indexPath.row]];
        return cell;
    }
    IntegralHomeGoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([IntegralHomeGoodsCell class]) forIndexPath:indexPath];
    cell.delegate = self;
    [cell configGoodsCellWithGoodsModel:self.array[indexPath.row]];
    return cell;
}

#pragma mark - CollectionView代理
// CollectionView元素选择事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    IntegralGoodsDetailController *vc = [[IntegralGoodsDetailController alloc]init];
//    vc.hidesBottomBarWhenPushed = YES;
//    vc.model = self.array[indexPath.row];
//    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -CollectionViewFlowlayout代理
// 设置CollectionViewCell大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = collectionView.frame.size.width/2.0-7.5;
    CGFloat height = collectionView.frame.size.width/2.0-7.5 + 113;
    CGSize itemSize = CGSizeMake(width, height);
    if (self.isHorizontal) {
        itemSize = CGSizeMake(collectionView.frame.size.width, 150);
    }
    return itemSize;
}
/* 定义每个UICollectionView 的边缘 */
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);//上 左 下 右
}

//每个item之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}

// 设置Sectionheader大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize itemSize =CGSizeMake(collectionView.frame.size.width, 160);
    return itemSize;
}

// 设置SectionFooter大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    CGSize itemSize = CGSizeMake(0, 0);
    return itemSize;
}

//设置Header和FooterView
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
            IntegralMallHeadView *view = (IntegralMallHeadView *)[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headIdentifier forIndexPath:indexPath];
        NSMutableArray *bannerUrls = [NSMutableArray array];
        if (self.bannerArray.count>0) {
            for (IntegralBannerModel *bannerModel in self.bannerArray) {
                [bannerUrls addObject:bannerModel.img_url?:kDefaultBannerImage];
            }
            view.delegate = self;
            if (self.bannerArray.count==1) {
                view.ScrollerView.autoScroll = NO;
            }else{
                view.ScrollerView.autoScroll = YES;
            }
        }else{
            [bannerUrls addObject:kDefaultBannerImage];
            view.ScrollerView.autoScroll = NO;
        }
        
        [view loadViewWith:bannerUrls WithSection:indexPath.section];
            return view;
        
    }
    return nil;
}
#pragma mark -IntegralHeadViewDelegate
/**轮播图点击*/
-(void)integralMallHeadView:(IntegralMallHeadView *)headView indexNum:(NSInteger)indexNum{
    AdvertListModel *model = self.bannerArray[indexNum];
    //1、商品详情 2、店铺 、3积分商城，4、活动， 5、网页 6 促销活动
//    if ([model.ad_type isEqualToString:@"3"]) {
//        return;
//    }
    if ([ShufflingManager ShufflingManagerPushType:model.ad_type withValue:model.ad_type_value]) {
        NSString *tempValue = [model.ad_type_value isEqualToString:@""] ? model.ad_url:model.ad_type_value;

        UIViewController *vc = [ShufflingManager ShufflingManagerPushType:model.ad_type withValue:tempValue];
//        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark -IntegralHomeGoodsHorizontalCellDelegate  IntegralHomeGoodsCellDelegate
//水平cell 我要兑换
-(void)integralHomeHorizontalCell:(IntegralHomeGoodsHorizontalCell *)cell{
    
    if (![UserAccountManager shareUserAccountManager].loginStatus) {
        UIStoryboard * loginStoryBoard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
        [self presentViewController:loginStoryBoard.instantiateInitialViewController animated:YES completion:^{
        }];
        return;
    }
    
    NSIndexPath *indexPath = [self.collectionview indexPathForCell:cell];
    IntegralHomeModel *model = self.array[indexPath.row];
    
    /**时间限制*/
    if (![NSDate conversionToDate:model.ig_end_time limitType:model.ig_time_type]) {
        [HUDManager showWarningWithText:@"礼品过期"];
        return;
    }
    /**积分限制*/
    if ([model.ig_goods_integral integerValue]> [[UserAccountManager shareUserAccountManager].userModel.integral integerValue]) {
        [HUDManager showWarningWithText:LaguageControl(@"积分不足")];
        return;
    }
    //加入购物车成功跳转
    [self getdataAddCarFromServerWithGoodsId:model.goodsId integral:model.ig_goods_integral];
}
//竖排cell 我要兑换
-(void)integralHomeCell:(IntegralHomeGoodsCell *)cell{
    
    if (![UserAccountManager shareUserAccountManager].loginStatus) {
        UIStoryboard * loginStoryBoard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
        [self presentViewController:loginStoryBoard.instantiateInitialViewController animated:YES completion:^{
        }];
        return;
    }
    NSIndexPath *indexPath = [self.collectionview indexPathForCell:cell];
    IntegralHomeModel *model = self.array[indexPath.row];
    
    /**时间限制*/
    if (![NSDate conversionToDate:model.ig_end_time limitType:model.ig_time_type]) {
        [HUDManager showWarningWithText:@"礼品过期"];
        return;
    }
    /**积分限制*/
    if ([model.ig_goods_integral integerValue]> [[UserAccountManager shareUserAccountManager].userModel.integral integerValue]) {
        [HUDManager showWarningWithText:@"积分不足"];
        return;
    }
    //加入购物车成功跳转
    [self getdataAddCarFromServerWithGoodsId:model.goodsId integral:model.ig_goods_integral];

}
#pragma mark - event response
/**兑换记录*/
- (IBAction)integtalConvertBtnClick:(UIButton *)sender {

    
    if (![UserAccountManager shareUserAccountManager].loginStatus) {
        UIStoryboard * loginStoryBoard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
        [self presentViewController:loginStoryBoard.instantiateInitialViewController animated:YES completion:^{
        }];
        return;
    }
//    IntegralConvertLogViewController *vc = [[IntegralConvertLogViewController alloc]init];
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark --UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
//    IntegralSearchViewController * vc = [IntegralSearchViewController new];
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];
    
    return NO;
}

#pragma mark --NetWork
/**积分商品列表*/
-(void)getdatahomeFromServer
{
    NSString *useridid = @"";
    if ([UserAccountManager shareUserAccountManager].loginStatus) {
        useridid = kUserId;
    }
    NSDictionary * parms =@{@"currentPage":@(self.currentPage),@"orderBy":@"addTime",@"user_id":useridid};
    
     
     [NetWork PostNetWorkWithUrl:IntegralHomeUrlAction with:parms successBlock:^(NSDictionary *dic) {
         [HUDManager hideHUDView];
         [self endRefresh];

         NSArray *lists = [IntegralHomeModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
         for (IntegralHomeModel *integralmodel in lists) {

             float goodsinteral = [integralmodel.ig_goods_price floatValue];
             integralmodel.ig_goods_price = [NSString stringWithFormat:@"%.2f",goodsinteral];
             [self.array addObject:integralmodel];
         }
//         [self.array addObjectsFromArray:lists];
         if (lists.count < 10) {
             [self.collectionview.mj_footer endRefreshingWithNoMoreData];
         }
         
         /**获取积分*/
         NSString *integral= dic[@"statusStr"];
         if ([integral isKindOfClass:[NSNull class]]|| integral == nil ) {
             integral = @"0";
         }
         [UserAccountManager shareUserAccountManager].userModel.integral = integral?:@"0";
         if ([UserAccountManager shareUserAccountManager].loginStatus) {
             self.integralLabel.text = [UserAccountManager shareUserAccountManager].userModel.integral?:@"0";
         }else{
             self.integralLabel.text = @"0";
         }
         [self.collectionview reloadData];

        
    } FailureBlock:^(NSString *msg) {
        [self endRefresh];
        [HUDManager showWarningWithText:msg];
    } errorBlock:^(NSError *error) {
        [self endRefresh];
    }];
}

/**积分商城轮播图*/
-(void)getdataBannerIntegralFromServer
{
    //1、商品详情 2、店铺 、3积分商城，4、活动， 5、网页
    //mark = 4 积分      mark = 3 大厅
    self.bannerArray = (NSMutableArray *)[UserAccountManager shareUserAccountManager].interSliderModelArray;
    [self.collectionview reloadData];

}


/**头部刷新*/
-(void)updateHeadView{
        self.currentPage = 1;
        [self.array removeAllObjects];
        [self getdatahomeFromServer];
        [self getdataBannerIntegralFromServer];
}
/**尾部刷新*/
- (void)updateFootView{
        self.currentPage ++;
        [self getdatahomeFromServer];
}

/**加入购物车*/
-(void)getdataAddCarFromServerWithGoodsId:(NSString *)goodsId integral:(NSString *)integral
{
    [HUDManager showLoadingHUDView:self.view];
    NSDictionary * parms = @{@"user_id":kUserId,@"integral_goods_id":goodsId,@"integral":integral};
    
    [NetWork PostNetWorkWithUrl:IntegralGoodsAddCar with:parms successBlock:^(NSDictionary *dic) {
        [self endRefresh];
//        IntegralConfirmGoodsViewController *vc =[[IntegralConfirmGoodsViewController alloc]init];
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
        
        
    } FailureBlock:^(NSString *msg) {
        [self endRefresh];
        [HUDManager showWarningWithText:msg];
    } errorBlock:^(NSError *error) {
        [self endRefresh];
    }];
}

/**获取我的积分*/
#pragma mark --NetWork
-(void)getdataMyIntegralFromServer
{
    NSDictionary * parms = @{@"user_id":kUserId};
    [NetWork PostNetWorkWithUrl:IntegralInfoUrlAction with:parms successBlock:^(NSDictionary *dic) {
    
    } FailureBlock:^(NSString *msg) {
        
    } errorBlock:^(NSError *error) {
        
    }];
}

@end
