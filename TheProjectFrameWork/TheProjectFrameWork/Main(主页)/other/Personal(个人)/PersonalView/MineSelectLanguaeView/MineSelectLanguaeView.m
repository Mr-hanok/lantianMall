//
//  MineSelectLanguaeView.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/1.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "MineSelectLanguaeView.h"
#import "LanguageView.h"
@interface MineSelectLanguaeView ()<LanguageViewDelegate>
{
    UIView * _contentView;
    NSString * _currentStr;
}
@end
@implementation MineSelectLanguaeView
- (instancetype)initWithCurrentTitle:(NSString *)title
{
    self = [super init];
    if(self)
    {
        _currentStr = title;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        NSArray * titles = @[@{@"image":[UIImage imageNamed:@"mlxyy"],@"title":@"Melayu"},@{@"image":[UIImage imageNamed:@"zhongguo"],@"title":@"中文"},@{@"image":[UIImage imageNamed:@"yinwen"],@"title":@"English"}];
        _contentView = [UIView new];
        [self addSubview:_contentView];
        __weak typeof(self) weakSelf = self;

        for (NSDictionary * dic in titles) {
            LanguageView * language = [[LanguageView alloc]initWithImage:dic[@"image"] title:dic[@"title"] titleColor:[UIColor blackColor]];
            
            language.delegate = self;
            if(language.language == [LaguageControl shareControl].type)
            {
                [language setStatusWithBool:YES];
            }
            [_contentView addSubview:language];
            [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.left.equalTo(weakSelf);
                make.top.equalTo(weakSelf.mas_top).priority(200);
                make.bottom.equalTo(weakSelf.mas_top).priority(300);
                make.height.mas_equalTo(KScreenBoundHeight*0.33);
            }];
        }
        UIView * otherView = [UIView new];
        [self addSubview:otherView];
        [otherView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.left.equalTo(weakSelf);
            make.top.equalTo(_contentView.mas_bottom);
        }];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endDidAppear)];
        [otherView addGestureRecognizer:tap];
        
        [self setup];

    }
    return self;
}

- (void)setup
{
    __weak typeof(_contentView) weakSelf = _contentView;
   _contentView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8f];
    __block UIView * lastView = nil;
    [_contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.mas_bottom).mas_offset(-15);
            make.height.equalTo(weakSelf.mas_height).multipliedBy(0.3);
           
           if(lastView)
           {
               make.width.equalTo(lastView.mas_width);
               make.left.equalTo(lastView.mas_right).mas_offset(40);
           }else
           {
               make.left.equalTo(weakSelf.mas_left).mas_offset(40);
           }
          
        }];
        lastView = view;

    }];
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.right.equalTo(weakSelf.mas_right).mas_offset(-40).priority(400);
    }];
    [_contentView layoutIfNeeded];
  
}
- (void)startAppear
{
    __weak typeof(self) weakSelf = self;
    [_contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).priority(500);
        make.bottom.equalTo(weakSelf.mas_top).priority(200);
    }];
    [UIView animateWithDuration:0.25f animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}
- (void)endDidAppear
{
    __weak typeof(self) weakSelf = self;
    [_contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).priority(200);
        make.bottom.equalTo(weakSelf.mas_top).priority(500);
    }];
    [UIView animateWithDuration:0.25f animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - languageDelegate
- (void)languageWithCurrentLanguage:(LanguageTypes)language
{
    for (LanguageView * view in _contentView.subviews) {
        if(view.language == language)
        {
            [view setStatusWithBool:YES];
            if([_delegate respondsToSelector:@selector(mineSelectLanguageWithLanguage:)])
            {
                [_delegate mineSelectLanguageWithLanguage:language];
            }
        }else
        {
            [view setStatusWithBool:NO];
        }
    }

}


@end
