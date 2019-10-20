//
//  ShareView.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/28.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ShareView.h"
@interface ShareView ()

@property (nonatomic , weak) UIView * contentView;

@end
@implementation ShareView
- (instancetype)initWithFrame:(CGRect)frame
{
    frame = kScreenFreameBound;
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor clearColor];
        UIView * backView = [UIView new];
        backView.backgroundColor = [UIColor colorWithString:@"#000000100"];
        UIView * contentView = [UIView new];
        contentView.backgroundColor = kBGColor;
        [self addSubview:backView];
        [self addSubview:contentView];
        __weak typeof(self) weakSelf = self;
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(weakSelf);
            make.top.equalTo(weakSelf.mas_bottom).priority(500);
            make.height.mas_equalTo(180);
        }];
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(weakSelf);
            make.bottom.equalTo(self.mas_bottom);
        }];
        _contentView = contentView;
        [self layoutContentSubView];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeFromWindow)];
        [backView addGestureRecognizer:tap];
        [self layoutIfNeeded];
        
        self.alpha = 0;
        
    }
    return self;
}
- (void)layoutContentSubView
{
    _contentView.backgroundColor = kBGColor;
    UIButton * cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancel setBackgroundColor:[UIColor whiteColor]];
    UIView * line = [[UIView alloc] init];
    [_contentView addSubview:cancel];
    [_contentView addSubview:line];
    [cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(_contentView);
        make.height.mas_equalTo(45);
    }];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.right.left.equalTo(_contentView);
        make.bottom.equalTo(cancel.mas_top);
    }];
    [cancel setTitle:[LaguageControl languageWithString:@"取消"] forState:UIControlStateNormal];
    [cancel setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    cancel.titleLabel.font = [UIFont boldSystemFontOfSize:kAppAsiaFontSize(16)];
    line.backgroundColor = [UIColor clearColor];
    [cancel addTarget:self action:@selector(removeFromWindow) forControlEvents:UIControlEventTouchUpInside];
//   NSString *path = [[NSBundle mainBundle] pathForResource:@"ShareSDKUI" ofType:@"bundle"];
//    path = [path stringByAppendingPathComponent:@"Icon"];
//
//    UIImage *tempImage1 = [UIImage imageWithContentsOfFile:[path stringByAppendingPathComponent:@"sns_icon_22"]];
//
//    UIImage *tempImage2 = [UIImage imageWithContentsOfFile:[path stringByAppendingPathComponent:@"sns_icon_23"]];
    
    NSArray * items = @[
//                        @{@"title":[LaguageControl languageWithString:@"邮件"],@"image":[UIImage imageNamed:@"Mail"],@"type":@(ShareTypeEmail)},
//                        @{@"title":@"Facebook",@"image":[UIImage imageNamed:@"Facebook"],@"type":@(ShareTypesFaceBook)},
                        /*@{@"title":@"Twitter",@"image":[UIImage imageNamed:@"Twitter"],@"type":@(ShareTypeTwitter)},*/
//                        @{@"title":@"SMS",@"image":[UIImage imageNamed:@"sms"],@"type":@(ShareTypeSMS)},
//                        @{@"title":@"Google+",@"image":[UIImage imageNamed:@"google+"],@"type":@(ShareTypeGooglePlus)},
                        @{@"title":[LaguageControl languageWithString:@"微信好友"],@"image":[UIImage imageNamed:@"weixinicon"],@"type":@(ShareTypeQQTypeWechatSession)},
                        @{@"title":@"微信朋友圈",@"image":[UIImage imageNamed:@"pengyuquanicon"],@"type":@(ShareTypeQQTypeWechatTimeline)} ,
//                        @{@"title":@"QQ",@"image":[UIImage imageNamed:@"qq"],@"type":@(ShareTypeQQ)}
                        ];
    [items enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull dic, NSUInteger idx, BOOL * _Nonnull stop) {
        ShareItem * item = [[ShareItem alloc] initWithTitle:dic[@"title"] image:dic[@"image"] type:[dic[@"type"] integerValue]];
        [item addTarget:self action:@selector(clickShare:) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:item];
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            
           make.centerX.equalTo(_contentView.mas_left).mas_offset(((idx*2)+1)/4.0*KScreenBoundWidth);
            make.top.equalTo(_contentView.mas_top).mas_offset(20);
            make.bottom.equalTo(line.mas_top).mas_offset(-20);
            
        }];
    }];
    [self layoutIfNeeded];
}
- (void)clickShare:(ShareItem *)item
{
    if([_delegate respondsToSelector:@selector(shareEventWithView:type:)])
    {
        [_delegate shareEventWithView:self type:item.type];
    }
}
- (void)displayToWindow
{
    if (![WXApi isWXAppInstalled]) {
        [HUDManager showWarningWithText:@"没有安装微信"];
        return;
    }
    [KeyWindow addSubview:self];
    __weak typeof(self) weakSelf = self;
    [_contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).priority(750);
    }];
    [UIView animateWithDuration:0.25f animations:^{
        self.alpha = 1;
        [self layoutIfNeeded];
    }];
}
- (void)removeFromWindow
{
    __weak typeof(self) weakSelf = self;
    [_contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_bottom);
    }];
    [UIView animateWithDuration:0.25f animations:^{
        [self layoutIfNeeded];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (void)setDelegate:(id<ShareViewDelegate>)delegate
{
    _delegate = delegate;
}
@end


@implementation ShareItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(11)];
    }
    return self;
}
- (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image
                         type:(ShareTypes)type
{
    self = [super init];
    if(self)
    {
        [self setTitle:title forState:UIControlStateNormal];
        [self setImage:image forState:UIControlStateNormal];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        _type = type;
    }
    return self;
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return (CGRect){0, contentRect.size.height * 0.7f, contentRect.size.width, contentRect.size.height * 0.3f};

}
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return (CGRect){0, 0, contentRect.size.width, contentRect.size.height * 0.7f};
}
@end
