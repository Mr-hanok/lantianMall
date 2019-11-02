//
//  IntegralMallHeadView.m
//  TheProjectFrameWork
//
//  Created by yuntai on 16/7/26.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "IntegralMallHeadView.h"

@implementation IntegralMallHeadView

- (void)awakeFromNib {
    // Initialization code
}

-(void)loadViewWith:(NSArray*)array WithSection:(NSInteger)section{
    
    // 网络加载 --- 创建不带标题的图片轮播器
    if (!self.ScrollerView) {
        self.ScrollerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) imageURLStringsGroup:nil];
        self.ScrollerView.infiniteLoop = YES;
        self.ScrollerView.delegate = self;
        self.ScrollerView.placeholderImage=[UIImage imageNamed:kDefaultBannerImage];
        self.ScrollerView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        self.ScrollerView.autoScrollTimeInterval = 5.0; // 轮播时间间隔，默认1.0秒，可自定义
    }
    self.ScrollerView.imageURLStringsGroup = array;
    [self.bannerView addSubview:self.ScrollerView];

}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(integralMallHeadView:indexNum:)]) {
        [self.delegate integralMallHeadView:self indexNum:index];
    }
}

- (void)indexOnPageControl:(NSInteger)index{
//    if ([self.delegate respondsToSelector:@selector(HometableHeadViewindexOnPageControl:)]) {
//        [self.delegate HometableHeadViewindexOnPageControl:index];
//    }
}
//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    if ([self.delegate respondsToSelector:@selector(integralMallHeadView:indexNum:)]) {
//        [self.delegate integralMallHeadView:self indexNum:indexPath.row];
//    }}
//
//
@end
