//
//  PayAttentionGoodsViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/13.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "PayAttentionGoodsViewController.h"
#import "PayAttentGoodsTableViewCell.h"
#import "AttentionShopTableViewCell.h"
#import "PayAttentionTitleView.h"
#import "AttentGoodsModel.h"
#import "GoodsDetialViewController.h"
#import "PayAttentionShopViewController.h"
#import "AddCartNetWork.h"
#import "ShareView.h"
#import "AppAsiaShare.h"
#import "NewPayAttentGoodsTableViewCell.h"
static NSString * GoodsCellIdentifier = @"PayAttentGoodsTableViewCell";
static NSString * ShopCellIdentifier = @"AttentionShopTableViewCell";

@interface PayAttentionGoodsViewController ()<UITableViewDelegate,UITableViewDataSource,PayAttentionTitleViewDelegate/*,AttentionDelegate*/,ShareViewDelegate,NewPayAttentGoodsTableViewCellDelegate,NewAttentionShopTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *payAttentionTableView;
/** 数据源 */
@property(strong,nonatomic) NSMutableArray * dataArray;

@end

@implementation PayAttentionGoodsViewController
{
    AttentGoodsModel * _selectModel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    [self updataNewData:self.payAttentionTableView];
    [self beginRefresh];
    PayAttentionTitleView * titleView = [PayAttentionTitleView loadView];
    if (self.isShop) {
        titleView.goodsButton.backgroundColor = [UIColor clearColor];
        titleView.shopButton.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.5];
    }
    
    [titleView.shopButton setTitle:LaguageControl(@"店铺") forState:UIControlStateNormal];
    [titleView.goodsButton setTitle:LaguageControl(@"商品") forState:UIControlStateNormal];
    
