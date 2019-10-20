//
//  AddressSelectCell.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/12.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "AddressSelectCell.h"
#import "AdressAreaModel.h"
@interface AddressSelectCell ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic, strong) NSMutableArray *array;

@property (nonatomic, strong) UIView *myView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIView *line;
@end
@implementation AddressSelectCell
{
    UILabel * _titleLabel;
    UIPickerView * _addressPicker;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(14)];
        _textField = [[UITextField alloc] init];
        UIView * line = [UIView new];
        line.backgroundColor = [UIColor colorWithString:@"#cccccc120"];
        _titleLabel.text = LaguageControlAppend(@"邮编");
        _textField.delegate = self;
        _textField.font = _titleLabel.font;
        _textField.placeholder = LaguageControl(@"填写邮编可获取地区");
        _addressPicker = [[UIPickerView alloc] init];
        _addressPicker.delegate = self;
        [self.contentView addSubview:_titleLabel];
        [self.contentView addSubview:_textField];
        [self.contentView addSubview:_addressPicker];
        [self.contentView addSubview:line];
        __weak typeof(self) weakSelf = self;
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.contentView.mas_left).mas_offset(kScaleWidth(10));
            make.top.equalTo(weakSelf.contentView.mas_top);
            make.right.equalTo(_textField.mas_left).mas_offset(kScaleWidth(5));
            make.height.mas_greaterThanOrEqualTo(kScaleHeight(44)).priority(750);
        }];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(weakSelf.contentView.mas_width).multipliedBy(0.8f);
            make.top.right.equalTo(weakSelf.contentView);
            make.bottom.mas_equalTo(_titleLabel.mas_bottom);
            
        }];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(weakSelf.contentView);
            make.height.mas_equalTo(1);
            make.top.equalTo(_textField.mas_bottom);
        }];
        [_addressPicker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(weakSelf.contentView);
            make.height.mas_equalTo(kScaleHeight(120)).priority(750);
            make.top.equalTo(_textField.mas_bottom).mas_offset(kScaleHeight(10));
            make.bottom.equalTo(weakSelf.contentView.mas_bottom).mas_offset(-kScaleHeight(5));
        }];
        
    }
    return self;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTextField:) name:UITextFieldTextDidChangeNotification object:textField];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)changeTextField:(NSNotification *)notofication
{
    UITextField * textField = notofication.object;
    if([_delegate respondsToSelector:@selector(addressCell:zipCode:)])
    {
        [_delegate addressCell:self zipCode:textField.text];
    }
}


- (void)configCellWithAreaArray:(NSMutableArray *)array withcountry:(CountryType)countryId{
    self.array = array;
    self.countryId = countryId;
    [_addressPicker selectRow:0 inComponent:0 animated:YES];
    if (self.array.count>0) {
        AdressAreaModel *model = self.array[0];
        self.proModel = model;
        self.cityModel = model.childs[0];
        if (self.countryId ==CountryTypeBrunei) {
            self.dowmModel = self.cityModel.childs[0];
            self.textField.text = self.dowmModel.zip;
        }else{
            self.textField.text = self.cityModel.zip; 
        }
        [_addressPicker reloadAllComponents];
 
    }
   
}


#pragma mark - UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    /**省 市*/
    NSInteger row = self.countryId == CountryTypeBrunei ? 3 :2;
    return row;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
//    if (component == 0) return self.array.count;
//    else if(component == 1)return self.proModel.childs.count;
//    else return self.dowmModel.childs.count;
    if(component == 0) return self.array.count;
    if(component == 1) return self.proModel.childs.count;
    if(component == 2) return self.cityModel.childs.count;;
    return 0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    [self endEditing:YES];
    CGFloat width = 80.0f;
    CGFloat height = 50.0f;
    
    self.myView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    self.myView.backgroundColor = [UIColor whiteColor];
    
    
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, height-1)];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = [UIFont systemFontOfSize:kAppAsiaFontSize(14)];
    self.label.textColor = [UIColor colorWithString:@"#333333"];
    
    
    self.line = [[UIView alloc]initWithFrame:CGRectMake(0, height-1, width, 1)];
    self.line.backgroundColor = [UIColor colorWithString:@"#C90C1E"];
    
    [self.myView addSubview:self.label];
    [self.myView addSubview:self.line];
    
    ((UIView *)[_addressPicker.subviews objectAtIndex:1]).backgroundColor = [UIColor clearColor];
    ((UIView *)[pickerView.subviews objectAtIndex:2]).backgroundColor = [UIColor clearColor];
    
    switch (component) {
        case 0:
        {
            AdressAreaModel *pro = self.array[row];
            self.label.text = pro.areaName;
            break;
        }
            
        case 1:
        {
            AdressAreaModel *city = self.proModel.childs[row];
            self.label.text = city.areaName;
            break;
        }
        case 2:
        {
            AdressAreaModel *down = self.cityModel.childs[row];
            self.label.text = down.areaName;
            break;
        }

            
    }
    return self.myView;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    switch (component) {
        case 0:
        {
            AdressAreaModel *pro = self.array[row];
            if (pro.childs.count>0)self.proModel = pro;
            else self.proModel.childs = nil;
            if ([_delegate respondsToSelector:@selector(addressCell:areaModel:)]) {
                if (self.countryId ==CountryTypeBrunei) {
                    AdressAreaModel *are = pro.childs[0];
                    [_delegate addressCell:self areaModel:are.childs[0]];
 
                }else{
                    [_delegate addressCell:self areaModel:pro.childs[0]];

                }
            }
            // 刷新数据
            [pickerView selectRow:0 inComponent:1 animated:YES];
            [pickerView reloadComponent:1];
            if (self.countryId ==CountryTypeBrunei) {
                [pickerView selectRow:0 inComponent:2 animated:YES];
                [pickerView reloadComponent:2];
            }
            //    [pickerView selectedRowInComponent:1];
            

            break;
        }
            
        case 1:
        {
            AdressAreaModel *city = self.proModel.childs[row];
            self.cityModel = city;
            
            if ([_delegate respondsToSelector:@selector(addressCell:areaModel:)]) {
                if (self.countryId == CountryTypeBrunei) {
                    [_delegate addressCell:self areaModel:city.childs[0]];
                    [pickerView selectRow:0 inComponent:2 animated:YES];
                    [pickerView reloadComponent:2];

                }else{
                    [_delegate addressCell:self areaModel:city];
                }
            }
            break;
        }
        case 2:
        {
            AdressAreaModel *down = self.cityModel.childs[row];
            self.dowmModel = down;
            if ([_delegate respondsToSelector:@selector(addressCell:areaModel:)]) {
                [_delegate addressCell:self areaModel:down];
            }
            break;
        }

            
    }
    }

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 50;
}

@end
