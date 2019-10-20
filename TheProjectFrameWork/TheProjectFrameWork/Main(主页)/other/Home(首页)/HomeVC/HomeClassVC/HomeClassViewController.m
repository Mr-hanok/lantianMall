//
//  HomeClassViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/6/30.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "HomeClassViewController.h"

#import "HomeClassCollectionViewCell.h"
#import "ClassGoodsViewController.h"
#import "HomeClassVCModel.h"
#import "SearchViewController.h"
#import "AdvertListModel.h"
#import "ShufflingManager.h"
static NSString * itmeIdentifier = @"HomeClassCollectionViewCell";
/** RecommendedHeadView */
/** HeadView */

@interface HomeClassViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *homeClassCollectionView;

@property(strong,nonatomic) NSMutableArray * dataArray;

@property(strong,nonatomic) NSMutableArray * adverlistArray;

@end

@implementation HomeClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    if (self.goodsID) {
        [self NetWork];
    }
    self.navigationTitleview.searchBar.delegate = self;
    [self updataNewData:self.homeClassCollectionView];
    // Do any additional setup after loading the view from its nib.
}
-(void)BaseLoadView{
    [self loadNavigabarTitleView];
    self.tabBarController.tabBar.hidden =NO;
    [self.homeClassCollectionView registerNib:[UINib nibWithNibName:itmeIdentifier bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:itmeIdentifier];
    //注册collectionViewCellHeadViewTypeImage
    //注册collectionViewCellHeadView
//    [self beginRefresh];
}
-(void)updateHeadView{
    [self NetWork];
}
-(void)updateFootView
{
    [self.footer endRefreshingWithNoMoreData];
}
#pragma mark --NetWork
-(void)NetWork
{
    NSDictionary * postdic = @{@"id":self.goodsID};
    [NetWork PostNetWorkWithUrl:@"/category_details" with:postdic successBlock:^( NSDictionary * dic)
     {
         [self endRefresh];
         self.dataArray = [HomeClassVCModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"category"]];
         self.adverlistArray = [AdvertListModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"advertList"]];
        
         [self.homeClassCollectionView reloadData];
     } errorBlock:^(NSString *error) {
         [self endRefresh];

    }];
    
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --UICollectionViewDelegate && UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeClassVCModel * model = self.dataArray[indexPath.row];
    HomeClassCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:itmeIdentifier forIndexPath:indexPath];
    cell.titleLabel.text = model.ClassGoodsName;
    cell.titleLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [cell.goodImageView sd_setImageWithURL:[NSURL URLWithString:model.icon_img] placeholderImage:[UIImage imageNamed:@"defaultImgForGoods"]];
    return cell;
}
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:@"UICollectionElementKindSectionHeader"])
    {

       
        
    }
    return nil;

    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
        return CGSizeMake(collectionView.frame.size.width, 250);;
}
#pragma  mark --UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(collectionView.frame.size.width/2-0.5,collectionView.frame.size.width/4);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeClassVCModel * model = self.dataArray[indexPath.row];
    ClassGoodsViewController * goods = [[ClassGoodsViewController alloc] init];
    goods.goodName = model.ClassGoodsName;
    goods.title = model.ClassGoodsName;
    goods.goodID = model.ClassGoodsID;
    self.tabBarController.tabBar.hidden =YES;
    [self.navigationController pushViewController:goods animated:YES];
}



-(void)ClassfiactionHeadClassBtnClickWithIndexpath:(NSIndexPath *)index{
    
    ClassGoodsViewController * goods = [[ClassGoodsViewController alloc] init];
    goods.goodName = self.goodsName;
    goods.title = self.goodsName;
    goods.goodID = self.goodsID;
    self.tabBarController.tabBar.hidden =YES;
    [self.navigationController pushViewController:goods animated:YES];

}


- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    SearchViewController * view = [SearchViewController new];
    [self.navigationController pushViewController:view animated:YES];
    return NO;
}// return NO to not become first responder



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
