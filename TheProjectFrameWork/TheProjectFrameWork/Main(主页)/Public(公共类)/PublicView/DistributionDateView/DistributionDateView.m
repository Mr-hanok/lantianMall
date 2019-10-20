//
//  DistributionDateView.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/25.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//  配送时间选择

#import "DistributionDateView.h"
#import "CalendarDate.h"
@interface DistributionDateView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic , weak) UIView * displayView;
@property (nonatomic , weak) UIPickerView * picker;
@property (nonatomic , strong) NSArray * hours;
@property (nonatomic , strong) NSArray * days;
@end
@implementation DistributionDateView
- (instancetype)initWithFrame:(CGRect)frame
{
    frame = kScreenFreameBound;
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor colorWithString:@"#000000120"];
        UIToolbar * tool = [[UIToolbar alloc] init];
        UIPickerView * picker = [[UIPickerView alloc] init];
        picker.delegate = self;
        picker.dataSource = self;
        picker.backgroundColor = [UIColor whiteColor];
        UIView * displayView = [UIView new];
        [self addSubview:displayView];
        _displayView = displayView;

        __weak typeof(self) weakSelf = self;
        [displayView addSubview:tool];
        [displayView addSubview:picker];
        [tool mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.top.equalTo(weakSelf.displayView);
            make.height.mas_equalTo(kScaleHeight(45));
        }];
        [picker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.bottom.equalTo(weakSelf.displayView);
            make.top.equalTo(tool.mas_bottom);
        }];
        [_displayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.equalTo(weakSelf);
            make.height.mas_equalTo(kScaleHeight(250));
            make.bottom.equalTo(weakSelf.mas_bottom).priority(250);
            make.top.equalTo(weakSelf.mas_bottom).priority(500);
        }];
        self.alpha = 0;
        [self layoutIfNeeded];
        
        UIButton * cancel = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, kScaleHeight(45))];
        [cancel setTitle:LaguageControl(@"取消") forState:UIControlStateNormal];
        [cancel setTitleColor:[UIColor colorWithString:@"#C90C1E"] forState:UIControlStateNormal];
        cancel.titleLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(13)];
        UIButton * sure = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, kScaleHeight(45))];
        [sure setTitle:LaguageControl(@"确定") forState:UIControlStateNormal];
        [sure setTitleColor:[UIColor colorWithString:@"#C90C1E"] forState:UIControlStateNormal];
        sure.titleLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(13)];
        [sure addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
        [cancel addTarget:self action:@selector(removeFromWindow) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * cancelItem = [[UIBarButtonItem alloc] initWithCustomView:cancel];
        UIBarButtonItem * sureItem = [[UIBarButtonItem alloc] initWithCustomView:sure];
        UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        tool.items = @[cancelItem,spaceItem,sureItem];
        _picker = picker;
        _dateString = [NSString stringWithFormat:@"%@ %@",self.days[0],self.hours[0]];
    }
    return self;
}
- (void)displayToWindow
{
    [KeyWindow addSubview:self];
    __weak typeof(self) weakSelf = self;
    [_displayView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).priority(750);
    }];
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
        self.alpha = 1;
    }];
}
- (void)removeFromWindow
{
    __weak typeof(self) weakSelf = self;
    [_displayView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_bottom);
    }];
    [UIView animateWithDuration:0.25f animations:^{
        self.alpha = 0;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromWindow];
    }];
}
- (void)sure
{
    if([_delegate respondsToSelector:@selector(distributionDate:)])
    {
        [_delegate distributionDate:self];
    }
}
#pragma mark - UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component)
    {
        return self.hours.count;
    }
    return self.days.count;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    if(!view)
    {
        UILabel * label = [[UILabel alloc] initWithText:nil];
        label.textColor = [UIColor colorWithString:@"#333333"];
        if(component)
        {
            label.text = self.hours[row];
        }else
        {
            label.text = self.days[row];
        }
        view = label;
    }
    return view;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString * hour = nil;
    NSString * day = nil;
    if(component)
    {
        hour = self.hours[row];
    }else
    {
        day = self.days[row];
    }
    _dateString = [NSString stringWithFormat:@"%@ %@",day?day:self.days[0],hour?hour:self.hours[0]];
}
- (NSArray *)hours
{
    if(!_hours)
    {
        if(!self.timeArray || self.timeArray.count == 0)
        {
            _hours = @[@"10:00 – 12:00",@"12:00 – 15:00",@"15:00 – 18:00",@"18:00 – 20:00",@"20:00 – 22:00"];
        }else
        {
            NSMutableArray * tempArray = [@[] mutableCopy];
            for (DistributionDateModel * model in self.timeArray) {
                NSString * time = [NSString stringWithFormat:@"%@ - %@" , model.startTime,model.endTime];
                [tempArray addObject:time];
            }
            _hours = [tempArray copy];
            tempArray = nil;
        }
    }
    return _hours;
}
- (NSArray *)days
{
    if(!_days)
    {
        _days = [CalendarDate nextWeeksDate];
    }
    return _days;
}


- (void)setTimeArray:(NSArray *)timeArray
{
    _timeArray = [DistributionDateModel mj_objectArrayWithKeyValuesArray:timeArray];
    _hours = nil;
    [_picker reloadAllComponents];
}
@end


@implementation DistributionDateModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"startTime":@"elStartTime",@"endTime":@"elEndTime"};
}

@end
