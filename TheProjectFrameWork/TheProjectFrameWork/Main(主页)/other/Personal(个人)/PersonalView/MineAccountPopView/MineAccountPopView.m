//
//  MineAccountPopView.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/18.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "MineAccountPopView.h"
#import "CalendarDate.h"
#import "RegisterTextField.h"
#import "CountDownButton.h"
#import "AccountCellModel.h"
#import "NSString+Validation.h"
@interface MineAccountPopView ()
{
    UIButton * _cancelButton;
    UIButton * _saveButton;
}
@end
@implementation MineAccountPopView
- (instancetype)initWithType:(NSInteger)type
{
    self = [super init];
    if(self)
    {
    _type = type;
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        
        UILabel * titleLabel = [[UILabel alloc] initWithText:nil];
        titleLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(15)];
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIView * line = [UIView new];
        line.backgroundColor = [UIColor colorWithString:@"#cccccc"];
        [self.contentView addSubview:titleLabel];
        [self.contentView addSubview:_cancelButton];
        [self.contentView addSubview:_saveButton];
        [self.contentView addSubview:line];
        _titleLabel = titleLabel;
        __weak typeof(self) weakSelf = self;
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(weakSelf.contentView);
            make.height.mas_equalTo(kScaleHeight(30));
        }];
        [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.equalTo(weakSelf.contentView);
            make.right.equalTo(_saveButton.mas_left).mas_offset(0.5f);
            make.height.mas_equalTo(kScaleHeight(35));
        }];
        [_saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.equalTo(weakSelf.contentView);
            make.width.equalTo(_cancelButton.mas_width);
            make.height.equalTo(_cancelButton.mas_height);
        }];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(_saveButton.mas_height);
            make.width.mas_equalTo(0.5f);
            make.left.equalTo(_cancelButton.mas_right);
            make.bottom.equalTo(weakSelf.contentView.mas_bottom);
        }];
        _titleLabel.backgroundColor = [UIColor colorWithString:@"#c90c1e"];
        _titleLabel.textColor = [UIColor whiteColor];
        [_cancelButton setTitle:[LaguageControl languageWithString:@"取消"] forState:UIControlStateNormal];
        [_saveButton setTitle:[LaguageControl languageWithString:@"保存"] forState:UIControlStateNormal];
        
        [_cancelButton addTarget:self action:@selector(removeFromWindow) forControlEvents:UIControlEventTouchUpInside];
        [_saveButton addTarget:self action:@selector(saveEvent) forControlEvents:UIControlEventTouchUpInside];
        _cancelButton.backgroundColor = [UIColor colorWithString:@"#eeeeee"];
        _saveButton.backgroundColor = _cancelButton.backgroundColor;
        [_cancelButton setTitleColor:[UIColor colorWithString:@"#333333"] forState:UIControlStateNormal];
        [_saveButton setTitleColor:[UIColor colorWithString:@"#333333"] forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(14)];
        _saveButton.titleLabel.font = _cancelButton.titleLabel.font;
    }
    return self;
}
- (void)saveEvent
{

}

- (void)setTitle:(NSString *)title
{
    _titleLabel.text = [LaguageControl languageWithString:title];
    _title = [LaguageControl languageWithString:title];
}
@end



@interface AccountNamePopView ()
{
    UITextField * _nameTextField;
}
@end
@implementation AccountNamePopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _nameTextField = [[UITextField alloc] init];
        UILabel * promptLabel = [[UILabel alloc] initWithText:@"不超过20个字符"];
        promptLabel.numberOfLines = 0;
        promptLabel.textAlignment = NSTextAlignmentLeft;
        UIView * line = [[UIView alloc] init];
        line.backgroundColor = [UIColor colorWithString:@"#c90c1e"];
        _nameTextField.font = [UIFont systemFontOfSize:kAppAsiaFontSize(14)];
        _nameTextField.placeholder = [LaguageControl languageWithString:@"请输入姓名"];
        promptLabel.textColor = [UIColor colorWithString:@"#999999"];
        [self.contentView addSubview:_nameTextField];
        [self.contentView addSubview:promptLabel];
        [self.contentView addSubview:line];
        
        __weak typeof(self) weakSelf = self;
        [_nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.contentView.mas_left).mas_offset(kScaleWidth(20));
            make.right.equalTo(weakSelf.contentView.mas_right).mas_offset(-kScaleWidth(20));
            make.top.equalTo(weakSelf.titleLabel.mas_bottom).mas_offset(kScaleHeight(25));

        }];
        [promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(line.mas_bottom).mas_offset(kScaleHeight(5));
            make.left.equalTo(line.mas_left);
            make.right.lessThanOrEqualTo(weakSelf.mas_right).mas_offset(-kScaleWidth(8));
        }];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.contentView);
            make.width.equalTo(weakSelf.contentView.mas_width).mas_offset(-kScaleWidth(16));
            make.height.mas_equalTo(1);
            make.top.equalTo(_nameTextField.mas_bottom).mas_offset(kScaleHeight(16));
        }];
        weakSelf.title = [LaguageControl languageWithString:@"姓名"];
    }
    return self;
    
}
- (void)saveEvent
{
    if([self.delegate respondsToSelector:@selector(accountPop:SaveInfo:)])
    {
        if(_nameTextField.text.length < 2 || _nameTextField.text.length>20)
        {
            [HUDManager showWarningWithText:@"真实姓名输入2-20个字符的"];
            return;
        }
        self.model.prompt = _nameTextField.text;
        [self.delegate accountPop:self SaveInfo:self.model];
    }
}
@end



