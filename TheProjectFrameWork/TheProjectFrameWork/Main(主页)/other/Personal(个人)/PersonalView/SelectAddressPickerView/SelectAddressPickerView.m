//
//  SelectAddressPickerView.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 2017/2/14.
//  Copyright © 2017年 MapleDongSen. All rights reserved.
//

#import "SelectAddressPickerView.h"
#import "AreaModel.h"
@interface SelectAddressPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic , strong) NSArray <AreaModel *>* provinces;
@property (nonatomic , strong) NSArray <CityModel *>* citys;
@property (nonatomic , strong) NSArray <TownModel *>* counties;

@property (nonatomic , strong) NSDictionary * attributes;
@end
@implementation SelectAddressPickerView
{
    UIView * _contentView;
    UIToolbar * _toolbar;
    UIPickerView * _pickerView;
}
- (instancetype)initWithAreaInfos:(NSArray <AreaModel *>*)infos
{
    self = [super init];
    if(self)
    {
        _provinces = infos;
        if(infos[0].cities.count)
        {
            _citys = infos[0].cities;
            if(_citys[0].counties.count)
            {
                _counties = _citys[0].counties;
            }
        }
        [_pickerView reloadAllComponents];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    frame = kScreenFreameBound;
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor colorWithString:@"#686868120"];
        self.alpha = 0;
        _contentView = [UIView new];
        [self addSubview:_contentView];
        [self setup];
    }
    return self;
}
- (void)setup
{
    __weak typeof(self) weakSelf = self;
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf);
        make.top.equalTo(weakSelf.mas_bottom).priority(500);
        make.height.mas_equalTo(kScaleHeight(200));
    }];
    UIToolbar * tool = [[UIToolbar alloc] init];
    UIPickerView * picker = [[UIPickerView alloc] init];
    tool.backgroundColor = [UIColor whiteColor];
    picker.backgroundColor = [UIColor colorWithString:@"#cccccc"];
    picker.delegate = self;
    UIButton * cancelButton = [[UIButton alloc] initWithFrame:(CGRect){0,0,kScaleWidth(80),kScaleHeight(40)}];
    UIButton * sureButton = [[UIButton alloc] initWithFrame:(CGRect){0,0,kScaleWidth(80),kScaleHeight(40)}];
    [cancelButton setTitle:LaguageControl(@"取消") forState:UIControlStateNormal];
    [sureButton setTitle:LaguageControl(@"确定") forState:UIControlStateNormal];
    sureButton.titleLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(13)];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(13)];
    [cancelButton setTitleColor:[UIColor colorWithString:@"#C90C1E"] forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor colorWithString:@"#C90C1E"] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [sureButton addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * cancel = [[UIBarButtonItem alloc] initWithCustomView:cancelButton];
    UIBarButtonItem * space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem * sure = [[UIBarButtonItem alloc] initWithCustomView:sureButton];
    tool.items = @[cancel,space,sure];
    [_contentView addSubview:tool];
    [_contentView addSubview:picker];
    __weak typeof(_contentView) contentView = _contentView;
    [tool mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(contentView);
        make.height.mas_equalTo(kScaleHeight(40));
    }];
    [picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.equalTo(contentView);
        make.top.equalTo(tool.mas_bottom);
    }];
    _toolbar = tool;
    _pickerView = picker;
    [self layoutIfNeeded];
}
- (void)cancel
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
- (void)sure
{
    if([_delegate respondsToSelector:@selector(selectAddress:areaId:)])
    {
        NSInteger areaIndex = [_pickerView selectedRowInComponent:0];
        NSInteger cityIndex = [_pickerView selectedRowInComponent:1];
        NSInteger countieIndex = [_pickerView selectedRowInComponent:2];
        NSString * area = self.provinces[areaIndex].areaName;
        NSString * city = self.citys[cityIndex].areaName;
        NSString * countie = self.counties[countieIndex].areaName;
        NSString * results = [NSString stringWithFormat:@"%@-%@-%@",area,city,countie];
        [_delegate selectAddress:results areaId:self.counties[countieIndex].areaId];
    }
    [self cancel];
}

- (void)displayToWindow
{
    [Kwindow addSubview:self];
    __weak typeof(self) weakSelf = self;
    [_contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).priority(750);
    }];
    [UIView animateWithDuration:0.25f animations:^{
        self.alpha = 1;
        [self layoutIfNeeded];
    }];
}

#pragma mark pickerViewDelegate Methods
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return self.provinces.count;
        case 1:
            return self.citys.count;
        case 2:
            return self.counties.count;
        default:
            break;
    }
    return 0;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:
        {
            _citys = _provinces[row].cities;
            _counties = _citys[0].counties;
        }
            break;
        case 1:
            _counties = _citys[row].counties;
            break;
        case 2:

            break;
        default:
            break;
    }
    if(component == 2) return;
    [pickerView reloadComponent:2];
    if(component == 0)
    {
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:NO];
    }
    [pickerView selectRow:0 inComponent:2 animated:NO];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view

{
    NSString * string = nil;
    switch (component) {
        case 0:
            string = self.provinces[row].areaName;
            break;
        case 1:
            string =  self.citys[row].areaName;
            break;
        case 2:
            string =  self.counties[row].areaName;
            break;
        default:
            break;
    }
    UILabel * label = nil;
    label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, kScaleWidth(80), kScaleHeight(40))];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = string;
    if (component==2) {
        label.numberOfLines = 2;
    }
    label.font = [UIFont systemFontOfSize:kAppAsiaFontSize(12)];
    label.backgroundColor = [UIColor clearColor];
    return label;
    
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40;
}
#pragma mark - setter and getter
- (NSArray *)provinces
{
    if(!_provinces)
    {
        _provinces = [@[] copy];
    }
    return _provinces;
}
- (NSArray *)citys
{
    if(!_citys)
    {
        _citys = [@[] copy];
    }
    return _citys;
}
- (NSArray *)counties
{
    if(!_counties)
    {
        _counties = [@[] copy];
    }
    return _counties;
}

@end
