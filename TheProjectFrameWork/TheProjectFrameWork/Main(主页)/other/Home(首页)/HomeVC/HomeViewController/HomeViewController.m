//
//  HomeViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/6/3.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"
#import "HometableHeadView.h"
#import "SDCycleScrollView.h"
#import "NavigationBarView.h"
#import "HomeClassView.h"
#import "HomeTableViewHeadView.h"
#import "HomeClassViewController.h"
#import "ClassGoodsViewController.h"
#import "BuyAndSendViewController.h"
#import "HomeTableOtherHeadSectionView.h"
#import "MessageCenterViewController.h"
#import "SearchViewController.h"
#import "HomeSlideModel.h"
#import "HomeModel.h"
#import "HomeActivityModel.h"

#import "PromotionGoodsViewController.h"

#import "GoodsDetialViewController.h"
#import "AdvertListModel.h"
#import "ShufflingInternalWebViewController.h"
#import "ShufflingManager.h"
#import "AppDelegate+PrivateMethods.h"

#import "BaseWebViewController.h"
#import "AdPopView.h"

static NSString * cellIdentifier = @"HomeTableViewCell";

static NSString * OtherIdentifier = @"HomeTableOtherHeadSectionView";

static NSString * HeadIdentifier = @"HomeTableViewHeadView";

#define MainURL @"/index_mall"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,HometableHeadViewDelegate,HomeTableViewCellDelegate,HomeTableViewHeadSectionViewDelegate,UITextFieldDelegate>
/** 轮播 */
@property(strong,nonatomic) NSMutableArray * slidemodel;
/** 数据源 */
@property(strong,nonatomic) NSMutableArray * dataArray;
/** 首页表格 */
@property(strong,nonatomic)UITableView * homeTableView;
/** 活动推荐 */
@property (nonatomic , strong) NSArray <HomeActivityModel *> * activities;
/** 轮播图 */
@property(strong,nonatomic) NSMutableArray * advertListArray;

@property (nonatomic, strong) NSMutableDictionary *heigthDic;

@end

@implementation HomeViewController
{
    /** 头部视图 */
    HometableHeadView * headview;
    /** 弹出视图 */
    HomeClassView * homeclassview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [headview loadView];
    [self loadHeadView];
    self.dataArray = [NSMutableArray array];
    self.heigthDic = [NSMutableDictionary dictionary];
    self.slidemodel = [NSMutableArray array];
    self.advertListArray =[NSMutableArray array];
    self.homeTableView.backgroundColor = kBGColor;
    // Do any additional setup after loading the view.
    [self updateHeadView];
    
    [self loadNavigabarTitleView];
//    [self loadNavBarButton];
    WeakSelf(self)
    [self setCenterSearchViewWithDelegete:self];
    [self setRightBtnImage:[UIImage imageNamed:@"xinxi"] Size:CGSizeMake(20, 20) eventHandler:^(id sender) {
        [weakSelf messageButtonClicked:nil];
    }];
    [self setLeftBtnImage:[UserAccountManager shareUserAccountManager].logoImageUrl?: @"logo" eventHandler:^(id sender) {
        
    }];
    [self reloadView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(adPopViewNoti) name:@"homeAdPopNoti" object:nil];
    
}
- (void)adPopViewNoti{
    if (self.slidemodel.count ==0 || self.advertListArray.count==0) {
        [self reloadView];
    }
    AdvertListModel *admodel = [UserAccountManager shareUserAccountManager].homeAdPopModel;
    
    if (admodel &&( admodel.imgPath||admodel.img_url)) {
        AdPopView *adpopview = [[AdPopView alloc]initWithImageUrl:admodel.img_url?:admodel.imgPath showInView:self.view];
        WeakSelf(self)
        adpopview.didSelBlock = ^{
            
            if ([ShufflingManager ShufflingManagerPushType:admodel.ad_type withValue:admodel.ad_type_value?:admodel.ad_url])
            {
                NSString *tempValue = [admodel.ad_type_value isEqualToString:@""] ? admodel.ad_url:admodel.ad_type_value;
                
                [weakSelf.navigationController pushViewController:[ShufflingManager ShufflingManagerPushType:admodel.ad_type withValue:tempValue] animated:YES];
            }
        };
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:NO];
    [self.navigationController setNavigationBarHidden:NO];
    [super viewWillAppear:animated];
    
    

}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    SearchViewController * view = [SearchViewController new];
    view.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:view animated:YES];
    return NO;
}
/**刷新*/
-(void)updateHeadView
{
    AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    WeakSelf(self)
    [appDelegate NetWorkAdver:^(BOOL isSuccess) {
        if (isSuccess) {
            [weakSelf.homeTableView reloadData];
        }
    }];
    [self NetWork];

}

