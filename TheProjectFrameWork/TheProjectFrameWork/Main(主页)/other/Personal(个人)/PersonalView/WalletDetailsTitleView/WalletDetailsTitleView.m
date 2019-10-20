//
//  WalletDetailsTitleView.m
//  TheProjectFrameWork
//
//  Created by ZengPengYuan on 16/7/9.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//  钱包详情下拉标题

#import "WalletDetailsTitleView.h"

@implementation WalletDetailsTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
   
    self = [super initWithFrame:frame];
    if(self)
    {
        [self setTitleColor:kIsChiHuoApp ? kTextDeepDarkColor : [UIColor whiteColor] forState:UIControlStateNormal];
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.lineBreakMode = NSLineBreakByClipping;
    }
    return self;
}
- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25f];
    if(selected)
    {
        self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, M_PI);
    }else
    {
        self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, -M_PI);
    }
    [UIView commitAnimations];
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, contentRect.size.width * 0.8, contentRect.size.height);
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(contentRect.size.width * 0.8, 0, contentRect.size.width * 0.2, contentRect.size.height);
}
@end

@interface WalletDetailsUnfoldView ()<WalletDetailsTitleDelegate,OrderTypeItemDelegate>
{
    WalletDetailsTitle * currentTitle;
    OrderTypeItem * selectItem;
}

@end

@implementation WalletDetailsUnfoldView

- (instancetype)initWithTitles:(NSArray *)titles
{
    self = [super init];
    if(self)
    {
       
        __weak __typeof__(self.displayView) wview = self.displayView;
        __block UIView * lastView = nil;
       [titles enumerateObjectsUsingBlock:^(NSString * title, NSUInteger idx, BOOL * _Nonnull stop) {
           WalletDetailsTitle * view = [[WalletDetailsTitle alloc] init];
           view.title = LaguageControl(title);
           view.tag = idx;
           view.delegate = self;
           [wview addSubview:view];
           [view mas_makeConstraints:^(MASConstraintMaker *make) {
               make.right.left.equalTo(wview);
               if(lastView)
               {
                   make.top.equalTo(lastView.mas_bottom).mas_offset(-kScaleHeight(5));
               }
               else
               {
                   make.top.equalTo(wview.mas_top).mas_offset(kScaleHeight(5));
               }
           }];
           lastView = view;
       }];
       
        [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(wview.mas_bottom).mas_offset(-kScaleHeight(5));
        }];
        
        [wview layoutIfNeeded];
       
        [self layoutIfNeeded];
    
    }
    return self;
}
- (instancetype)initWithItems:(NSArray *)items defaultItemIndex:(NSInteger)index{
    self = [super init];
    if(self)
    {
    __block UIView * lastView = nil;
    __weak __typeof__(self.displayView) wview = self.displayView;

    [items enumerateObjectsUsingBlock:^(NSString * str, NSUInteger idx, BOOL * _Nonnull stop) {
        OrderTypeItem * item = [[OrderTypeItem alloc] init];
        item.text = str;
        item.tag = idx << idx;
        item.delegate = self;
        if(idx == index){
            item.selected = YES;
            selectItem = item;
        }
        [wview addSubview:item];
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kScaleHeight(35));
            if(lastView)
            {
                make.width.equalTo(lastView.mas_width);
                if(idx % 3)
                {
                    make.left.equalTo(lastView.mas_right).mas_offset(kScaleWidth(15));
                    make.top.equalTo(lastView.mas_top);
                    if(idx % 3 == 2)
                    {
                        make.right.equalTo(wview.mas_right).mas_offset(-kScaleWidth(20));
                    }
                }else
                {
                    make.top.equalTo(lastView.mas_bottom).mas_offset(kScaleHeight(16));
                    make.left.equalTo(wview.mas_left).mas_offset(kScaleWidth(15));
                }
            }else
            {
                make.top.equalTo(wview.mas_top).mas_offset(kScaleHeight(20));
                make.left.equalTo(wview.mas_left).mas_offset(kScaleWidth(15));
            }
        }];
        lastView = item;
    }];
        [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(wview.mas_bottom).mas_offset(-kScaleHeight(75));
        }];
    }
    return self;
}