@interface AccountSexPopView ()
{
    UIButton * manButton;
    UIButton * womanButton;
    UIButton * baomiButton;
    UIButton * selectButton;
}
@end
@implementation AccountSexPopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        UILabel * manLabel = [[UILabel alloc] initWithText:@"男"];
        UILabel * womanLabel = [[UILabel alloc] initWithText:@"女"];
        UILabel * baomiLabel = [[UILabel alloc] initWithText:@"保密"];

        UIView * topLine = [UIView new];
        UIView * bottomLine = [UIView new];
        UIView * lastLine = [UIView new];
        
        manButton = [UIButton buttonWithType:UIButtonTypeCustom];
        womanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        baomiButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        topLine.backgroundColor = [UIColor colorWithString:@"#c90c1e"];
        bottomLine.backgroundColor = topLine.backgroundColor;
        lastLine.backgroundColor = topLine.backgroundColor;
        
        manLabel.textColor = [UIColor colorWithString:@"#333333"];
        womanLabel.textColor = [UIColor colorWithString:@"#333333"];
        baomiLabel.textColor = manLabel.textColor;
        
        [self.contentView addSubview:manLabel];
        [self.contentView addSubview:womanLabel];
        [self.contentView addSubview:baomiLabel];
        
        [self.contentView addSubview:topLine];
        [self.contentView addSubview:bottomLine];
        [self.contentView addSubview:lastLine];
        
        [self.contentView addSubview:manButton];
        [self.contentView addSubview:womanButton];
        [self.contentView addSubview:baomiButton];
        
        [manButton setImage:[UIImage imageNamed:@"Sexxuanzhong"] forState:UIControlStateSelected];
        [manButton setImage:[UIImage imageNamed:@"Sexweixuanzhong"] forState:UIControlStateNormal];
        [womanButton setImage:[UIImage imageNamed:@"Sexxuanzhong"] forState:UIControlStateSelected];
        [womanButton setImage:[UIImage imageNamed:@"Sexweixuanzhong"] forState:UIControlStateNormal];
        [baomiButton setImage:[UIImage imageNamed:@"Sexxuanzhong"] forState:UIControlStateSelected];
        [baomiButton setImage:[UIImage imageNamed:@"Sexweixuanzhong"] forState:UIControlStateNormal];
        
        manButton.imageView.contentMode = UIViewContentModeCenter;
        baomiButton.imageView.contentMode = UIViewContentModeCenter;
        
        [manButton addTarget:self action:@selector(selectSexWithButton:) forControlEvents:UIControlEventTouchUpInside];
        [womanButton addTarget:self action:@selector(selectSexWithButton:) forControlEvents:UIControlEventTouchUpInside];
        [baomiButton addTarget:self action:@selector(selectSexWithButton:) forControlEvents:UIControlEventTouchUpInside];
        
        __weak typeof(self) weakSelf = self;
        [manLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.contentView);
            make.top.equalTo(weakSelf.titleLabel.mas_bottom).mas_offset(kScaleHeight(10));
        }];
        [womanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.contentView);
            make.top.equalTo(topLine.mas_bottom).mas_offset(kScaleHeight(10));
        }];
        [baomiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.contentView);
            make.top.equalTo(bottomLine.mas_bottom).mas_offset(kScaleHeight(10));
        }];
        
        
        [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(manLabel.mas_bottom).mas_offset(kScaleHeight(10));
            make.centerX.equalTo(weakSelf.contentView);
            make.width.equalTo(weakSelf.contentView.mas_width).mas_offset(-kScaleWidth(16));
            make.height.mas_equalTo(1);
        }];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(womanLabel.mas_bottom).mas_offset(kScaleHeight(10));
            make.centerX.equalTo(weakSelf.contentView);
            make.width.equalTo(weakSelf.contentView.mas_width).mas_offset(-kScaleWidth(16));
            make.height.mas_equalTo(1);
        }];
        [lastLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(baomiLabel.mas_bottom).mas_offset(kScaleHeight(10));
            make.centerX.equalTo(weakSelf.contentView);
            make.width.equalTo(weakSelf.contentView.mas_width).mas_offset(-kScaleWidth(16));
            make.height.mas_equalTo(1);
            
        }];
        
        
        [manButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.contentView.mas_right).mas_offset(-kScaleWidth(40));
            make.centerY.equalTo(manLabel);
        }];
        [womanButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.contentView.mas_right).mas_offset(-kScaleWidth(40));
            make.centerY.equalTo(womanLabel);
        }];
        [baomiButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.contentView.mas_right).mas_offset(-kScaleWidth(40));
            make.centerY.equalTo(baomiLabel);
        }];
        weakSelf.title = [LaguageControl languageWithString:@"性别"];
    }
    return self;
}
- (void)selectSexWithButton:(UIButton *)sender
{
    selectButton.selected = NO;
    sender.selected = !sender.selected;
    selectButton = sender;
}
- (void)saveEvent
{
    if([self.delegate respondsToSelector:@selector(accountPop:SaveInfo:)])
    {
        if(manButton.selected == NO && womanButton.selected == NO)
        {
            
        }
        if (manButton.selected) {
            
            self.model.prompt = @"男";
            [self.delegate accountPop:self SaveInfo:self.model];

            
        }else if (womanButton.selected){
            self.model.prompt = @"女";
            [self.delegate accountPop:self SaveInfo:self.model];

            
        }else if (baomiButton.selected){
            self.model.prompt = @"保密";
            [self.delegate accountPop:self SaveInfo:self.model];

        }else{
            [HUDManager showWarningWithText:LaguageControl(@"请选择性别")];
            return;

        }
    }
}
@end