//    titleView.frame = CGRectMake(0, 0, 150, 40);
    
    titleView.delegate = self;
    self.navigationItem.titleView = titleView;
    [self NetWork];
    [self.payAttentionTableView registerClass:[NewPayAttentGoodsTableViewCell class] forCellReuseIdentifier:GoodsCellIdentifier];
    [self.payAttentionTableView registerClass:[NewAttentionShopTableViewCell class] forCellReuseIdentifier:ShopCellIdentifier];
    // Do any additional setup after loading the view from its nib.
}
-(void)editBarButtom
{
    
}
-(void)updateHeadView{
    [self endRefresh];
    [super updateHeadView];
}
-(void)updateFootView{
    [self endRefresh];
    [super updateFootView];
}
-(void)NetWork
{
    NSString * types = @"0";
    if (self.isShop) {
        types =@"1";
    }
    NSDictionary * dic = @{@"user_id":kUserId,
                           @"follow_type":types};
    
    [HUDManager showLoadingHUDView:self.view];
    [NetWork PostNetWorkWithUrl:@"/buyer/follow_info" with:dic successBlock:^(NSDictionary *dic)
    {
        [HUDManager hideHUDView];
        [self.dataArray removeAllObjects];
        [self endRefresh];
        if ([dic[@"status"] boolValue]) {
            self.dataArray =  [AttentGoodsModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
            
            if([types isEqualToString:@"1"])
            {
                [UserAccountManager shareUserAccountManager].userModel.storeCount = _dataArray.count;
            }else
            {
                [UserAccountManager shareUserAccountManager].userModel.goodsCount = _dataArray.count;
            }
            [[UserAccountManager shareUserAccountManager]saveAccountDefaults];
        }else
        {
            [HUDManager showWarningWithError:dic[@"message"]];
            self.dataArray = nil;
        }
        [self.payAttentionTableView showNoView:nil image:nil certer:CGPointZero isShow:!self.dataArray.count];
        [self.payAttentionTableView reloadData];
    } errorBlock:^(NSString *error) {
        [HUDManager hideHUDView];
        [self endRefresh];
        self.dataArray = nil;
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --PayAttentionTitleViewDelegate
-(void)PayAttentionTitleViewButtonClicked:(UIButton *)button
{
    if ([button.titleLabel.text isEqualToString:LaguageControl(@"商品")])
    {
        self.isShop = NO;
    }
    else{
        self.isShop = YES;
    }
    [self NetWork];

}
#pragma mark --UITableViewDelegate && UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AttentGoodsModel * model = self.dataArray[indexPath.row];
    if (!self.isShop) {
        // 商品
        NewPayAttentGoodsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:GoodsCellIdentifier];
        cell.model = model;
        cell.indexRow = indexPath.row;
        cell.delegate = self;
        return cell;
    }
    else{
        NewAttentionShopTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ShopCellIdentifier];
        cell.model = model;
        cell.indexRow = indexPath.row;
        cell.delegate = self;
        return cell;
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AttentGoodsModel * model = self.dataArray[indexPath.row];
    if (!self.isShop) {
        GoodsDetialViewController * view = [GoodsDetialViewController new];
        view.goodsModelID = model.attentgoodsID;
        [self.navigationController pushViewController:view animated:YES];
    }
    else{
        PayAttentionShopViewController * view = [PayAttentionShopViewController new];
        view.storeID = model.attentstoreID;
        [self.navigationController pushViewController:view animated:YES];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(void)NetWorkWithString:(NSString*)string
{
    [HUDManager showLoadingHUDView:self.view];
    if (!string) {
        return ;
    }
    NSDictionary * dic = @{
                           @"type_id":string,
                           };
    __weak PayAttentionGoodsViewController * weakself = self;
    [NetWork PostNetWorkWithUrl:@"/buyer/delFavoriteInfo" with:dic successBlock:^(NSDictionary *dic)
    {
        [HUDManager hideHUDView];
     [weakself NetWork];
    } errorBlock:^(NSString *error)
     {
         [HUDManager hideHUDView];
    }];
}
#pragma mark-- AttentionDelegate (商品操作)
/**
 *  删除
 *
 *  @param view      <#view description#>
 *  @param indexpath <#indexpath description#>
 */
- (void)payAttentGoodsDeleteWithCell:(NewPayAttentGoodsTableViewCell *)cell
{
    AttentGoodsModel * model = self.dataArray[cell.indexRow];
    [self NetWorkWithString:model.attentsId];
}
/**
 *  添加购物车
 *
 *  @param view      <#view description#>
 *  @param indexpath <#indexpath description#>
 */
- (void)payAttentGoodsAddCartWithCell:(NewPayAttentGoodsTableViewCell *)cell
{
    AttentGoodsModel * model = self.dataArray[cell.indexRow];
//    GoodsDetialViewController * detial = [GoodsDetialViewController new];
//    detial.goodsModelID = model.attentgoodsID;
//    [self.navigationController pushViewController:detial animated:YES];
    [AddCartNetWork AddCartNetWorkgoodid:model.attentgoodsID number:@"1" specifi:nil block:^(BOOL success,NSString * number) {
        if (success) {
            [HUDManager showWarningWithText:LaguageControl(@"加入购物车成功")];
        }
    }];
}
/**
 *  分享
 *
 *  @param view      <#view description#>
 *  @param indexpath <#indexpath description#>
 */
- (void)payAttentGoodsShareWithCell:(NewPayAttentGoodsTableViewCell *)cell
{
    AttentGoodsModel * model = self.dataArray[cell.indexRow];
    _selectModel = model;
    ShareView * shareView = [[ShareView alloc] init];
    shareView.delegate = self;
    [shareView displayToWindow];
}

#pragma mark-- AttentionDelegate (店铺操作)
/*
 *  分享关注店铺
 */
- (void)attentionShopTableViewCellShare:(NewAttentionShopTableViewCell *)cell
{
    AttentGoodsModel * model = self.dataArray[cell.indexRow];
    _selectModel = model;
    ShareView * shareView = [[ShareView alloc] init];
    shareView.delegate = self;
    [shareView displayToWindow];
}

/*
 *  删除关注店铺
 */
- (void)attentionShopTableViewCellDelete:(NewAttentionShopTableViewCell *)cell
{
    AttentGoodsModel * model = self.dataArray[cell.indexRow];
    [self NetWorkWithString:model.attentsId];
}


- (void)shareEventWithView:(ShareView *)view type:(ShareTypes)type
{
    NSString *title = nil;
    NSString * shareUrl = nil;
    NSString * text = nil;
    NSString * imagePath = nil;
    NSString * urlString = KAppRootUrl;
    if([KAppRootUrl hasSuffix:@"/mobile"])
    {
        urlString = [urlString stringByReplacingOccurrencesOfString:@"/mobile" withString:@""];
    }
    if(_isShop)
    {
        shareUrl = [NSString stringWithFormat:@"%@/phoneh5_zh/a_ftobussShop.html?goods_store=%@",urlString,_selectModel.attentstoreID];

//        shareUrl = [NSString stringWithFormat:@"%@/h5/obussinessmanShop.html?goods_store=%@",urlString,_selectModel.attentstoreID];
        title = @"店铺分享";
        text = @"店铺分享";
        imagePath = _selectModel.attentstore_logo;
        
    }else
    {
         shareUrl = [NSString stringWithFormat:@"%@/phoneh5_zh/a_ftproduct.html?signType=1&goods_id=%@",urlString,_selectModel.attentgoodsID];

//        shareUrl = [NSString stringWithFormat:@"%@/h5/product.html?signType=1&goods_id=%@",urlString,_selectModel.attentgoodsID];
        imagePath = _selectModel.attentgoods_main_photo;
        if (type == ShareTypeQQTypeWechatSession) {
            /**微信好友*/
            title = @"我在吃货头条发现一样好东西想跟你分享~";
            text = _selectModel.attentgoods_name;

        }else{
            /**微信朋友圈*/
            title = _selectModel.attentgoods_name;
            text = @"";

        }
    }
    [AppAsiaShare shareType:type title:title text:text WithContentUrl:shareUrl imagePath:imagePath success:^{
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
