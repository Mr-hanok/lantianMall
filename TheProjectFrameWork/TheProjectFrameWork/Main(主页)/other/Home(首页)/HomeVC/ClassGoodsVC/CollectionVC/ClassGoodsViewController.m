//
//  ClassGoodsViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/6/30.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ClassGoodsViewController.h"
#import "ClassGoodsCollectionViewCell.h"
#import "ClassGoodsVerticalCollectionViewCell.h"
#import "DSWaterFlowType.h"
#import "ClassGoodsTitleCollectionViewCell.h"
#import "GoodsDetialViewController.h"
#import "ClassGoodScreeningViewController.h"
#import "ClassGoodsModel.h"
#import "PayAttentNetWork.h"
#import "ClassGoodsSortViewController.h"
#import "ShopGoodsClassViewController.h"
#import "StoreGoodsViewController.h"


static NSString * cellIdentifier = @"ClassGoodsCollectionViewCell";

static NSString * TitleIdentifier = @"ClassGoodsTitleCollectionViewCell";

static NSString * ItemIdentifier= @"ClassGoodsVerticalCollectionViewCell";

@interface ClassGoodsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,UISearchBarDelegate,ClassGoodsCollectionViewCellDelegate,ClassGoodsVerticalCollectionViewCellDelegate>

/** 排序 */
@property (weak, nonatomic) IBOutlet UIButton *sortButton;
/** 筛选 */
@property (weak, nonatomic) IBOutlet UIButton *screenButton;
/** 滚动到顶部 */
@property (weak, nonatomic) IBOutlet UIButton *scrollerToTopButton;
/** 分类collectionView */
@property (weak, nonatomic) IBOutlet UICollectionView *classGoodsCollectionView;

@property (weak, nonatomic) IBOutlet UIButton *changeLayoutButton;

@property(strong,nonatomic) NSMutableArray * dataArray;

@property(assign,nonatomic) NSInteger begin;

@property(strong,nonatomic) NSString * screenStrings;

@property(strong,nonatomic) NSString * screenOthers;



@end

@implementation ClassGoodsViewController
{
    BOOL isWaterFlaw;
    BOOL isHeaderReload;
    BOOL isFooterReload;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.sortButton setTitle:LaguageControl(@"排序") forState:UIControlStateNormal];

    if (!self.goodID){
        if (self.isSTore) {
            self.goodID = @"1";
        }
        else
        {
           
            self.goodID =@"5";
        }
    }
    self.dataArray = [NSMutableArray array];
    self.begin = 1;
    [self updataNewData:self.classGoodsCollectionView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.screenButton setTitle:LaguageControl(@"筛选") forState:UIControlStateNormal];
    if (self.isSTore)
    {
         [self.screenButton setTitle:LaguageControl(@"分类") forState:UIControlStateNormal];
    }
    self.scrollerToTopButton.alpha = 0;
    isWaterFlaw = NO;
    [self.classGoodsCollectionView registerNib:[UINib nibWithNibName:cellIdentifier bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:cellIdentifier];
    [self.classGoodsCollectionView registerNib:[UINib nibWithNibName:ItemIdentifier bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:ItemIdentifier];
    [self.classGoodsCollectionView registerNib:[UINib nibWithNibName:TitleIdentifier bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:TitleIdentifier];
    if (self.goodID)
    {
        [self ScrrenNetWorkWith];
    }
    self.navigationTitleview.searchBar.delegate = self;

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationTitleview.rightButton.frame = CGRectZero;
    self.tabBarController.tabBar.hidden = YES;
}
-(void)ReloadData:(void (^)(BOOL success))block;
{
    
    UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc] init];
    flow.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5 );
    [self.classGoodsCollectionView setCollectionViewLayout:flow animated:NO completion:^(BOOL finished)
     {
         block(finished);
         [self.classGoodsCollectionView reloadData];
         
     }];
    
    return;
    