@interface AccountBirthPopView ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSArray * days;
    NSArray * months;
    NSArray * years;
    NSInteger month;
    NSInteger year;
    NSInteger selectDay;
    UIPickerView * _birth;
}
@end

@implementation AccountBirthPopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        
        UIPickerView * birth = [[UIPickerView alloc] init];
        birth.delegate = self;
        [self.contentView addSubview:birth];
        __weak typeof(self) weakSelf = self;
        [birth mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.titleLabel.mas_bottom);
            make.bottom.equalTo(weakSelf.contentView.mas_bottom).mas_offset(-kScaleHeight(35));
            make.right.equalTo(weakSelf.contentView.mas_right).mas_offset(-kScaleWidth(25));
            make.left.equalTo(weakSelf.contentView.mas_left).mas_offset(kScaleWidth(25));
        }];
        NSDateComponents * components = [CalendarDate currentDate];
        days = [CalendarDate daysWithYear:components.year month:components.month];
        months = [CalendarDate monthWithYear:1 month:1];
        
        years = [CalendarDate yearWithYear:components.year];

        
        NSString *currentmont = [NSString stringWithFormat:@"%02ld",(long)components.month ];
        NSString *currentday = [NSString stringWithFormat:@"%02ld",(long)components.day ];
        NSString *currentyear = [NSString stringWithFormat:@"%04ld",(long)components.year ];

        NSInteger row0 = [years indexOfObject:currentyear];
        NSInteger row1 = [months indexOfObject:currentmont];
        NSInteger row2 = [days indexOfObject:currentday];
        
        [birth selectRow:row0 inComponent:0 animated:YES];
        [birth selectRow:row1 inComponent:1 animated:YES];
        [birth selectRow:row2 inComponent:2 animated:YES];

        month = [months[row1] integerValue];
        year = [years[0] integerValue];
        selectDay = row2+1;
        _birth = birth;
        self.title = [LaguageControl languageWithString:@"出生日期"];
    }
    return self;
}
#pragma mark - UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    /**
     *  年／月／日
     */
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return 167;
         case 1:
            return 12;
        case 2:
            return days.count;
        default:
            break;
    }
    return 0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel * label = (UILabel *)view;
    if (label == nil) {
        label = [[UILabel alloc] initWithText:nil];
        label.font = [UIFont systemFontOfSize:kAppAsiaFontSize(14)];
        label.textColor = [UIColor colorWithString:@"#333333"];
    }
    switch (component) {
        case 0:
            label.text = [NSString stringWithFormat:@"%@",years[row]];
            break;
        case 1:
            label.text = [NSString stringWithFormat:@"%@",months[row]];
            break;
        case 2:
            label.text = [NSString stringWithFormat:@"%@",days[row]];
            break;
        default:
            break;
    }
    return label;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(component == 2)
    {
        selectDay = [days[row] integerValue];
        return;
    }
    if (component == 1)
    {
        month = [months[row] integerValue];
    }
    if(component == 0)
    {
        year = [years[row] integerValue];
    }
     days = [CalendarDate daysWithYear:year month:month];
    // 刷新天数的数据
    [pickerView reloadComponent:2];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return kScaleHeight(50);
}
- (void)saveEvent
{
//    NSDateComponents * components = [CalendarDate currentDate];

//    if (!(month<=components.month && selectDay <= components.day)) {
//        [HUDManager showWarningWithText:@"请选择正确日期"];
//        return;
//    }
    if([self.delegate respondsToSelector:@selector(accountPop:SaveInfo:)])
    {
        self.model.prompt = [CalendarDate year:year month:month day:selectDay];
        [self.delegate accountPop:self SaveInfo:self.model];
    }
}

