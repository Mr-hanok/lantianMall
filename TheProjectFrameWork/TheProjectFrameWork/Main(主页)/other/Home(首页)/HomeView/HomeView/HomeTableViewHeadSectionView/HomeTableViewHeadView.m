//
//  HomeTableViewHeadView.m
//  TheProjectFrameWork
//
//  Created by maple on 16/6/28.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "HomeTableViewHeadView.h"

#import "SDCycleScrollView.h"

@interface HomeTableViewHeadView ()<SDCycleScrollViewDelegate>

@end

@implementation HomeTableViewHeadView

-(void)loadViewWith:(NSArray*)array WithSection:(NSInteger)section
{
    self.section = section;
    if (!self.dataArray)
    {
        self.dataArray =[NSMutableArray array];
    }

    self.dataArray = [NSMutableArray array];
    if (array.count) {
        [self.dataArray removeAllObjects];
    }
    [self.dataArray addObjectsFromArray:array];
    // 网络加载 --- 创建不带标题的图片轮播器
//    self.viewHeight.constant = fixHegit(30);
    if (!self.ScrollView) {
        self.ScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, KScreenBoundWidth,fixHegit(120)) imageURLStringsGroup:nil];
        self.ScrollView.backgroundColor = [UIColor whiteColor];
        self.ScrollView.infiniteLoop = YES;
        self.ScrollView.delegate = self;
        self.ScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        self.ScrollView.placeholderImage = [UIImage imageNamed:@"defaultImgbanner"];
        self.ScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        self.ScrollView.autoScrollTimeInterval = 5.0; // 轮播时间间隔，默认1.0秒，可自定义
    }
    self.ScrollView.imageURLStringsGroup = array;
    self.ScrollView.infiniteLoop = array.count>1 ? YES : NO;
    self.ScrollView.showPageControl = array.count>1 ? YES : NO;
    [self.scrollerView addSubview:self.ScrollView];

}


- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(HomeTableViewHeadSectionViewDidSelectedWith:)]) {
        [self.delegate HomeTableViewHeadSectionViewDidSelectedWith:[NSIndexPath indexPathForRow:index inSection:self.section]];
    }
    
}

- (IBAction)moreButtonClicked:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(MorebuttonClicked:withSection:)]) {
        [self.delegate MorebuttonClicked:sender withSection:self.section];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