//    if (!isWaterFlaw)
//    {
//        if (self.isSTore)
//        {
//            block(YES);
//            [self.classGoodsCollectionView reloadData];
//        }
//        else{
//            
//            block(YES);
//            [self.classGoodsCollectionView reloadData];
////            DSWaterFlowType *flow = [[DSWaterFlowType alloc] init];
////            flow.delegate = self;
////            [self.classGoodsCollectionView setCollectionViewLayout:flow animated:NO completion:^(BOOL finished)
////             {
////                 block(finished);
////                 [self.classGoodsCollectionView reloadData];
////
////             }];
//        }
//
//    }
//    else{
//        UICollectionViewFlowLayout * flow = [[UICollectionViewFlowLayout alloc] init];
//        flow.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5 );
//        [self.classGoodsCollectionView setCollectionViewLayout:flow animated:NO completion:^(BOOL finished)
//         {
//             block(finished);
//             [self.classGoodsCollectionView reloadData];
//
//         }];
//    }
//   
}
/** 上拉刷新 */
-(void)updateHeadView
{
    self.EndRefresh = NO;
    self.begin=1;
    [self.dataArray removeAllObjects];
    [self ScrrenNetWorkWith];
}
/** 下拉加载 */
-(void)updateFootView{
    
    if (self.EndRefresh)
    {
        [self.footer endRefreshingWithNoMoreData];
    }
    else
    {
        self.begin++;
        [self ScrrenNetWorkWith];
    }

}
/**
 *  筛选
 *
 *  @param dic <#dic description#>
 */
-(void)ScrrenNetWorkWith;
{
    NSString * stroString = @"1";
    //如果是店铺的话 为2 商品为 1;
    if (self.isSTore)
    {
        stroString = @"2";
    }
    [HUDManager showLoadingHUDView:self.view];
    NSString * begin ;
    begin = [NSString stringWithFormat:@"%ld",(long)self.begin];
    if (!self.sortSting)
    {
        self.sortSting = @"3";
    }
    if (!self.goodID)
    {
        self.goodID = @"1";
    }
    NSString * string =[UserAccountManager shareUserAccountManager].loginStatus?kUserId:@"";

    NSDictionary * searchdic =@{@"begin":begin,
                                @"max":@"10",
                                @"sginType":stroString,
                                @"orderBy":self.sortSting,
                                @"gc_id":self.goodID,
                                @"userId":string,
                                };
    if (self.screenStrings&&self.screenOthers) {
        searchdic =@{@"begin":begin,
                     @"max":@"10",
                     @"sginType":stroString,
                     @"orderBy":self.sortSting,
                     @"gc_id":self.goodID,
                     @"gpids":self.screenStrings,
                     @"gbids":self.screenOthers,
                     @"userId":string,
                     };
    }
    else if (self.screenStrings)
    {
        searchdic =@{@"begin":begin,
                     @"max":@"10",
                     @"sginType":stroString,
                     @"orderBy":self.sortSting,
                     @"gc_id":self.goodID,
                     @"gpids":self.screenStrings,
                     @"userId":string,
                     };
    }
    else if (self.screenOthers)
    {
        searchdic =@{@"begin":begin,
                    @"max":@"10",
                     @"sginType":stroString,
                    @"orderBy":self.sortSting,
                    @"gc_id":self.goodID,
                    @"gbids":self.screenOthers,
                     @"userId":string,
                    };
    }
    __weak ClassGoodsViewController * weakself = self;

    [NetWork PostNetWorkWithUrl:@"/goods/listGoodsByParams" with:searchdic successBlock:^( NSDictionary * dic)
     {
         [HUDManager hideHUDView];
       
         if (self.begin==1)
         {
             [weakself.dataArray removeAllObjects];
         }
         [weakself endRefresh];
         if ([dic[@"status"] boolValue])
         {
             NSArray * array =[ClassGoodsModel mj_objectArrayWithKeyValuesArray:dic[@"data"]];
             [weakself.dataArray addObjectsFromArray:array];
             [weakself.classGoodsCollectionView reloadData];
             if (array.count<10)
             {
                 self.EndRefresh = YES;
                 
             }
             else
             {
                 self.EndRefresh = NO;

             }
         }
    } errorBlock:^(NSString *error) {
        [HUDManager hideHUDView];
        [weakself endRefresh];
//        [HUDManager showWarningWithText:@"请检查网络"];

    }];
}

