//
//  MineTableViewHeaderView.m
//  test
//
//  Created by TheMacBook on 16/6/28.
//  Copyright © 2016年 TheMacBook. All rights reserved.
//

#import "MineTableViewHeaderView.h"
#import "MineIconView.h"
#import "MineAssistView.h"
#import "MineHeaderLanguageView.h"
#import "MineShopHeaderCell.h"

@interface MineTableViewHeaderView ()<MineIconViewDelegate,MineHeaderLanguageViewDelegate,MineAssistViewDelegate,MineShopHeaderButtonDelegate>
{
    MineIconView * _iconImage; ///< 用户头像信息之类
    MineAssistView * _assistView; ///< 关注的商品之类
    MineHeaderLanguageView * _languageView; ///< 选择语言
    MineShopHeaderButton * _accountManager; ///< 账户管理
}
@end
@implementation MineTableViewHeaderView

- (instancetype)initWithUserModel:(UserModel *)model
{
    self = [super init];
    if(self)
    {
        self.backgroundColor = [UIColor blackColor];
        _iconImage = [[MineIconView alloc] init];
        
        
        _iconImage.userName =  model.username ;

        _iconImage.userRank = model.userRank ;
        _iconImage.image = [UIImage imageNamed:@"buyerIcon"];
        _assistView = [[MineAssistView alloc] initWithModel:nil];
        _languageView = [[MineHeaderLanguageView alloc] initWithCurretnStr:nil];
        _accountManager = [[MineShopHeaderButton alloc] init];
        _accountManager.delegate = self;
        _languageView.delegate = self;
        _assistView.delegate = self;
        _accountManager.title = [LaguageControl languageWithString:@"账户管理"];
        _accountManager.font = [UIFont systemFontOfSize:kAppAsiaFontSize(13)];
        _accountManager.hidden = ![UserAccountManager shareUserAccountManager].loginStatus;
        //TODO: 控制隐藏语言控制切换
        _languageView.userInteractionEnabled = !kHideLanguageController;
        _languageView.hidden = YES;
        [self setup];
    }
    return self;
}

/**
 *  更新视图内容方法
 */
- (void)updateViewInfo
{
    [_iconImage setNeedsDisplay];
    [_assistView loadWithModel:nil];
    _accountManager.title = @"账户管理";
    if([UserAccountManager shareUserAccountManager].userModel.iconUrl)
    {
        
        
        [NetWork loadImageWithUrl:[UserAccountManager shareUserAccountManager].userModel.iconUrl ImageDownloaderProgressBlock:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } ImageCompletionWithFinishedBlock:^(UIImage *image, NSError *error, BOOL finished, NSURL *imageURL) {
            if(!error && image)
            {
                _iconImage.image = image;
                _iconImage.userName = [UserAccountManager shareUserAccountManager].userModel.username;
                [_iconImage setNeedsDisplay];
            }else
            {
                _iconImage.image = [UIImage imageNamed:@"buyerIcon"];
            }
        }];
    }else
    {
        _iconImage.image = [UIImage imageNamed:@"buyerIcon"];
    }
    _accountManager.hidden = ![UserAccountManager shareUserAccountManager].loginStatus;
}
- (void)setup
{
    UIImageView * back = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"minebeijing"]];
    [self addSubview:back];
    [self addSubview:_iconImage];
    [self addSubview:_assistView];
    [self addSubview:_languageView];
    [self addSubview:_accountManager];
    _iconImage.delegate = self;
    __weak typeof(self) weakSelf = self;
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).mas_offset(kScaleWidth(20)).priority(750);
        make.height.equalTo(weakSelf.mas_height).multipliedBy(0.45f);
        make.width.equalTo(weakSelf.mas_width).multipliedBy(0.618f);
        make.centerY.equalTo(weakSelf.mas_centerY).mas_offset(-kScaleHeight(10));
    }];
    [_assistView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.left.equalTo(weakSelf);
        make.height.mas_equalTo(kScaleHeight(40));
    }];
    [_languageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_centerY).mas_offset(-kScaleHeight(6));
        make.right.equalTo(weakSelf.mas_right).mas_offset(-10);
        make.height.mas_equalTo(kScaleHeight(25));
    }];
    [_accountManager mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_centerY).mas_offset(kScaleHeight(6));
        make.right.equalTo(weakSelf.mas_right).mas_offset(-10);
        make.height.mas_equalTo(kScaleHeight(25));
    }];
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    [self settingLanguage:[LaguageControl shareControl].type];
}
- (void)clickMineShopHeader:(MineShopHeaderButton *)sender
{
    [self accountManager];
}
- (void)settingLanguage:(LanguageTypes)language
{
    switch (language) {
        case LanguageTypesChinese:
        {
            _languageView.currentImage = [UIImage imageNamed:@"zhongguo"];
            _languageView.currentTitle = @"中文";
        }
            break;
        case LanguageTypesMalas:
        {
            _languageView.currentImage = [UIImage imageNamed:@"mlxyy"];
            _languageView.currentTitle = @"Melayu";
        }
            break;
        case LanguageTypesEnglish:
        {
            _languageView.currentImage = [UIImage imageNamed:@"yinwen"];
            _languageView.currentTitle = @"English";
        }
            break;
        default:
            break;
    }
}
- (void)settingUserIconWithImage:(UIImage *)image
{
    _iconImage.image = image;
    [self updateViewInfo];
}
#pragma mark - event respond
- (void)accountManager
{
    if([_delegate respondsToSelector:@selector(mineTableViewHeaderAccountManager)])
    {
        [_delegate mineTableViewHeaderAccountManager];
    }
}
#pragma mark - delegates
- (void)iconClickIconEvent
{
    if([_delegate respondsToSelector:@selector(headerClickIcon)])
    {
        [self.delegate headerClickIcon];
    }
}
- (void)mineHeaderLanguage:(LanguageTypes)language
{
    if([_delegate respondsToSelector:@selector(mineTableViewHeader:Language:)])
    {
        [_delegate mineTableViewHeader:self Language:language];
    }
}
- (void)mineAssistView:(MineAssistView *)view type:(NSInteger)type
{
    if([_delegate respondsToSelector:@selector(mineTableViewHeaderAssisClickWithType:)])
    {
        [_delegate mineTableViewHeaderAssisClickWithType:type];
    }
}
@end
