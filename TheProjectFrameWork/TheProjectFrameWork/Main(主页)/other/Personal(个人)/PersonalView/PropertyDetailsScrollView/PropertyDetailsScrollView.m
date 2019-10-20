//
//  PropertyDetailsScrollView.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/26.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//  积分余额明细显示

#import "PropertyDetailsScrollView.h"
#import "WalletDetailsCell.h"
static NSString * WalletDetailsCellId = @"WalletDetailsCell";
@interface PropertyDetailsScrollView ()<UITableViewDelegate,UITableViewDataSource,PropertyHeaderViewDelegate>
{
    UITableView * contentTableView;
    PropertyHeaderView * header;
}
@end
@implementation PropertyDetailsScrollView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor whiteColor];
        contentTableView = [[UITableView alloc] init];
        header = [[PropertyHeaderView alloc] initWithTitles:@[[LaguageControl languageWithString:@"全部"],[LaguageControl languageWithString:@"收入"],[LaguageControl languageWithString:@"支出"]]];
        header.delegate = self;
        [self addSubview:contentTableView];
        [self addSubview:header];
        __weak typeof(self) weakSelf = self;
        [header mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.left.equalTo(weakSelf);
            make.height.mas_equalTo(kScaleHeight(35));
        }];
        [contentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.bottom.equalTo(weakSelf);
            make.top.equalTo(header.mas_bottom);
        }];
        contentTableView.tableFooterView = [UIView new];
        contentTableView.delegate = self;
        contentTableView.dataSource = self;
        contentTableView.separatorColor = [UIColor clearColor];
        contentTableView.rowHeight = kScaleHeight(60);
        [contentTableView registerClass:[WalletDetailsCell class] forCellReuseIdentifier:WalletDetailsCellId];
    }
    return self;
}
- (void)reloadWithArray:(NSArray *)array withIsGold:(BOOL)isGold
{
    self.dataArray = array;
    self.isGold = isGold;
}
#pragma mark otherDelegate
- (void)propertyHeaderClickWithIndex:(NSInteger)index
{
    if([_delegate respondsToSelector:@selector(propertyDetailsScrollClickWithType:)])
    {
        [_delegate propertyDetailsScrollClickWithType:index];
    }
}

#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WalletDetailsCell * cell = [tableView dequeueReusableCellWithIdentifier:WalletDetailsCellId];
    cell.isGold = self.isGold;
    cell.balanceModel = self.dataArray[indexPath.row];
    return cell;
}
#pragma mark - setter and getter
- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    [contentTableView reloadData];
}
-(void)setIsGold:(BOOL)isGold{
    _isGold = isGold;
}
@end


@interface PropertyHeaderView ()<PropertyClickButtonDelegate>
{
    PropertyClickButton * selecteSender;
    NSInteger currentTag;
    UIView * line;
}
@end
@implementation PropertyHeaderView
- (instancetype)initWithTitles:(NSArray *)titles
{
    self = [super init];
    if(self)
    {
        _titles = titles;
        line = [UIView new];
        currentTag = 0;
        self.backgroundColor = [UIColor whiteColor];
        __weak typeof(self) weakSelf = self;
        __block UIView * lastView = nil;
        [titles enumerateObjectsUsingBlock:^(NSString *  _Nonnull title, NSUInteger idx, BOOL * _Nonnull stop) {
            PropertyClickButton * button = [[PropertyClickButton alloc] init];
            button.title = title;
            button.tag = idx;
            button.delegate = self;
            [self addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(weakSelf);
                if(lastView)
                {
                    make.left.equalTo(lastView.mas_right).mas_offset(kScaleWidth(20));
                    make.width.equalTo(lastView.mas_width);
                }else
                {
                    make.left.equalTo(weakSelf.mas_left).mas_offset(kScaleWidth(10));
                    selecteSender = button;
                    button.selected = YES;
                }
            }];
            lastView = button;
        }];
        [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.mas_right).mas_offset(-kScaleWidth(10));
        }];
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(2);
            make.left.right.bottom.equalTo(selecteSender);
        }];
        line.backgroundColor = [UIColor colorWithString:@"#C90C1E"];
    }
    return self;
}
- (void)propertyClickButton:(PropertyClickButton *)sender
{
    selecteSender.selected = NO;
    sender.selected = !sender.selected;
    selecteSender = sender;
    [line mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kScaleHeight(2));
        make.left.right.bottom.equalTo(selecteSender);
    }];
    [UIView animateWithDuration:0.25f animations:^{
        [self layoutIfNeeded];
        if([_delegate respondsToSelector:@selector(propertyHeaderClickWithIndex:)])
        {
            if(selecteSender.tag == currentTag )
            {
                return ;
            }
            [_delegate propertyHeaderClickWithIndex:selecteSender.tag];
            currentTag = selecteSender.tag;
        }
    }];
   
}
- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor colorWithString:@"#cccccc"] setStroke];
    CGContextSetLineWidth(ctx, 1);
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, 0, rect.size.height);
    CGContextAddLineToPoint(ctx, rect.size.width, rect.size.height);
    CGContextStrokePath(ctx);
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, 0, 0);
    CGContextAddLineToPoint(ctx, rect.size.width, 0);
    CGContextStrokePath(ctx);
}
@end



@interface PropertyClickButton ()
{
    UILabel * _titleLabel;
}
@end
@implementation PropertyClickButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _titleLabel = [[UILabel alloc] initWithText:nil];
        _titleLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(14)];
        _titleLabel.textColor = [UIColor colorWithString:@"#333333"];
        [self addSubview:_titleLabel];
        __weak typeof(self) weakSelf = self;
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf);
        }];
      
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if([_delegate respondsToSelector:@selector(propertyClickButton:)])
    {
        [_delegate propertyClickButton:self];
    }
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    _titleLabel.text = title;
}
- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    if(selected)
    {
        _titleLabel.textColor = [UIColor colorWithString:@"#C90C1E"];

    }else
    {
        _titleLabel.textColor = [UIColor colorWithString:@"#333333"];
    }
}
@end