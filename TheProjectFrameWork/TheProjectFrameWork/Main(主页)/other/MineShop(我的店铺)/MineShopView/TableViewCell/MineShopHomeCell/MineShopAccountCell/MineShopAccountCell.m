//
//  MineShopAccountCell.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/2.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "MineShopAccountCell.h"
@interface MineShopAccountCell ()<AccountViewDelegate>
@end
@implementation MineShopAccountCell
{
    AccountView * view;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.title = [LaguageControl languageWithString:@"我的账户"];
        [self setup];
    }
    return self;
}
- (void)setup
{
    UIView * mineAccount = [UIView new];
    mineAccount.backgroundColor = [UIColor clearColor];
    UIImageView * more = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"more"]];
    more.contentMode = UIViewContentModeCenter;
    view = [[AccountView alloc] init];
    view.delegate = self;
    [self.backView addSubview:view];
    [self.backView addSubview:mineAccount];
    [self.backView addSubview:more];
    __weak typeof(self) weakSelf = self;
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.equalTo(weakSelf.backView);
        make.top.equalTo(weakSelf.line.mas_bottom);
    }];
    [mineAccount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf.backView);
        make.bottom.equalTo(weakSelf.line.mas_top);
    }];
    [more mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.backView.mas_right).mas_offset(-kScaleWidth(10));
        make.top.bottom.equalTo(mineAccount);
        make.width.mas_equalTo(kScaleWidth(8));
    }];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickMineAccount)];
    [mineAccount addGestureRecognizer:tap];
}
- (void)clickMineAccount
{
    if([_delegate respondsToSelector:@selector(mineShopMineAccount:)])
    {
        [_delegate mineShopMineAccount:self];
    }
}
- (void)accountView:(AccountView *)view type:(NSInteger)type
{
    if([_delegate respondsToSelector:@selector(mineShopAccount:type:)])
    {
        [_delegate mineShopAccount:self type:type];
    }
}
- (void)setBalance:(CGFloat)balance
{
    _balance = balance;
    view.balance = balance;
}
- (void)setStoreCredit:(CGFloat)storeCredit
{
    _storeCredit = storeCredit;
    view.storeCredit = storeCredit;
}
- (void)setIsReview:(BOOL)isReview
{
    _isReview = isReview;
    view.isReview = isReview;
}
@end

@interface AccountView () <AccountItemDelegate>

@end
@implementation AccountView
{
    AccountItem * _account; // 账户余额
    AccountItem * _gold; // 金币余额
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor clearColor];
        AccountItem * account = [[AccountItem alloc] init];
        account.title = [LaguageControl languageWithString:@"账户余额"];
        AccountItem * gold = [[AccountItem alloc] init];
        gold.title = [LaguageControl languageWithString:@"金币余额"];
        account.delegate = self;
        gold.delegate = self;
        [self addSubview:account];
        [self addSubview:gold];
        __weak typeof(self) weakSelf = self;
        [gold mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(weakSelf);
            make.size.equalTo(account);
        }];
        [account mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(weakSelf);
            make.right.equalTo(gold.mas_left);
        }];
        account.tag = 101;
        gold.tag = 102;
        _gold = gold;
        _account = account;
    }
    return self;
}
- (void)accountItemClickWithItem:(AccountItem *)item
{
    if([_delegate respondsToSelector:@selector(accountView:type:)])
    {
        [_delegate accountView:self type:item.tag-100];
    }
}
- (void)drawRect:(CGRect)rect
{
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithString:@"#cccccc"].CGColor);
    CGFloat lengths[] = {3,1};
    CGContextSetLineDash(context, 0, lengths,2);
    CGContextMoveToPoint(context, rect.size.width/2, 6);
    CGContextAddLineToPoint(context, rect.size.width/2,rect.size.height-5);
    CGContextStrokePath(context);
}
-(void)setStoreCredit:(CGFloat)storeCredit
{
    _storeCredit = storeCredit;
    _gold.value = storeCredit;
}
-(void)setBalance:(CGFloat)balance
{
    _balance = balance;
    _account.value = balance;
}
- (void)setIsReview:(BOOL)isReview
{
    _isReview = isReview;
    _gold.hidden = isReview;
}
@end

@implementation AccountItem
{
    UILabel * _titleLabel;
    UILabel * _valueLabel;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _titleLabel = [[UILabel alloc] init];
        _valueLabel = [[UILabel alloc] init];
        [self setupLabel:_valueLabel];
        [self setupLabel:_titleLabel];
        __weak typeof(self) weakSelf = self;
        [_valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(weakSelf);
            make.top.equalTo(weakSelf.mas_top).mas_offset(kScaleHeight(10));
            make.bottom.equalTo(_titleLabel.mas_top).mas_offset(-kScaleHeight(5));
        }];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(weakSelf);
            make.bottom.equalTo(weakSelf.mas_bottom).mas_offset(-kScaleHeight(10));
        }];
        _valueLabel.textColor = [UIColor colorWithString:@"#C90C1E"];
    }
    return self;
}
- (void)setupLabel:(UILabel *)label
{
    label.textColor = [UIColor colorWithString:@"#333333"];
    label.font = [UIFont systemFontOfSize:kAppAsiaFontSize(13)];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if([_delegate respondsToSelector:@selector(accountItemClickWithItem:)])
    {
        [_delegate accountItemClickWithItem:self];
    }
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    _titleLabel.text = title;
}
- (void)setValue:(CGFloat)value
{
    _value = value;
    _valueLabel.text = [NSString stringWithFormat:@"%.2f",value];
}
@end