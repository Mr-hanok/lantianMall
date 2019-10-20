//
//  StoreGoodsViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/10/9.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "StoreGoodsViewController.h"
#import "ClassGoodsVerticalCollectionViewCell.h"
#import "ClassGoodsModel.h"
#import "GoodsDetialViewController.h"
#import "PayAttentNetWork.h"

static NSString * ItemIdentifier =  @"ClassGoodsVerticalCollectionViewCell";

@interface StoreGoodsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,ClassGoodsVerticalCollectionViewCellDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *storeGoodsCollectionView;
/** 数据源 */
@property(strong,nonatomic) NSMutableArray <ClassGoodsModel *>* dataArray;

@end

@implementation StoreGoodsViewController
{
    NSInteger currentPage;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    currentPage = 1;
    [self updataNewData:self.storeGoodsCollectionView];
    [self.storeGoodsCollectionView registerNib:[UINib nibWithNibName:ItemIdentifier bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:ItemIdentifier];
    [self.header beginRefreshing];
}
- (void)updateHeadView
{
    NSDictionary * parame = @{@"class_id":_class_id,@"store_id":_store_id,@"currentPage":@(1),@"user_id":[UserAccountManager shareUserAccountManager].loginStatus?kUserId:@"",@"spec_id":@(0)};
    [NetWork PostNetWorkWithUrl:@"/seller/queryGoodsBySpec" with:parame successBlock:^(NSDictionary *dic) {
        [self endRefresh];
        currentPage ++;
        _dataArray = [ClassGoodsModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"result"]];
        [self.storeGoodsCollectionView showNoView:nil image:nil certer:CGPointZero isShow:!_dataArray.count];
        [self.storeGoodsCollectionView reloadData];
    } FailureBlock:^(NSString *msg) {
        [HUDManager showWarningWithError:msg];
        [self endRefresh];
    } errorBlock:^(id error) {
        [HUDManager showWarningWithError:error];
        [self endRefresh];
    }];
}
- (void)updateFootView
{
    NSDictionary * parame = @{@"class_id":_class_id,@"store_id":_store_id,@"spec_id":@(0),@"user_id":[UserAccountManager shareUserAccountManager].loginStatus?kUserId:@"",@"currentPage":@(currentPage)};
    [NetWork PostNetWorkWithUrl:@"/seller/queryGoodsBySpec" with:parame successBlock:^(NSDictionary *dic) {
        [self endRefresh];
        currentPage ++;
        [_dataArray addObjectsFromArray:[ClassGoodsModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"result"]]];
        [self.storeGoodsCollectionView showNoView:nil image:nil certer:CGPointZero isShow:!_dataArray.count];
        [self.storeGoodsCollectionView reloadData];
    } FailureBlock:^(NSString *msg) {
        [HUDManager showWarningWithError:msg];
        [self endRefresh];
    } errorBlock:^(id error) {
        [HUDManager showWarningWithError:error];
        [self endRefresh];
    }];
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
    ClassGoodsVerticalCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ItemIdentifier forIndexPath:indexPath];
        if (self.dataArray.count)
        {
            ClassGoodsModel * model =  self.dataArray[indexPath.row];
            [cell loadData:model withIndex:indexPath];
        }
    cell.delegate  = self;
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ClassGoodsModel * model;
    if (self.dataArray.count)
    {
        model = self.dataArray[indexPath.row];
    }
    GoodsDetialViewController *detialVC = [[GoodsDetialViewController alloc] init];
    detialVC.goodsModelID = model.classModelID;
    self.tabBarController.tabBar.hidden =YES;
    [self.navigationController pushViewController:detialVC animated:YES];
}

#pragma  mark --UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    return CGSizeMake(collectionView.frame.size.width / 2 - (kScaleWidth(10)), kScaleHeight(240));
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return (UIEdgeInsets){kScaleHeight(5),kScaleWidth(5),kScaleHeight(5),kScaleWidth(5)};
    
}
// 设置最小行间距，也就是前一行与后一行的中间最小间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

// 设置最小列间距，也就是左行与右一行的中间最小间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return kScaleWidth(5);
}

#pragma mark -- ClassGoodsVerticalCollectionViewCellDelegate
-(void)PayAttentButtonClickedbutton:(UIButton *)button index:(NSIndexPath *)indexPath
{
    ClassGoodsModel *   model = self.dataArray[indexPath.row];
    
    if (button.selected)
    {
        [PayAttentNetWork CancelPayAttentNetWorkisGoods:YES withtypeid:model.classModelID Success:^(BOOL success)
         {
             if (success)
             {
                 button.selected = NO;
             }
         }];
    }
    else
    {
        [PayAttentNetWork PayAttentNetWorkisGoods:YES withtypeid:model.classModelID Success:^(BOOL success)
         {
             if (success)
             {
                 button.selected = YES;
             }
         }];
    }
}



@end