@end


@interface AccountQiXianPopView ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSArray * days;
    NSArray * months;
    NSArray * years;
    NSInteger month;
    NSInteger year;
    NSInteger selectDay;
    UIPickerView * _birth;
}
@end
@implementation AccountQiXianPopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        
        UIPickerView * birth = [[UIPickerView alloc] init];
        birth.delegate = self;
        [self.contentView addSubview:birth];
        __weak typeof(self) weakSelf = self;
        [birth mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.titleLabel.mas_bottom);
            make.bottom.equalTo(weakSelf.contentView.mas_bottom).mas_offset(-kScaleHeight(35));
            make.right.equalTo(weakSelf.contentView.mas_right).mas_offset(-kScaleWidth(25));
            make.left.equalTo(weakSelf.contentView.mas_left).mas_offset(kScaleWidth(25));
        }];
        NSDateComponents * components = [CalendarDate currentDate];
        days = [CalendarDate daysWithYear:components.year month:components.month];
        months = [CalendarDate monthWithYear:1 month:1];
        
        years = [CalendarDate yearWithYear:2100];
        
        
        NSString *currentmont = [NSString stringWithFormat:@"%02ld",(long)components.month ];
        NSString *currentday = [NSString stringWithFormat:@"%02ld",(long)components.day ];
        NSString *currentyear = [NSString stringWithFormat:@"%04ld",(long)components.year ];
        
        NSInteger row0 = [years indexOfObject:currentyear];
        NSInteger row1 = [months indexOfObject:currentmont];
        NSInteger row2 = [days indexOfObject:currentday];
        
        [birth selectRow:row0 inComponent:0 animated:YES];
        [birth selectRow:row1 inComponent:1 animated:YES];
        [birth selectRow:row2 inComponent:2 animated:YES];
        
        month = [months[row1] integerValue];
        year = [years[row0] integerValue];
        selectDay = row2+1;
        _birth = birth;
        self.title = [LaguageControl languageWithString:@"营业期限"];
    }
    return self;
}
#pragma mark - UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    /**
     *  年／月／日
     */
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return 167;
        case 1:
            return 12;
        case 2:
            return days.count;
        default:
            break;
    }
    return 0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel * label = (UILabel *)view;
    if (label == nil) {
        label = [[UILabel alloc] initWithText:nil];
        label.font = [UIFont systemFontOfSize:kAppAsiaFontSize(14)];
        label.textColor = [UIColor colorWithString:@"#333333"];
    }
    switch (component) {
        case 0:
            label.text = [NSString stringWithFormat:@"%@",years[row]];
            break;
        case 1:
            label.text = [NSString stringWithFormat:@"%@",months[row]];
            break;
        case 2:
            label.text = [NSString stringWithFormat:@"%@",days[row]];
            break;
        default:
            break;
    }
    return label;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(component == 2)
    {
        selectDay = [days[row] integerValue];
        return;
    }
    if (component == 1)
    {
        month = [months[row] integerValue];
    }
    if(component == 0)
    {
        year = [years[row] integerValue];
    }
    days = [CalendarDate daysWithYear:year month:month];
    // 刷新天数的数据
    [pickerView reloadComponent:2];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return kScaleHeight(50);
}
- (void)saveEvent
{
    NSDateComponents * components = [CalendarDate currentDate];
    
    if (self.isweilai) {
        if (year < components.year ) {
            [HUDManager showWarningWithText:@"请选择正确日期"];
            return;
        }else if(year == components.year){
            if (month<components.month) {
                [HUDManager showWarningWithText:@"请选择正确日期"];
                return;
            }else if (month == components.month){
                if (selectDay <= components.day) {
                    [HUDManager showWarningWithText:@"请选择正确日期"];
                    return;
                }
            }
        }
 
    }else{
        
        
    }
    
    if([self.delegate respondsToSelector:@selector(accountPop:SaveInfo:)])
    {
        self.model.prompt = [CalendarDate year:year month:month day:selectDay];
        [self.delegate accountPop:self SaveInfo:self.model];
    }
}