-(void)updateFootView{
    [self.homeTableView.mj_footer endRefreshingWithNoMoreData];
}
/**
 *  网络请求
 */
-(void)NetWork
{
    NSDictionary * dic =@{@"id":@"262162",
                          @"user_id":[UserAccountManager shareUserAccountManager].loginStatus?kUserId:@"",};
    [NetWork PostNetWorkWithUrl:MainURL with:dic successBlock:^(NSDictionary *dic)
    {
        [self endRefresh];
        if ([dic[@"status"] boolValue])
        {
            [dic ds_writefiletohomePath:MainURL];
            [self reloadView];
        }
        
    } errorBlock:^(NSString *error)
    {
        [self endRefresh];
        [self reloadView];
    }];
    
}
-(void)reloadView
{
    [self.dataArray removeAllObjects];
    NSDictionary * dic = [NSDictionary ds_readfiletohomePath:MainURL];
    if ([[dic allKeys]count])
    {
        self.dataArray = [HomeModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"index_floor"]];
        self.slidemodel = (NSMutableArray *)[UserAccountManager shareUserAccountManager].homeSliderModelArray;
        self.activities = [HomeActivityModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"index_activity"]];
        self.advertListArray = (NSMutableArray *)[UserAccountManager shareUserAccountManager].homeMarkSliderModelArray;
        [self loadHeadView];

    }
}
/**
 *  设置navigationBar
 */
- (void)loadNavBarButton{
    if (!self.navigationBarView)
    {
        self.navigationBarView = [NavigationBarView loadView];
    }
    self.navigationBarView .frame = CGRectMake(0, 0, 80, 32);
    self.navigationTitleview.searchBar.placeholder = LaguageControl(@"搜索");
    [self.navigationBarView .leftButton addTarget:self action:@selector(PopView) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationBarView.leftButton setImage:[UIImage imageNamed:@"fenlei"] forState:UIControlStateNormal];
    self.navigationBarView.leftButton.hidden = YES;
     self.navigationBarView .backgroundColor = [UIColor colorWithWhite:0.1 alpha:0];
    
    
   
    
    if (kIsChiHuoApp) {
        UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:LaguageControl(@"返回") style:UIBarButtonItemStyleDone target:self action:@selector(rightbtnclick)];
        self.navigationItem.rightBarButtonItem = right;
    }
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.navigationBarView];
}

-(void)rightbtnclick{
    [self.tabBarController dismissViewControllerAnimated:YES completion:nil];
}
-(void)PopView
{
    if (!homeclassview) {
        homeclassview = [HomeClassView CreateView];
        homeclassview.ViewController = self;
    }
    if (homeclassview.isShow)
    {
        [homeclassview viewDissMissFromWindow];
    }
    else
    {
        [homeclassview showView];
    }
}

/**
 *  消息按钮点击
 *
 *  @param sender <#sender description#>
 */
- (void)messageButtonClicked:(UIButton *)sender
{
    
    if (![UserAccountManager shareUserAccountManager].loginStatus) {
        UIStoryboard * loginStoryBoard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
        [self presentViewController:loginStoryBoard.instantiateInitialViewController animated:YES completion:^{
        }];
        return;
    }
    
    
    if (homeclassview.isShow)
    {
        [homeclassview viewDissMissFromWindow];
    }
    MessageCenterViewController * view = [[MessageCenterViewController alloc] init];
    view.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:view animated:YES];
}
/**
 *  加载头部视图
 */
-(void)loadHeadView
{
    if (!self.homeTableView)
    {
        self.homeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenBoundWidth, KScreenBoundHeight-kNavigaTionBarHeight-KTabBarHeight) style:UITableViewStyleGrouped];
        self.homeTableView.delegate = self;
        self.homeTableView.dataSource = self;
        self.homeTableView.sectionFooterHeight = 0;
        self.homeTableView.estimatedRowHeight = 0;
        self.homeTableView.estimatedSectionHeaderHeight = 0;
        self.homeTableView.estimatedSectionFooterHeight = 0;

        self.homeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        headview = [HometableHeadView headViewLoadViewWithframe:CGRectMake(0, 0, KScreenBoundWidth, 300)];
        self.homeTableView.showsVerticalScrollIndicator = self.homeTableView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:self.homeTableView];
        [self.homeTableView setTableHeaderView:headview];
    }
       NSMutableArray * Imagearrays = [NSMutableArray array];
    
    for (AdvertListModel * modes in self.slidemodel)
    {
        if (modes.imgPath)
        {
            [Imagearrays addObject:modes.imgPath];
        }
    }
    headview.imageDataArray = Imagearrays;
    if (headview.datacollectionArray.count) {
        [headview.datacollectionArray removeAllObjects];
    }
    [headview.datacollectionArray addObjectsFromArray:self.activities];
    headview.delegate = self;
    [headview loadView];
    [self updataNewData:self.homeTableView];
    [self.footer endRefreshingWithNoMoreData];
    [self.homeTableView reloadData];

}


