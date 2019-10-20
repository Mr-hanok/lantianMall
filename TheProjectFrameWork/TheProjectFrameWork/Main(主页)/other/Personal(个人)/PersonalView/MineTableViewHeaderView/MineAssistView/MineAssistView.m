//
//  MineAssistView.m
//  test
//
//  Created by TheMacBook on 16/6/28.
//  Copyright © 2016年 TheMacBook. All rights reserved.
//

#import "MineAssistView.h"
#import "MineAssistSubView.h"
@interface MineAssistView ()<MineAssistSubViewDelegate>
{
    MineAssistSubView * _concernCommodity;
    MineAssistSubView * _concernStore;
    MineAssistSubView * _mineStore;
}
@end
@implementation MineAssistView
- (instancetype)initWithModel:(id)model
{
    self = [super init];
    if(self)
    {
        self.backgroundColor = [UIColor colorWithString:@"#ffffff40"];
        _concernCommodity = [[MineAssistSubView alloc] initWithTitle:@"关注的商品" count:0];
        _concernStore = [[MineAssistSubView alloc] initWithTitle:@"关注的店铺" count:0];
        _mineStore = [[MineAssistSubView alloc] initWithMineStore:@"我的店铺"];
        _concernCommodity.type = 1;
        _concernStore.type = 2;
        _mineStore.type = 3;
        _concernCommodity.delegate = self;
        _concernStore.delegate = self;
        _mineStore.delegate = self;
        [self addSubview:_concernCommodity];
        [self addSubview:_concernStore];
        [self addSubview:_mineStore];
        
        [self setup];
    }
    return self;
}
- (void)mineAssistSubView:(MineAssistSubView *)view
{
    if([_delegate respondsToSelector:@selector(mineAssistView:type:)])
    {
        [_delegate mineAssistView:self type:view.type];
    }
}
- (void)loadWithModel:(id)model
{
    
    if ([[NSUserDefaults standardUserDefaults]boolForKey:kIsB2cStr]) {
        _concernStore.hidden = _mineStore.hidden = YES;
    }
    if([UserAccountManager shareUserAccountManager].loginStatus)
    {
        UserModel * user = [UserAccountManager shareUserAccountManager].userModel;
        [_concernCommodity loadAssistWithTitle:@"关注的商品" count:user.goodsCount];
        [_concernStore loadAssistWithTitle:@"关注的店铺" count:user.storeCount];
    }else
    {
        [_concernCommodity loadAssistWithTitle:@"关注的商品" count:0];
        [_concernStore loadAssistWithTitle:@"关注的店铺" count:0];
    }
  
    [_mineStore loadAssistWithTitle:@"我的店铺" count:-1];
}

- (void)setup
{
    __weak typeof(self) weakSelf = self;
    if ([[NSUserDefaults standardUserDefaults]boolForKey:kIsB2cStr]) {

        [_concernCommodity mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(weakSelf);
            make.height.equalTo(weakSelf.mas_height);
        }];
        [_concernStore mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(weakSelf);
//            make.left.equalTo(_concernCommodity.mas_right);
            make.size.equalTo(_concernCommodity);
        }];
        [_mineStore mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.bottom.equalTo(weakSelf);
//            make.left.equalTo(_concernStore.mas_right);
            make.size.equalTo(_concernCommodity).priority(750);
        }];
    }else{
        [_concernCommodity mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(weakSelf);
            make.height.equalTo(weakSelf.mas_height);
        }];
        [_concernStore mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf);
            make.left.equalTo(_concernCommodity.mas_right);
            make.size.equalTo(_concernCommodity);
        }];
        [_mineStore mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(weakSelf);
            make.left.equalTo(_concernStore.mas_right);
            make.size.equalTo(_concernCommodity).priority(750);
        }];
    }
    
}
- (void)drawRect:(CGRect)rect
{
    CGFloat oneLineX = rect.size.width / 3;
    CGFloat twoLineX = rect.size.width / 3 * 2;
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor colorWithString:@"#cccccc80"] setStroke];
    CGContextSetLineWidth(ctx, 0.5f);
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, oneLineX, 0);
    CGContextAddLineToPoint(ctx, oneLineX, rect.size.height);
    CGContextStrokePath(ctx);
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, twoLineX, 0);
    CGContextAddLineToPoint(ctx, twoLineX, rect.size.height);
    CGContextStrokePath(ctx);
}
@end
