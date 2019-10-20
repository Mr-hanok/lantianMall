//
//  ComplaintItemsView.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/20.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//  投诉主题内容

#import "ComplaintItemsView.h"
@interface ComplaintItemsView ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIView * contentView;
    UIToolbar * itemTool;
    UIPickerView * itemPick;
    NSString * selectTitle;
    NSInteger selectRow;
    NSArray * _dataArray;
    UIButton * cancelButton;
    UIButton * sureButton;
}
@end
@implementation ComplaintItemsView
- (instancetype)initWithTitles:(NSArray *)titles
{
    self = [super init];
    if(self)
    {
        _dataArray = titles;
        selectTitle = [_dataArray firstObject];
        selectRow = 0;
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
        contentView = [UIView new];
        [self addSubview:contentView];
        self.alpha = 0;
        [self setup];
    }
    return self;
}
- (void)setup
{
    __weak typeof(self) weakSelf = self;
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf);
        make.top.equalTo(weakSelf.mas_bottom).priority(500);
        make.height.mas_equalTo(kScaleHeight(200));
    }];
    UIToolbar * tool = [[UIToolbar alloc] init];
    UIPickerView * picker = [[UIPickerView alloc] init];
    tool.backgroundColor = [UIColor whiteColor];
    picker.backgroundColor = [UIColor colorWithString:@"#cccccc"];
    picker.delegate = self;
    cancelButton = [[UIButton alloc] initWithFrame:(CGRect){0,0,kScaleWidth(80),kScaleHeight(40)}];
    
    sureButton = [[UIButton alloc] initWithFrame:(CGRect){0,0,kScaleWidth(80),kScaleHeight(40)}];
    [cancelButton setTitle:LaguageControl(@"取消") forState:UIControlStateNormal];
    [sureButton setTitle:LaguageControl(@"确定") forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor colorWithString:@"#C90C1E"] forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor colorWithString:@"#C90C1E"] forState:UIControlStateNormal];
    sureButton.titleLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(13)];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(13)];
    [cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [sureButton addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * cancel = [[UIBarButtonItem alloc] initWithCustomView:cancelButton];
    UIBarButtonItem * space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem * sure = [[UIBarButtonItem alloc] initWithCustomView:sureButton];
    tool.items = @[cancel,space,sure];
    [contentView addSubview:tool];
    [contentView addSubview:picker];
     __weak typeof(contentView) _contentView = contentView;
    [tool mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(_contentView);
        make.height.mas_equalTo(kScaleHeight(40));
    }];
    [picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.equalTo(_contentView);
        make.top.equalTo(tool.mas_bottom);
    }];
    itemTool = tool;
    itemPick = picker;
    [self layoutIfNeeded];
}
- (void)cancel
{
    __weak typeof(self) weakSelf = self;
    [contentView mas_updateConstraints:^(MASConstraintMaker *make) {
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
    if([_delegate respondsToSelector:@selector(complaintItemWithTitle:)])
    {
        [_delegate complaintItemWithTitle:selectTitle];
    }
    if([_delegate respondsToSelector:@selector(complaintItemWithTitle:row:)])
    {
        [_delegate complaintItemWithTitle:selectTitle row:selectRow+1];
    }
    [self cancel];
}

- (void)displayToWindow
{
    [KeyWindow addSubview:self];
    __weak typeof(self) weakSelf = self;

    [contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.mas_bottom).priority(750);

    }];
    [UIView animateWithDuration:0.25f animations:^{
        self.alpha = 1;
        [self layoutIfNeeded];
    }];
}
#pragma mark - pickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _dataArray[row];
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return kScaleHeight(25);
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _dataArray.count;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    selectTitle = _dataArray[row];
    selectRow = row;
}
#pragma mark - setter and getter
- (void)setContentColor:(UIColor *)contentColor
{
    _contentColor = contentColor;
    itemPick.backgroundColor = contentColor;
}
- (void)setToolColor:(UIColor *)toolColor
{
    _toolColor = toolColor;
    itemTool.backgroundColor = toolColor;
}
- (void)setButtonColor:(UIColor *)buttonColor
{
    _buttonColor = buttonColor;
    [sureButton setTitleColor:buttonColor forState:UIControlStateNormal];
    [cancelButton setTitleColor:buttonColor forState:UIControlStateNormal];
}
@end
