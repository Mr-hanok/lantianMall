//
//  SelectLanguageView.m
//  test
//
//  Created by ZengPengYuan on 16/6/24.
//  Copyright © 2016年 ZengPengYuan. All rights reserved.
//

#import "SelectLanguageView.h"
#import "LanguageView.h"
@interface SelectLanguageView ()<LanguageViewDelegate>
{
    UILabel * _label;
}

@end

@implementation SelectLanguageView

- (instancetype)initWithImageArray:(NSArray *)imageArray
                            titles:(NSArray *)titleArray
{
    self = [super init];
    if(self)
    {
        _imageArray = imageArray;
        _titleArray = titleArray;
        _label = [UILabel new];
        _label.font = [UIFont systemFontOfSize:kAppAsiaFontSize(12)];
        [self addSubview:_label];
        _label.text = @"默认语言设置:";
        [self setup];
    }
    return self;
}
- (void)setup
{
    __weak __typeof__(self) weakSelf = self;
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(weakSelf);
    }];
    __block UIView * lastView = nil;
    [_imageArray enumerateObjectsUsingBlock:^(UIImage *  _Nonnull image, NSUInteger idx, BOOL * _Nonnull stop) {
        LanguageView * view = [[LanguageView alloc] initWithImage:image title:_titleArray[idx]];
        view.delegate = self;
        [weakSelf addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            if(lastView)
            {
                make.left.equalTo(lastView.mas_right).mas_offset(15).priority(750);
                make.width.equalTo(lastView.mas_width);
            }else
            {
                make.left.equalTo(_label.mas_right).mas_offset(12).priority(500);
            }
            make.top.bottom.equalTo(weakSelf).priority(400);
        }];

        lastView = view;
    }];
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right);
    }];
}
- (void)languageWithCurrentLanguage:(LanguageTypes)language
{
    if([self.delegate respondsToSelector:@selector(selectLanguageCurrentLanguage:)])
    {
        [self.delegate selectLanguageCurrentLanguage:language];
    }
    for (id view in self.subviews) {
        if([view isKindOfClass:[LanguageView class]])
        {
            LanguageView * temp = view;
            if(temp.language ==language)
            {
                [temp setStatusWithBool:YES];
               
            }else
            {
                [temp setStatusWithBool:NO];
            }
        }
    }
}

@end