/**
 *  修改排版布局
 */
- (IBAction)changeStyle:(UIButton *)sender
{
    [self ReloadData:^(BOOL success)
     {
         isWaterFlaw = !isWaterFlaw;
         sender.selected = isWaterFlaw;
        [self.classGoodsCollectionView setContentOffset:CGPointMake(0, 0)];
    }];
}
/**
 *  排序按钮
 *
 *  @param sender <#sender description#>
 */
- (IBAction)sortButtonClicked:(UIButton *)sender
{

    CATransition *transition = [CATransition animation];
    transition.duration = 1.0f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = @"oglFlip";
    transition.subtype = kCATransitionFromRight;
    transition.delegate = self;
    self.tabBarController.tabBar.hidden = YES;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    __weak ClassGoodsViewController * weakself = self;
    
    ClassGoodsSortViewController * sortVC = [ClassGoodsSortViewController new];
    [sortVC GetSelected:^(NSString *result) {
        weakself.sortSting = result;
        weakself.begin =1;
        [weakself ScrrenNetWorkWith];
    }];
    sortVC.title = LaguageControl(@"排序");
    [self.navigationController pushViewController:sortVC animated:YES];
}
/**
 *  筛选按钮
 *
 *  @param sender <#sender description#>
 */
- (IBAction)screenButtonClicked:(UIButton *)sender
{
    
    CATransition *transition = [CATransition animation];
    transition.duration = 1.0f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = @"oglFlip";
    transition.subtype = kCATransitionFromRight;
    transition.delegate = self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    self.tabBarController.tabBar.hidden = YES;
    if (self.isSTore)
    {
        // 分类
        __weak typeof(self) weakSelf = self;
        ShopGoodsClassViewController * view = [[ShopGoodsClassViewController alloc] initWithClickClass:^(NSString * class_id , NSString * className) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        StoreGoodsViewController * controller = [[StoreGoodsViewController alloc] init];
        controller.store_id = _goodID;
        controller.class_id = class_id;
        controller.title = className;
        controller.hidesBottomBarWhenPushed = YES;
        [strongSelf.navigationController pushViewController:controller animated:YES];
        }];
        view.store_id = self.goodID;
        view.hidesBottomBarWhenPushed = YES;
        view.FatherVC = self;
        [self.navigationController pushViewController:view animated:YES];    }
    else
    {// 筛选
       
        __weak ClassGoodsViewController * weakSelf = self;
        ClassGoodScreeningViewController * screenVC = [[ClassGoodScreeningViewController alloc] init];
        screenVC.modelsID = self.goodID;
        [screenVC GetSelected:^(NSString *screenString, NSString *screeenOther) {
            weakSelf.screenStrings = screenString;
            weakSelf.screenOthers  = screeenOther;
            weakSelf.begin = 1;
            [weakSelf ScrrenNetWorkWith];
        }];
        screenVC.title = LaguageControl(@"筛选");
        screenVC.FatherVC = self;
        [self.navigationController pushViewController:screenVC animated:YES];
    }
}



