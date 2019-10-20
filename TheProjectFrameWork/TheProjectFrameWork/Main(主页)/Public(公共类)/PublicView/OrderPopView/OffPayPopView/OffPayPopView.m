//
//  OffPayPopView.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/20.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "OffPayPopView.h"
@interface  OffPayPopView ()
{
    UILabel * _orderNumLabel;
    UILabel * _promptLabel;
    OffPayButton * _selectButton;
}
@end
@implementation OffPayPopView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _orderNumLabel = [[UILabel alloc] initWithText:nil];
        _promptLabel = [[UILabel alloc] initWithText:nil];
        [self.contentView addSubview:_orderNumLabel];
        [self.contentView addSubview:_promptLabel];
        [self setup];
    }
    return self;
}
- (void)setup
{
    _promptLabel.text = LaguageControlAppend(@"取消原因");
    _promptLabel.textColor = [UIColor colorWithString:@"#333333"];
    _orderNumLabel.textColor = _promptLabel.textColor;
    __weak typeof(self) weakSelf = self;
    [_orderNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView.mas_left).mas_offset(kScaleWidth(20));
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).mas_offset(kScaleHeight(15));
        make.height.mas_equalTo(kScaleHeight(20));
    }];
    [_promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_orderNumLabel.mas_left);
        make.top.equalTo(_orderNumLabel.mas_bottom).mas_offset(kScaleHeight(13));
        make.height.equalTo(_orderNumLabel.mas_height);
    }];
}
- (void)setIssues:(NSArray *)issues
{
    _issues = issues;
    __block UIView * lastView = nil;
    __weak typeof(self) weakSelf = self;
    [issues enumerateObjectsUsingBlock:^(NSString  *_Nonnull str, NSUInteger idx, BOOL * _Nonnull stop) {
        OffPayButton * sender = [OffPayButton buttonWithType:UIButtonTypeCustom];
        [sender addTarget:self action:@selector(clickCauseWithButton:) forControlEvents:UIControlEventTouchUpInside];
        [sender setTitle:LaguageControl(str) forState:UIControlStateNormal];
        [weakSelf.contentView addSubview:sender];
        [sender mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.contentView.mas_left).mas_offset(kScaleWidth(30));
            make.height.mas_equalTo(kScaleHeight(20));
            make.right.equalTo(weakSelf.contentView.mas_right).mas_offset(-kScaleWidth(15));
            if(lastView)
            {
                make.top.equalTo(lastView.mas_bottom).mas_offset(kScaleHeight(15)).priority(750);
            }else
            {
                make.top.equalTo(_promptLabel.mas_bottom).mas_offset(kScaleHeight(15));
            }
        }];
        lastView = sender;
    }];
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.cancel.mas_top).mas_offset(-kScaleHeight(15));
    }];
    
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}
- (void)setOrderID:(NSString *)orderID
{
    _orderID = orderID;
    _orderNumLabel.text = [NSString stringWithFormat:@"%@：%@",LaguageControl(@"订单号"),orderID];
}
- (void)clickCauseWithButton:(OffPayButton *)sender
{
    _selectButton.selected = NO;
    sender.selected = !sender.selected;
    _selectButton = sender;

}
- (void)getsureEventBlock:(sureBlock)block
{
    self.sureEventBlock = block;
}
/**
 *  点击确定 （暂时给nil 你自己传） 
 */
- (void)sureEvent
{
    if(_selectButton.currentTitle.length == 0)
    {
        [HUDManager showWarningWithText:@"请选择原因"];
        return;
    }
    if(self.sureEventBlock)
    {
        self.sureEventBlock(_selectButton.currentTitle);
        [self removeFromWindow];
    }
    if([self.delegate respondsToSelector:@selector(baseOrderPop:content:)])
    {
        [self.delegate baseOrderPop:self content:_selectButton.currentTitle];
    }
}
@end



@implementation OffPayButton
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.titleLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(12)];
        [self setTitleColor:[UIColor colorWithString:@"#333333"] forState:UIControlStateNormal];
        self.imageView.contentMode = UIViewContentModeCenter;
        [self setImage:[UIImage imageNamed:@"Sexxuanzhong"] forState:UIControlStateSelected];
        [self setImage:[UIImage imageNamed:@"Sexweixuanzhong"] forState:UIControlStateNormal];
    }
    return self;
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, contentRect.size.width * 0.618f, contentRect.size.height);
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(contentRect.size.width * 0.618f, 0, contentRect.size.width * (1-0.618f), contentRect.size.height);
}

@end