#pragma mark --UITableViewDelegate&&UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeModel * model = self.dataArray[indexPath.section];
    HomeFloorModel * models;
    if (model.childs.count)
    {
        models = model.childs[[model.section integerValue]];
    }
    HomeTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:cellIdentifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellIdentifier];
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    cell.detialCollectionView.backgroundColor = KSepLineColor;
    cell.delegate = self;
    [cell loadCollectionViewWith:models.gf_list_goods withSection:indexPath.section];
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.heigthDic objectForKey:@(indexPath.section)]) {
        return [[self.heigthDic objectForKey:@(indexPath.section)] floatValue];
    }else{
        if (indexPath.section == 0) {
            [self.heigthDic setObject:@((KScreenBoundWidth-4)/3.0f+20+2) forKey:@(indexPath.section)];
            return (KScreenBoundWidth-4)/3.0f+20+2;
        }
        HomeModel * model = self.dataArray[indexPath.section];
        HomeFloorModel * models;
        if (model.childs.count)
        {
            models = model.childs[[model.section integerValue]];
        }
        double temheight = ceil(models.gf_list_goods.count/2.0f)*((KScreenBoundWidth-4)/2.0f+70+1.0);
        [self.heigthDic setObject:@(temheight+1.0) forKey:@(indexPath.section)];
        return temheight+1.0;
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HomeModel * models =self.dataArray[section];
    if (section)
    {
        // 区头标题
        if (models.childs.count) {
            HomeTableOtherHeadSectionView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:OtherIdentifier];
            if (!view) {
                [tableView registerNib:[UINib nibWithNibName:OtherIdentifier bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:OtherIdentifier];
                view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:OtherIdentifier];
            }
            //        view.logoImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ldceng",(long)section]];
            view.delegate = self;
            view.selectsection =[models.section integerValue];
            view.homeTableOtherHeadSectionView.backgroundColor = kBGColor;
            [view loadViewWith:models WithSection:section];
            return view;
        }else{
            return nil;
        }
        
    }
    else{
        // 大厅 轮播图
//        HomeTableViewHeadView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:HeadIdentifier];
//        if (!view) {
//            [tableView registerNib:[UINib nibWithNibName:HeadIdentifier bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:HeadIdentifier];
//            view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeadIdentifier];
//        }
////        view.backGroundImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ldceng",(long)section]];
////        view.titleLabel.text =[NSString stringWithFormat:@"%ld",(long)section];
////        view.contentDetialLabel.text =models.gf_name;
//
//        view.delegate = self;
//        NSArray * array = [self.advertListArray valueForKeyPath:@"img_url"];
//        [view loadViewWith:array WithSection:section];
//        return view;
        return nil;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        // 大厅 轮播图
        HomeTableViewHeadView * view  =[tableView dequeueReusableHeaderFooterViewWithIdentifier:HeadIdentifier];
        if (!view) {
            [tableView registerNib:[UINib nibWithNibName:HeadIdentifier bundle:[NSBundle mainBundle]] forHeaderFooterViewReuseIdentifier:HeadIdentifier];
            view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeadIdentifier];
        }
        //        view.backGroundImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ldceng",(long)section]];
        //        view.titleLabel.text =[NSString stringWithFormat:@"%ld",(long)section];
        //        view.contentDetialLabel.text =models.gf_name;
        
        view.delegate = self;
        NSArray * array = [self.advertListArray valueForKeyPath:@"img_url"];
        [view loadViewWith:array WithSection:section];
        return view;
    }else{
        return  nil;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section)
    {
        HomeModel * model = self.dataArray[section];
        if (model.childs.count) {
            return fixHegit(35);
        }else{
            return CGFLOAT_MIN;
        }
    }
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return fixHegit(150-30);

    }else{
        return CGFLOAT_MIN;
    }
}
#pragma mark - HometableHeadViewDelegate
/**
 *  <#Description#>
 *
 *  @param view  <#view description#>
 *  @param index 点击具体某个
 */
-(void)HometableHeadView:(SDCycleScrollView*)view didSelectItemAtIndex:(NSInteger)index
{
    AdvertListModel * modes  = self.slidemodel[index];
    
    if ([ShufflingManager ShufflingManagerPushType:modes.ad_type withValue:modes.ad_type_value?:modes.ad_url])
    {
        NSString *tempValue = [modes.ad_type_value isEqualToString:@""] ? modes.ad_url:modes.ad_type_value;

        [self.navigationController pushViewController:[ShufflingManager ShufflingManagerPushType:modes.ad_type withValue:tempValue] animated:YES];
    }
}

