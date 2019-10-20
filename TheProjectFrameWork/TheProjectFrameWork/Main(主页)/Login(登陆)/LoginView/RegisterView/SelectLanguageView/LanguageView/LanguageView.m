//
//  LanguageView.m
//  test
//
//  Created by ZengPengYuan on 16/6/24.
//  Copyright © 2016年 ZengPengYuan. All rights reserved.
//

#import "LanguageView.h"
@interface LanguageView ()
{
    UIImage * _image;
    UIImage * _selectImg;
    UIColor * _titleColor;
    BOOL _selectStatus;
    
    UILabel * _countryLabel;
    UIImageView * _countryImage;
    UIImageView * _selectImage;
}

@end
@implementation LanguageView

- (instancetype)initWithImage:(UIImage *)image
                        title:(NSString *)title
{
    self = [super init];
    if(self)
    {

        [self titleChangeEnumWithTitle:title];
        _selectImg = [UIImage imageNamed:@"launchSelect"];
        _countryImage.image = image;
        _countryLabel.text = title;
        _title = title;
        _countryLabel.textColor = kNavigationColor;

    }
    return self;
}
- (instancetype)initWithImage:(UIImage *)image
                        title:(NSString *)title
                        titleColor:(UIColor *)color
{
    self = [super init];
    if(self)
    {
        [self titleChangeEnumWithTitle:title];
        if([image isEqual:[UIImage imageNamed:@"zhongguo"]])
        {
            _language = LanguageTypesChinese;
        }
        if([image isEqual:[UIImage imageNamed:@"mlxyy"]])
        {
            _language = LanguageTypesMalas;
        }
        if([image isEqual:[UIImage imageNamed:@"yinwen"]])
        {
            _language = LanguageTypesEnglish;
        }
        self.backgroundColor = [UIColor clearColor];
        _countryLabel.textColor = color;
        _countryImage.image = image;
        _countryLabel.text = title;
        _title = title;
        _selectImg = [UIImage imageNamed:@"launchSelect"];
    }
    return self;
}
- (void)setStatusWithBool:(BOOL)status
{
    _selectStatus = status;
    if(_selectStatus)
    {

        _selectImage.image = _selectImg;
    }else
    {
        _selectImage.image = nil;

    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   
    if([self.delegate respondsToSelector:@selector(languageWithCurrentLanguage:)]) [self.delegate languageWithCurrentLanguage:_language];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _countryImage = [[UIImageView alloc] init];
        _countryLabel = [[UILabel alloc] initWithText:nil];
        _selectImage = [[UIImageView alloc] init];
        [self addSubview:_countryLabel];
        [self addSubview:_countryImage];
        [self addSubview:_selectImage];
        [self setupInit];
    }
    return self;
}

- (void)setupInit
{
    __weak typeof(self) weakSelf = self;
    [_countryImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).mas_offset(5);
        make.centerX.equalTo(weakSelf);
        
    }];
    [_countryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.equalTo(weakSelf);
        make.top.equalTo(_countryImage.mas_bottom).mas_offset(5);
    }];
    [_selectImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@15);
        make.width.equalTo(_selectImage.mas_height);
       make.left.equalTo(_countryImage.mas_right).mas_offset(-8);
        make.bottom.equalTo(_countryImage.mas_top).mas_offset(8);
    }];
}
#pragma mark - private
- (void)titleChangeEnumWithTitle:(NSString *)title
{
    if([title isEqualToString:@"马来语"])
    {
        _language = LanguageTypesMalas;
    }
    if([title isEqualToString:@"中文"])
    {
        _language = LanguageTypesChinese;
    }
    if([title isEqualToString:@"英语"])
    {
        _language = LanguageTypesEnglish;
    }
}
@end
