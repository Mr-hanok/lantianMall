//
//  BuyAndSendViewController.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/8.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BuyAndSendViewController.h"
#import "DSWaterFlowType.h"
#import "ClassGoodsTitleCollectionViewCell.h"
#import "BuyAndSendCollectionViewCell.h"
#import "BuyAndSendDetialViewController.h"
static NSString * itemIdentifier = @"BuyAndSendCollectionViewCell";
static NSString * titleIdentifier =@"ClassGoodsTitleCollectionViewCell";

@interface BuyAndSendViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *buyAndSendCollectionView;

@end

@implementation BuyAndSendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updataNewData:self.buyAndSendCollectionView];
    self.title = [LaguageControl languageWithString:@"买就送"];
    self.buyAndSendCollectionView.delegate = self;
    self.buyAndSendCollectionView.dataSource = self;
    [self.buyAndSendCollectionView registerNib:[UINib nibWithNibName:itemIdentifier bundle:nil] forCellWithReuseIdentifier:itemIdentifier];
    [self.buyAndSendCollectionView registerNib:[UINib nibWithNibName:titleIdentifier bundle:nil] forCellWithReuseIdentifier:titleIdentifier];

    DSWaterFlowType *flow = [[DSWaterFlowType alloc] init];
    flow.delegate = self;
    [self.buyAndSendCollectionView setCollectionViewLayout:flow animated:YES completion:^(BOOL finished) {
    }];
    [self.buyAndSendCollectionView reloadData];
    
    
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self beginRefresh];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --UICollectionViewDelegate && UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 50;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0 ) {
            ClassGoodsTitleCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:titleIdentifier forIndexPath:indexPath];
            cell.titleLabel.text =[LaguageControl languageWithString:@"买就送"];
            return cell;
        }
    
        BuyAndSendCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:itemIdentifier forIndexPath:indexPath];
        cell.goodNameLabel.text = @"手机";
        cell.priceLabel.text =KArc4andomPrices;
        return cell;

    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BuyAndSendDetialViewController * view = [[BuyAndSendDetialViewController alloc] init];
    [self.navigationController pushViewController:view animated:YES];

}
#pragma  mark --UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
        if (indexPath.row==0) {
            return CGSizeMake(collectionView.frame.size.width/2-8, 30);
        }
        return CGSizeMake(collectionView.frame.size.width/2-8, 300);

}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
