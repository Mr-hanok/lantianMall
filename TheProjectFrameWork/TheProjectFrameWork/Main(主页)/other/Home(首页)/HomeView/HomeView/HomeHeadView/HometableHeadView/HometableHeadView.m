//
//  HometableHeadView.m
//  TheProjectFrameWork
//
//  Created by maple on 16/6/4.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "HometableHeadView.h"
#import "SDCycleScrollView.h"
#import "HomeHeadViewCollectionViewCell.h"
#import "HomeActivityModel.h"
static NSString *itmeIdentifier = @"HomeHeadViewCollectionViewCell";
@interface HometableHeadView ()<SDCycleScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@end
@implementation HometableHeadView

+ (HometableHeadView*)headViewLoadViewWithframe:(CGRect)frame
{
    HometableHeadView * view = [[[NSBundle mainBundle] loadNibNamed:@"HometableHeadView" owner:self options:nil] firstObject];
    //注册collectionViewCell
    [view.headCollectionView registerNib:[UINib nibWithNibName:itmeIdentifier bundle:nil] forCellWithReuseIdentifier:itmeIdentifier];
    view.headCollectionView.delegate = view;
    view.headCollectionView.dataSource = view;
    view.frame = frame;
    view.datacollectionArray = [NSMutableArray array];
    [view loadView];
    return view;
  
}
- (void)loadView{

    // 网络加载 --- 创建不带标题的图片轮播器
    if (!self.ScrollerView)
    {
        self.ScrollerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-100) imageURLStringsGroup:nil];
        self.ScrollerView.backgroundColor = [UIColor whiteColor];
        self.ScrollerView.infiniteLoop = YES;
        self.ScrollerView.delegate = self;
        self.ScrollerView.placeholderImage = [UIImage imageNamed:@"defaultImgbanner"];
        self.ScrollerView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        self.ScrollerView.autoScrollTimeInterval = 5.0; // 轮播时间间隔，默认1.0秒，可自定义
    }
    self.ScrollerView.imageURLStringsGroup = self.imageDataArray;
    [self.imagePlayerScrollerView addSubview:self.ScrollerView];
    [self.headCollectionView reloadData];
}
#pragma mark --UICollectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.datacollectionArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeActivityModel * model;
    if (indexPath.row<self.datacollectionArray.count&&self.datacollectionArray.count)
    {
         model = self.datacollectionArray[indexPath.row];
    }
    else
    {
        
    }
    HomeHeadViewCollectionViewCell * item = [collectionView dequeueReusableCellWithReuseIdentifier:itmeIdentifier forIndexPath:indexPath];
    [item.collectionImageView sd_setImageWithURL:[NSURL URLWithString:model.imgPath] placeholderImage:[UIImage imageNamed:@""]];
    item.collectionDetialLabel.textColor = kTextDeepDarkColor;
    item.collectionImageView.layer.masksToBounds = YES;
    item.collectionImageView.layer.cornerRadius = 24;
//    item.collectionImageView.layer.borderWidth=1;
//    item.collectionImageView.layer.borderColor=[UIColor purpleColor].CGColor;
    item.collectionDetialLabel.text =[LaguageControl languageWithString:model.title];
    return item;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.datacollectionArray.count)
    {
        return CGSizeMake((collectionView.frame.size.width-10)/MIN(self.datacollectionArray.count, 5), collectionView.frame.size.height);
    }
    return CGSizeMake((collectionView.frame.size.width-10)/5, collectionView.frame.size.height);
}
#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(HometableHeadView:didSelectItemAtIndex:)]) {
        [self.delegate HometableHeadView:cycleScrollView didSelectItemAtIndex:index];
    }
}

- (void)indexOnPageControl:(NSInteger)index{
    if ([self.delegate respondsToSelector:@selector(HometableHeadViewindexOnPageControl:)]) {
        [self.delegate HometableHeadViewindexOnPageControl:index];
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(HometableHeadViewCollectionViewdidSelected:)]) {
        [self.delegate HometableHeadViewCollectionViewdidSelected:indexPath.row];
    }
}


@end