- (IBAction)scrollerToTop:(UIButton *)sender
{
    [self.classGoodsCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];

}
#pragma mark --UICollectionViewDelegate && UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.dataArray.count;

}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (isWaterFlaw)
    {
//        if (indexPath.row==0&&!self.isSTore)
//        {
//            ClassGoodsTitleCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:TitleIdentifier forIndexPath:indexPath];
//            cell.titleLabel.text =self.goodName;
//            return cell;
//        }
        ClassGoodsVerticalCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ItemIdentifier forIndexPath:indexPath];
        if (self.dataArray.count)
        {
            if (self.isSTore) {
                ClassGoodsModel * model =  self.dataArray[indexPath.row];
                [cell loadData:model withIndex:indexPath];

            }
            else
            {
                ClassGoodsModel * model =  self.dataArray[indexPath.row];
                [cell loadData:model withIndex:indexPath];
            }

        }
        cell.delegate  = self;
        return cell;
    }
    else
    {
        ClassGoodsCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        if (self.dataArray.count){
            ClassGoodsModel * model =  self.dataArray[indexPath.row];
            [cell loadData:model withIndex:indexPath];
        }
        cell.delegate = self;
        return cell;
    }

}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ClassGoodsModel * model;
    if (indexPath.section == 0 && indexPath.row == 0 && isWaterFlaw ) {
        return;
    }
    if (self.dataArray.count) {
        if (isWaterFlaw&&!self.isSTore) {
            model = self.dataArray[indexPath.row-1];
        }
        else
        {
            model = self.dataArray[indexPath.row];
        }
    }
    GoodsDetialViewController *detialVC = [[GoodsDetialViewController alloc] init];
     detialVC.goodsModelID = model.classModelID;
    self.tabBarController.tabBar.hidden =YES;
    [self.navigationController pushViewController:detialVC animated:YES];
}

#pragma  mark --UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (isWaterFlaw) {
        
        if (indexPath.row==0&&!self.isSTore)
        {
            return CGSizeMake(collectionView.frame.size.width-16, 1);
        }
        return CGSizeMake(collectionView.frame.size.width/2-8, 260);
    }
    else{
        return CGSizeMake(collectionView.frame.size.width-5, 150);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

#pragma  mark --
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;{
    if (scrollView.contentOffset.y<200) {
        self.scrollerToTopButton.alpha = 0;
    }
    else{
        self.scrollerToTopButton.alpha = 1;
    }
}

#pragma mark -- UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}
#pragma mark -- ClassGoodsVerticalCollectionViewCellDelegate
-(void)PayAttentButtonClickedbutton:(UIButton *)button index:(NSIndexPath *)indexPath
{   
    ClassGoodsModel * model;
    if (self.dataArray.count)
    {
        if (isWaterFlaw&&!self.isSTore)
        {
            model = self.dataArray[indexPath.row-1];
        }
        else
        {
            model = self.dataArray[indexPath.row];
        }
    }
    if (button.selected)
    {
        [PayAttentNetWork CancelPayAttentNetWorkisGoods:YES withtypeid:model.classModelID Success:^(BOOL success)
         {
             if (success) {
                 model.favorite=@"0";
                 button.selected = NO;
             }
         }];
    }
    else
    {
        [PayAttentNetWork PayAttentNetWorkisGoods:YES withtypeid:model.classModelID Success:^(BOOL success)
         {
             if (success) {
                 model.favorite=@"1";
                 button.selected = YES;
             }
         }];
    }

}
#pragma mark -- ClassGoodsCollectionViewCellDelegate
-(void)ClassGoodsPayAttentButtonClickedbutton:(UIButton *)button index:(NSIndexPath *)indexPath
{
    ClassGoodsModel * model;
    if (self.dataArray.count)
    {
        if (isWaterFlaw&&!self.isSTore) {
            model = self.dataArray[indexPath.row-1];
        }
        else
        {
            model = self.dataArray[indexPath.row];
        }
    }

    if (button.selected)
    {
        [PayAttentNetWork CancelPayAttentNetWorkisGoods:YES withtypeid:model.classModelID Success:^(BOOL success)
         {
             if (success) {
                 model.favorite=@"0";
                 button.selected = NO;
             }
         }];
    }
    else
    {
        [PayAttentNetWork PayAttentNetWorkisGoods:YES withtypeid:model.classModelID Success:^(BOOL success)
         {
             if (success) {
                 model.favorite=@"1";
                 button.selected = YES;
             }
         }];
    }
}



@end