@end

@interface AccountPhonePopView ()
{
    UITextField * _phoneTextField;
    RegisterTextField * _validationTextField;
    CountDownButton * _countDownButton;
}
@end
@implementation AccountPhonePopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _phoneTextField = [[UITextField alloc] init];
       
        UIView * line = [[UIView alloc] init];
        line.backgroundColor = [UIColor colorWithString:@"#c90c1e"];
        _phoneTextField.font = [UIFont systemFontOfSize:kAppAsiaFontSize(14)];
        _phoneTextField.placeholder = [LaguageControl languageWithString:@"请输入手机号"];
        _validationTextField = [[RegisterTextField alloc] initWithPlaceholder:@"请输入验证码" isVerify:NO];
        _countDownButton = [[CountDownButton alloc] initWithInterval:60 Target:self Sel:@selector(sendVerificationCode)];
        [self.contentView addSubview:_phoneTextField];
        [self.contentView addSubview:line];
        [self.contentView addSubview:_validationTextField];
        [self.contentView addSubview:_countDownButton];
        __weak typeof(self) weakSelf = self;
        [_phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.contentView.mas_left).mas_offset(kScaleWidth(20));
            make.right.equalTo(weakSelf.contentView.mas_right).mas_offset(-kScaleWidth(20));
            make.top.equalTo(weakSelf.titleLabel.mas_bottom).mas_offset(kScaleHeight(25));
            
        }];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.contentView);
            make.width.equalTo(weakSelf.contentView.mas_width).mas_offset(-kScaleWidth(16));
            make.height.mas_equalTo(1);
            make.top.equalTo(_phoneTextField.mas_bottom).mas_offset(kScaleHeight(16));
        }];
        [_validationTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.contentView.mas_left).mas_offset(kScaleWidth(8));
            make.top.equalTo(line.mas_bottom).mas_offset(kScaleHeight(10));
            make.height.mas_equalTo(kScaleHeight(40));
            make.width.equalTo(weakSelf.contentView.mas_width).multipliedBy(0.6f);
        }];
        [_countDownButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.contentView.mas_right).mas_offset(-kScaleWidth(8));
            make.top.equalTo(_validationTextField.mas_top);
            make.height.equalTo(_validationTextField.mas_height);
            make.left.equalTo(_validationTextField.mas_right).mas_offset(kScaleWidth(5));
            
        }];
        weakSelf.title = [LaguageControl languageWithString:@"手机号"];

    }
    return self;
}
- (void)saveEvent
{
    
    if(_phoneTextField.text.length < 11)
    {
        [HUDManager showWarningWithText:@"请输入正确的手机号"];
        return;
    }
    if([self.delegate respondsToSelector:@selector(accountPop:SaveInfo:)])
    {
        self.model.prompt = _phoneTextField.text;
        [self.delegate accountPop:self SaveInfo:_phoneTextField.text];
    }
}
/**
 *  发送验证码
 */
- (void)sendVerificationCode
{
    if([self.delegate respondsToSelector:@selector(accountPop:GetCode:)])
    {
        [self.delegate accountPop:self GetCode:_countDownButton];
    }
}
@end


