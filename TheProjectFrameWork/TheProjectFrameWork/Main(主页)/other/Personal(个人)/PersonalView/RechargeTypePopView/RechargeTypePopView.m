//
//  RechargeTypePopView.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/26.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "RechargeTypePopView.h"
@interface RechargeTypePopView ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSInteger selectRow;
}
@property (nonatomic , weak) UIView * displayView;
@property (nonatomic , weak) UIPickerView * picker;
@property (nonatomic, strong) NSMutableArray *array;
@end
@implementation RechargeTypePopView
- (instancetype)initWithFrame:(CGRect)frame
{
    frame = kScreenFreameBound;
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor colorWithString:@"#000000120"];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        [self addGestureRecognizer:tap];
        
        
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
            make.height.mas_equalTo(kScaleHeight(200));
            make.bottom.equalTo(weakSelf.mas_bottom).priority(250);
            make.top.equalTo(weakSelf.mas_bottom).priority(500);
        }];
        self.alpha = 0;
        [self layoutIfNeeded];
        
        UIButton * cancel = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, kScaleHeight(45))];
        [cancel setTitle:[LaguageControl languageWithString:@"取消"] forState:UIControlStateNormal];
        [cancel setTitleColor:[UIColor colorWithString:@"#C90C1E"] forState:UIControlStateNormal];
        cancel.titleLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(13)];
        UIButton * sure = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, kScaleHeight(45))];
        [sure setTitle:[LaguageControl languageWithString:@"确定"] forState:UIControlStateNormal];
        [sure addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
        [sure setTitleColor:[UIColor colorWithString:@"#C90C1E"] forState:UIControlStateNormal];
        sure.titleLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(13)];
        [cancel addTarget:self action:@selector(removeFromWindow) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem * cancelItem = [[UIBarButtonItem alloc] initWithCustomView:cancel];
        UIBarButtonItem * sureItem = [[UIBarButtonItem alloc] initWithCustomView:sure];
        UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        tool.items = @[cancelItem,spaceItem,sureItem];
        _picker = picker;
        
        _array = [NSMutableArray array];
        [_array addObjectsFromArray:@[@"支付宝",@"微信"]];
    }
    return self;
}

- (void)sure{
    if([_delegate respondsToSelector:@selector(RechargeTypePopViewWithType:)])
    {
        [_delegate RechargeTypePopViewWithType:selectRow];
        [self removeFromWindow];
    }
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

-(void)displayToWindoWithAliWX:(BOOL)isHaveAliWX{
    
    [_array removeAllObjects];
//    [_array addObjectsFromArray:@[@"支付宝",@"微信"]];
    [_array addObjectsFromArray:@[@"支付宝"]];

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
-(void)displayToWindoWithConfigType{
    
    [_array removeAllObjects];
    //    [_array addObjectsFromArray:@[@"支付宝",@"微信"]];
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"zfbSubCash"]) {
        [_array addObject:@"支付宝"];
    }
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"weixinSubCash"]) {
        [_array addObject:@"微信"];

    }
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"realSubCash"]) {
        [_array addObject:@"线下打款"];
    }
    
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
        [self removeFromSuperview];
    }];
}

- (void)tapAction{
    [self removeFromWindow];
}
#pragma mark - UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _array.count;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    if(!view)
    {
        UILabel * label = [UILabel new];
        label.font = [UIFont systemFontOfSize:kAppAsiaFontSize(14)];
        label.textColor = [UIColor colorWithString:@"#333333"];
        label.textAlignment = NSTextAlignmentCenter;
//        if(row)
//        {
//            label.text = [LaguageControl languageWithString:@"银行卡/信用卡"];
//        }else
//        {
//            label.text = [LaguageControl languageWithString:@"网银"];
//        }
        label.text = _array[row];
        view = label;
    }
    return view;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *temstr = _array[row];
    selectRow = row;

    if ([temstr isEqualToString:@"支付宝"]) {
        selectRow = 0;
    }
    if ([temstr isEqualToString:@"微信"]) {
        selectRow = 1;
    }
    if ([temstr isEqualToString:@"线下打款"]) {
        selectRow = 2;
    }
}
@end
