//
//  MinePropertyCell.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/6/30.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "MinePropertyCell.h"
#import "MineTitleView.h"
#import "MineDetailView.h"
@interface MinePropertyCell ()<MineDetailViewDelegate,MineTitleViewDelegate>
{
    MineTitleView * _oneTitleView;
    MineDetailView * _oneDetailView;
    MineTitleView * _twoTitleView;
    MineDetailView * _twoDetailView;
}
@end
@implementation MinePropertyCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        _oneTitleView = [[MineTitleView  alloc] init];
        _oneDetailView = [[MineDetailView alloc] init];
        _twoTitleView = [[MineTitleView alloc] init];
        _twoDetailView = [[MineDetailView alloc] init];
        _oneDetailView.isIntegral = NO;
        _twoDetailView.isIntegral = YES;
        [self.contentView addSubview:_oneTitleView];
        [self.contentView addSubview:_oneDetailView];
        [self.contentView addSubview:_twoTitleView];
        [self.contentView addSubview:_twoDetailView];
        _oneTitleView.image = [UIImage imageNamed:@"qianbao"];
        _twoTitleView.image = [UIImage imageNamed:@"jifen"];
       
       
        _oneTitleView.delegate = self;
        _twoTitleView.delegate = self;
        _oneDetailView.delegate = self;
        _twoDetailView.delegate = self;
        
        _oneTitleView.tag = 101;
        _twoTitleView.tag = 102;
        _oneDetailView.tag = 201;
        _twoDetailView.tag = 202;
        [self layoutView];
    }
    return self;
}
- (void)layoutView
{
    __weak typeof(self) weakSelf = self;
    [_oneTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(weakSelf.contentView);
        make.height.mas_equalTo(kScaleHeight(40));
    }];
    [_oneDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.equalTo(weakSelf.contentView);
        make.size.equalTo(_twoDetailView);
        make.right.equalTo(_twoDetailView.mas_left);
    }];
    [_twoTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(weakSelf.contentView);
        make.size.equalTo(_oneTitleView);
        make.left.equalTo(_oneTitleView.mas_right);
    }];
    [_twoDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(weakSelf.contentView);
        make.top.equalTo(_twoTitleView.mas_bottom);
    }];
}
- (void)loadWithModel:(id)model
{
    if([UserAccountManager shareUserAccountManager].loginStatus)
    {
        UserModel * user = [UserAccountManager shareUserAccountManager].userModel;
        _oneDetailView.value = [user.accountBalance doubleValue];
        _twoDetailView.value = [user.integral floatValue];
    }else
    {
        _oneDetailView.value = 0;
        _twoDetailView.value = 0;
    }
    _oneTitleView.title = [LaguageControl languageWithString:@"账户"];
    _twoTitleView.title = [LaguageControl languageWithString:@"积分商城"];
    _twoDetailView.text = [LaguageControl languageWithString:@"积分"];
    _oneDetailView.text = [LaguageControl languageWithString:@"余额"];
    _twoDetailView.accessoryStr = [LaguageControl languageWithString:@"积分明细"];
    _oneDetailView.accessoryStr = [LaguageControl languageWithString:@"交易明细"];
}
#pragma mark - other Delegate
- (void)mineDetailViewClick:(MineDetailView *)view
{
    if([_delegate respondsToSelector:@selector(minePropertyClickEventWithIndex:)])
    {
        [_delegate minePropertyClickEventWithIndex:view.tag];
    }
}
-(void)mineDetailViewAccessoryStrClick:(MineDetailView *)view{
    if (view == _oneDetailView) {
        return;
    }
    if ([_delegate respondsToSelector:@selector(minePropertyIntegralMallClickEvent)]) {
        [_delegate minePropertyIntegralMallClickEvent];
    }
}
- (void)mineTitleViewClick:(MineTitleView *)view
{
    if([_delegate respondsToSelector:@selector(minePropertyClickEventWithIndex:)])
    {
        [_delegate minePropertyClickEventWithIndex:view.tag];
    }
}


- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithString:@"#cccccc"].CGColor);
    CGFloat lengths[] = {3,1};
    CGContextSetLineDash(context, 0, lengths,2);
    CGContextMoveToPoint(context, rect.size.width/2, 0);
    CGContextAddLineToPoint(context, rect.size.width/2,rect.size.height);
    CGContextStrokePath(context);
}
@end