#pragma mark - delegate
-(void)walletTitle:(WalletDetailsTitle *)title
{
    currentTitle.check = [title isEqual:currentTitle];
   if( [_delegate respondsToSelector:@selector(walletdetaileTitleFrom:to:)])
   {
       [_delegate walletdetaileTitleFrom:currentTitle.tag to:title.tag];
   }
    currentTitle = title;
    
}
- (void)orderTypeClickWithItem:(OrderTypeItem *)item
{
    selectItem.selected = !selectItem.selected;
    if([_delegate respondsToSelector:@selector(orderTypeView:type:title:)])
    {
        [_delegate orderTypeView:self type:item.tag title:item.text];
    }
    selectItem = item;
   
}
@end





@interface WalletDetailsTitle ()
{
    UILabel * _titleLabel;
    UIImageView * _imageView;
}
@end
@implementation WalletDetailsTitle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _titleLabel = [[UILabel alloc] initWithText:nil];
        _imageView = [[UIImageView alloc] initWithImage:nil];
        _titleLabel.textColor = [UIColor blackColor];
        _imageView.contentMode = UIViewContentModeCenter;
        [self addSubview:_titleLabel];
        [self addSubview:_imageView];
        __weak __typeof__(self) weakSelf = self;
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).mas_offset(kScaleWidth(30));
            make.top.equalTo(weakSelf.mas_top).mas_offset(kScaleHeight(8));
            make.bottom.equalTo(weakSelf.mas_bottom).mas_offset(-kScaleHeight(8));
        }];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf);
            make.right.equalTo(weakSelf.mas_right).mas_offset(-kScaleWidth(15));
        }];
    }
    return self;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   if( [_delegate respondsToSelector:@selector(walletTitle:)])
   {
       self.check = !_check;
       [_delegate walletTitle:self];
   }
}
- (void)setTitle:(NSString *)title
{
    _title = title;
    _titleLabel.text = title;
}
- (void)setCheck:(BOOL)check
{
    _check = check;
    if(_check)
    {
        _imageView.image = [UIImage imageNamed:@"duigou"];
    }else
    {
        _imageView.image = nil;
    }
}
@end


@implementation OrderTypeItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.userInteractionEnabled = YES;
        self.layer.borderWidth = 1;
        self.layer.cornerRadius = 3;
        self.layer.masksToBounds = YES;
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:kAppAsiaFontSize(14)];
        self.textColor = [UIColor colorWithString:@"#333333"];
        self.backgroundColor = [UIColor colorWithString:@"#cccccc"];
        self.layer.borderColor = [UIColor colorWithString:@"#cccccc"].CGColor;
    }
    return self;
}
- (void)setSelected:(BOOL)selected
{
    if(selected)
    {
        self.textColor = [UIColor colorWithString:@"#C90C1E"];
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = [UIColor colorWithString:@"#C90C1E"].CGColor;
    }else
    {
        self.textColor = [UIColor colorWithString:@"#333333"];
        self.backgroundColor = [UIColor colorWithString:@"#cccccc"];
        self.layer.borderColor = [UIColor colorWithString:@"#cccccc"].CGColor;
    }
    _selected = selected;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.selected = !self.selected;
    if([_delegate respondsToSelector:@selector(orderTypeClickWithItem:)])
    {
        [_delegate orderTypeClickWithItem:self];
    }
}
@end





@implementation DropdownListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        UIView * displayView = [UIView new];
        displayView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.65f];
        self.alpha = 0;
        UIView * backgrundView = [UIView new];
        [self addSubview:backgrundView];
        [self addSubview:displayView];
        _displayView = displayView;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fold)];
        [backgrundView addGestureRecognizer:tap];
        __weak __typeof__(self) weakSelf = self;
        
        [backgrundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(weakSelf);
            make.top.equalTo(_displayView.mas_bottom);
        }];
        [_displayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(weakSelf);
            make.bottom.equalTo(weakSelf.mas_top).priority(500);
        }];
    }
    return self;
}
/**
 *  展开
 */
- (void)unfold
{
    __weak __typeof__(self) weakSelf = self;
    [_displayView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).priority(750);
    }];
    
    [UIView animateWithDuration:.25 animations:^{
        [self layoutIfNeeded];
        self.alpha = 1;
    }];
    
}
/**
 *  折叠
 */
- (void)fold
{
    __weak __typeof__(self) weakSelf = self;
    [_displayView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_top);
    }];
    [UIView animateWithDuration:.25 animations:^{
        [self layoutIfNeeded];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