/**
 *  <#Description#>
 *
 *  @param index 下面内容点击
 */
-(void)HometableHeadViewCollectionViewdidSelected:(NSInteger)index
{
//    self.tabBarController.tabBar.hidden = YES;
//    PromotionGoodsViewController * promotionGoods = [[PromotionGoodsViewController alloc] init];
//    promotionGoods.promotionID = model.activityID;
//    promotionGoods.hidesBottomBarWhenPushed = YES;
//    promotionGoods.title = model.title;
//    [self.navigationController pushViewController:promotionGoods animated:YES];
    
    
    HomeActivityModel * model = self.activities[index];
    BaseWebViewController *vc = [[BaseWebViewController alloc]init];
    vc.isHaveNavi = NO;
    vc.hidesBottomBarWhenPushed = YES;
    NSString *temprooturl = [[KAppRootUrl componentsSeparatedByString:@"/mobile"] firstObject];
    NSString *tempactivitystr = nil;
    if(model.activityType == 4){
        /**拼多多*/
        tempactivitystr = @"/phoneh5_zh/collage.html?acId=";
    }else if (model.activityType == 5){
        /**秒杀*/
        tempactivitystr = @"/phoneh5_zh/SecKil.html?acId=";
    }else if(model.activityType == 3||model.activityType == 2){
        /**满减*/
        tempactivitystr = @"/phoneh5_zh/activity.html?act_id=";
    }else{
        /**webview*/
        ShufflingInternalWebViewController *webvc = [[ShufflingInternalWebViewController alloc]init];
        webvc.hidesBottomBarWhenPushed = YES;
        webvc.requestURl = model.nav_url?:@"";
        [self.navigationController pushViewController:webvc animated:YES
         ];
        return;
    }
    NSString *weburl = [NSString stringWithFormat:@"%@%@%@",temprooturl,tempactivitystr,model.activityID?:@"176"];
    vc.webUrl = weburl;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark --HomeTableViewHeadSectionViewDelegate
-(void)HomeTableViewHeadSectionViewDidSelectedWith:(NSIndexPath *)indexpath
{
    if (indexpath.section==0)
    {
        AdvertListModel * model = self.advertListArray[indexpath.row];
        if ([ShufflingManager ShufflingManagerPushType:model.ad_type withValue:model.ad_type_value])
        {
            NSString *tempValue = [model.ad_type_value isEqualToString:@""] ? model.ad_url:model.ad_type_value;
            [self.navigationController pushViewController:[ShufflingManager ShufflingManagerPushType:model.ad_type withValue:tempValue] animated:YES];
        }
    }
    else
    {
        HomeModel * model = self.dataArray[indexpath.section];
        model.section = [NSString stringWithFormat:@"%ld",(long)indexpath.row];
//        NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:indexpath.section];
//        [self.homeTableView reloadRowsAtIndexPaths:@[ip] withRowAnimation:UITableViewRowAnimationNone];
//        [self.homeTableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
        if (indexpath.section != 0) {
            HomeFloorModel * models;
            if (model.childs.count)
            {
                models = model.childs[[model.section integerValue]];
            }
            double temheight = ceil(models.gf_list_goods.count/2.0f)*((KScreenBoundWidth-4)/2.0f+70+1.0);
            [self.heigthDic setObject:@(temheight+1.0) forKey:@(indexpath.section)];
        }
        if (model.childs.count) {
            [self.homeTableView reloadSections:[NSIndexSet indexSetWithIndex:indexpath.section] withRowAnimation:UITableViewRowAnimationNone];
            //        [self.homeTableView reloadData];
        }
    }

}
#pragma mark --HomeTableViewCellDelegate 

-(void)HomeTableViewCellDidSelected:(NSIndexPath *)indexpath withmodel:(id)model
{
    HomeModel * models = self.dataArray[indexpath.section];
    HomeFloorModel * detialmodel = models.childs[[models.section integerValue]];
    HomeGoodsDetial * textModel = detialmodel.gf_list_goods[indexpath.row];
    GoodsDetialViewController * view = [GoodsDetialViewController new];
    self.tabBarController.tabBar.hidden = YES;
    view.hidesBottomBarWhenPushed = YES;
    view.goodsModelID = textModel.goodsId;
    [self.navigationController pushViewController:view animated:YES];
}
#pragma mark --UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [homeclassview viewDissMissFromWindow];
    SearchViewController * view = [SearchViewController new];
    view.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:view animated:YES];
    return NO;
}


@end
