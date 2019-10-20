//
//  GoodsHeadView.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/6.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsHeadView.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface GoodsHeadView ()<UIScrollViewDelegate>
@property(assign,nonatomic) NSInteger count;
@property(assign,nonatomic) NSInteger currentPage;
@property (strong, nonatomic)  UIImageView * leftimageView;
@property (strong, nonatomic)  UIImageView * middleimageView;
@property (strong, nonatomic)  UIImageView * rightimageView;
@property(strong,nonatomic) NSMutableArray * dataArray;
@end


@implementation GoodsHeadView
{
    UIImageView * imageView;
}
+(id)loadView{
    GoodsHeadView * view  = [super loadView];
    view.leftimageView = [UIImageView new];
    view.middleimageView = [UIImageView new];
    view.rightimageView = [UIImageView new];
    view.dataArray= [NSMutableArray array];
    view.frame = CGRectMake(0, 0, KScreenBoundWidth, KScreenBoundWidth);
    return view;
}
-(void)loadScrollerViewWithArray:(NSArray*)array
{
    
    self.currentPage = 0;
    self.count = array.count;
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:array];
    self.leftimageView.contentMode = UIViewContentModeScaleToFill;
    self.leftimageView.frame = CGRectMake(0, 10, KScreenBoundWidth, KScreenBoundWidth-5);
    [self.headScrollerView addSubview:self.leftimageView];
    self.middleimageView.contentMode = UIViewContentModeScaleToFill;
    self.middleimageView.frame = CGRectMake(KScreenBoundWidth, 10, KScreenBoundWidth, KScreenBoundWidth-5);
    [self.headScrollerView addSubview:self.middleimageView];
    self.rightimageView.contentMode = UIViewContentModeScaleToFill;
    self.rightimageView.frame = CGRectMake(KScreenBoundWidth*2, 10, KScreenBoundWidth, KScreenBoundWidth-5);
    [self.headScrollerView addSubview:self.rightimageView];
    [self setDefaultImage];
    self.pageLabel.backgroundColor = [UIColor colorWithWhite:0.4 alpha:0.5];
    self.pageLabel.textColor = [UIColor whiteColor];
    self.pageLabel.text = [NSString stringWithFormat:@"1/%ld",array.count];
    self.pageLabel.layer.cornerRadius = 20;
    self.pageLabel.layer.masksToBounds = YES;
    self.headScrollerView.scrollEnabled = YES;
    //设置在拖拽的时候是否显示滚动条
    self.headScrollerView.showsHorizontalScrollIndicator = NO;
    self.headScrollerView.contentSize = CGSizeMake(KScreenBoundWidth*3, 0);
    [self.headScrollerView setContentOffset:CGPointMake(KScreenBoundWidth, 0) animated:NO];
    self.headScrollerView.pagingEnabled = YES;
    self.headScrollerView.delegate = self;
}
/** 设置起始图片 */
-(void)setDefaultImage
{
    //左边显示最后一张
    [self.leftimageView sd_setImageWithURL:[NSURL URLWithString:[self.dataArray lastObject]] placeholderImage:[UIImage imageNamed:@"defaultImgForGoods"]];
    //中间显示第一张
    [self.middleimageView sd_setImageWithURL:[NSURL URLWithString:[self.dataArray firstObject]] placeholderImage:[UIImage imageNamed:@"defaultImgForGoods"]];
    
    if (self.count>=2)
    {
        //第二张
        [self.rightimageView sd_setImageWithURL:[NSURL URLWithString:self.dataArray [1]] placeholderImage:[UIImage imageNamed:@"defaultImgForGoods"]];
    }
    else
    {
        //第二张
        [self.rightimageView sd_setImageWithURL:[NSURL URLWithString:[self.dataArray firstObject]] placeholderImage:[UIImage imageNamed:@"defaultImgForGoods"]];
    }
    
}
#pragma mark 根据滑动的方向来判定图片如何加载


-(void)ReloadImage
{
    CGPoint offset = self.headScrollerView.contentOffset;//内容视图的位置
    if (offset.x>KScreenBoundWidth)
    {//右滑
        if (self.currentPage>=self.count-1)
        {
            self.currentPage=0;
        }
        else
        {
            self.currentPage ++;
        }
    }
    if (offset.x<KScreenBoundWidth)
    {//左滑
        if (self.currentPage==0)
        {
            self.currentPage = self.count-1;
        }
        else
        {
            self.currentPage --;
        }
    }
    [self reloadView];
}
-(void)reloadView
{
    NSString *transString = [NSString stringWithFormat:@"%ld/%ld",self.currentPage+1,self.count];
    self.pageLabel.text = transString;
    if (self.currentPage)
    {
        [self.middleimageView sd_setImageWithURL:[NSURL URLWithString:self.dataArray[self.currentPage]] placeholderImage:[UIImage imageNamed:@"defaultImgForGoods"]];
        [self.leftimageView sd_setImageWithURL:[NSURL URLWithString:self.dataArray[self.currentPage-1]] placeholderImage:[UIImage imageNamed:@"defaultImgForGoods"]];

//        self.leftimageView.image = [UIImage imageNamed:self.dataArray[self.currentPage-1]];
        if (self.currentPage==self.count-1)
        {
//            self.rightimageView.image = [UIImage imageNamed:[self.dataArray firstObject]];
            [self.rightimageView sd_setImageWithURL:[NSURL URLWithString:[self.dataArray firstObject]] placeholderImage:[UIImage imageNamed:@"defaultImgForGoods"]];
        }
        else
        {
//            self.rightimageView.image = [UIImage imageNamed:self.dataArray[self.currentPage+1]];
            [self.rightimageView sd_setImageWithURL:[NSURL URLWithString:self.dataArray[self.currentPage+1]] placeholderImage:[UIImage imageNamed:@"defaultImgForGoods"]];
        }
    }
    else
    {
        [self setDefaultImage];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    //调用重新加载图片的方法
    [self ReloadImage];
    //移动到中间
    [self.headScrollerView setContentOffset:CGPointMake(KScreenBoundWidth, 0) animated:NO];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
