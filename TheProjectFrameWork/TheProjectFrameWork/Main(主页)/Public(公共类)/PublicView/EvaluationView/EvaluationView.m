//
//  EvaluationView.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/25.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//  

#import "EvaluationView.h"
#import <math.h>
#define kNumberOfStars 5
@interface EvaluationView ()
@property (nonatomic , weak) UIView * backgroundView;

@property (nonatomic , weak) UIView * scoreView;

@end
@interface EvaluationView ()
{
}
@end
@implementation EvaluationView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundView.backgroundColor = [UIColor clearColor];
        self.scoreView.backgroundColor = [UIColor clearColor];
        [self layoutIfNeeded];
    }
    return self;
}
- (void)loadWithSuperView:(UIView *)view with:(UIImage *)image
{
    view.clipsToBounds = YES;
    __weak typeof(self) weakSelf = self;
    __block UIView * lastView = nil;
    for (NSInteger i = 0; i < kNumberOfStars; i++) {
        UIImageView * imageV = [[UIImageView alloc] initWithImage:image];
        imageV.contentMode = UIViewContentModeCenter;
        [view addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(weakSelf);
            if(lastView)
            {
                make.left.lessThanOrEqualTo(lastView.mas_right);
                make.size.equalTo(lastView);
            }else
            {
                make.left.lessThanOrEqualTo(weakSelf.mas_left);
            }
        }];
        lastView = imageV;
    }
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right);
    }];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGFloat offset = [touch locationInView:self].x;
    CGFloat realStarScore = offset / (self.bounds.size.width / (CGFloat)kNumberOfStars);
    CGFloat starScore = ceilf(realStarScore);
    self.scorePercent = starScore / kNumberOfStars;
    
}
- (void)setScorePercent:(CGFloat)scorePercent
{
    if(scorePercent <= 0.3 && (scorePercent == _scorePercent/kNumberOfStars))
    {
        scorePercent = 0;
    }
    __weak typeof(self) weakSelf = self;
    _scorePercent = scorePercent * kNumberOfStars;
    [_scoreView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(weakSelf.mas_width).multipliedBy(scorePercent);
        make.top.bottom.left.equalTo(weakSelf);
    }];
    if(_isAnimate)
    {
        [UIView animateWithDuration:0.15f animations:^{
            [self layoutIfNeeded];
        }];
    }
    
}
- (UIView *)scoreView
{
    if(!_scoreView)
    {
        UIView * scoreView = [UIView new];
        [self addSubview:scoreView];
        __weak typeof(self) weakSelf = self;
        [scoreView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.equalTo(weakSelf);
            make.width.equalTo(weakSelf.mas_width).multipliedBy(0);
        }];
        [self loadWithSuperView:scoreView with:[UIImage imageNamed:@"xuanzhouxingxing"]];
        _scoreView = scoreView;
    }
    return _scoreView;
}
- (UIView *)backgroundView
{
    if(!_backgroundView)
    {
        UIView * backView = [UIView new];
        
        [self addSubview:backView];
        __weak typeof(self) weakSelf = self;
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf);
        }];
        [self loadWithSuperView:backView with:[UIImage imageNamed:@"weixuanzhongxingxing"]];
        _backgroundView = backView;
    }
    return _backgroundView;
}
@end