@interface AccountEmailPopView ()
{
    UITextField * _emailTextField;
    RegisterTextField * _validationTextField;
    CountDownButton * _countDownButton;
}
@end
@implementation AccountEmailPopView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        _emailTextField = [[UITextField alloc] init];
        UIView * line = [[UIView alloc] init];
        line.backgroundColor = [UIColor colorWithString:@"#c90c1e"];
        _emailTextField.font = [UIFont systemFontOfSize:kAppAsiaFontSize(14)];
        _emailTextField.placeholder = [LaguageControl languageWithString:[LaguageControl languageWithString:@"请输入电子邮箱号"]];
        _validationTextField = [[RegisterTextField alloc] initWithPlaceholder:@"请输入验证码" isVerify:NO];
        _countDownButton = [[CountDownButton alloc] initWithInterval:60 Target:self Sel:@selector(sendVerificationCode)];
        [self.contentView addSubview:_emailTextField];
        [self.contentView addSubview:line];
        [self.contentView addSubview:_validationTextField];
        [self.contentView addSubview:_countDownButton];
        __weak typeof(self) weakSelf = self;
        [_emailTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.contentView.mas_left).mas_offset(kScaleWidth(20));
            make.right.equalTo(weakSelf.contentView.mas_right).mas_offset(-kScaleWidth(20));
            make.top.equalTo(weakSelf.titleLabel.mas_bottom).mas_offset(kScaleHeight(25));
            
        }];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.contentView);
            make.width.equalTo(weakSelf.contentView.mas_width).mas_offset(-kScaleWidth(16));
            make.height.mas_equalTo(1);
            make.top.equalTo(_emailTextField.mas_bottom).mas_offset(kScaleHeight(16));
        }];
        [_validationTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.contentView.mas_left).mas_offset(kScaleWidth(8));
            make.top.equalTo(line.mas_bottom).mas_offset(kScaleHeight(10));
            make.height.mas_equalTo(kScaleHeight(40));
            make.width.equalTo(weakSelf.contentView.mas_width).multipliedBy(0.6f);
        }];
        [_countDownButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(weakSelf.contentView.mas_right).mas_offset(-kScaleWidth(8));
            make.top.equalTo(_validationTextField.mas_top);
            make.height.equalTo(_validationTextField.mas_height);
            make.left.equalTo(_validationTextField.mas_right).mas_offset(kScaleWidth(5));
        }];
        weakSelf.title = [LaguageControl languageWithString:@"邮箱"];
        
    }
    return self;
}
/**
 *  发送验证码
 */
- (void)sendVerificationCode
{
    if(![NSString validateEmail:_emailTextField.text])
    {
        [HUDManager showWarningWithText:@"请输入正确电子邮箱"];
        return;
    }
    [HUDManager showLoadingHUDView:Kwindow withText:@"请稍等"];
    [NetWork PostNetWorkWithUrl:@"/sendEmail" with:@{@"email":_emailTextField.text,@"type":@"email_bing_email_notify"} successBlock:^(NSDictionary *dic) {
        NSString *code;
        code = dic[@"message"];
        [HUDManager hideHUDView];
        [_countDownButton startTimer];
    } FailureBlock:^(NSString *msg) {
        [HUDManager hideHUDView];
        [HUDManager showWarningWithError:msg];
    } errorBlock:^(id error) {
        [HUDManager hideHUDView];
        [HUDManager showWarningWithError:error];
    }];
    
    if([self.delegate respondsToSelector:@selector(accountPop:GetCode:)])
    {
        [self.delegate accountPop:self GetCode:_countDownButton];
    }
}
- (void)saveEvent
{
    if(![NSString validateEmail:_emailTextField.text])
    {
        [HUDManager showWarningWithText:@"请输入正确电子邮箱"];
        return;
    }
    if (_validationTextField.text.length == 0) {
        [HUDManager showWarningWithText:@"请输入验证码"];
        return;
    }
    [NetWork PostNetWorkWithUrl:@"/buyer/validation_email" with:@{@"email":_emailTextField.text,@"code":_validationTextField.text} successBlock:^(NSDictionary *dic) {
        if([dic[@"status"] boolValue])
        {
            if([self.delegate respondsToSelector:@selector(accountPop:SaveInfo:)])
            {
                if (!self.model) {
                    self.model  = [[AccountCellModel alloc]init];
                }
                self.model.prompt = _emailTextField.text;
                [self.delegate accountPop:self SaveInfo:self.model];
            }
        }else
        {
            [HUDManager showWarningWithText:dic[@"message"]];
        }
    } FailureBlock:^(NSString *msg) {
        [HUDManager showWarningWithText:msg];
    } errorBlock:^(id error) {
        [HUDManager showWarningWithText:@"未知错误"];
    }];

}

- (void)validationEmail:(NSString *)email code:(NSString *)code completed:(void (^) (BOOL successful , id error))completed
{
}


@end
