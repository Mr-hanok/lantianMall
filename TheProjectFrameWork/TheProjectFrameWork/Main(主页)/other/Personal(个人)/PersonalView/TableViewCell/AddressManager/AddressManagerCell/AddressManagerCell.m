//
//  AddressManagerCell.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/5.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "AddressManagerCell.h"
#import "AddressHandleView.h"
#import "AddressModel.h"
@interface AddressManagerCell ()<AddressHandleViewDelegate>
{
    AddressHandleView * _handleView;
    UILabel * _nameLabel;
    UILabel * _phoneLabel;
    UILabel * _zipLabel;
    UILabel * _addressLabel;
    
}
@end
@implementation AddressManagerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        _nameLabel = [[UILabel alloc] initWithText:@"张三"];
        _phoneLabel = [[UILabel alloc] initWithText:@"13912345678"];
        _zipLabel = [[UILabel alloc] initWithText:@"010-123456"];
        _addressLabel = [[UILabel alloc] initWithText:@"北京市朝阳区惠新西街北口千鹤家园发发呆发呆发呆撒风"];
        _addressLabel.numberOfLines = 2;
        _handleView = [[AddressHandleView alloc] init];
        _handleView.delegate = self;
        [self.contentView addSubview:_nameLabel];
        [self.contentView addSubview:_phoneLabel];
        [self.contentView addSubview:_zipLabel];
        [self.contentView addSubview:_addressLabel];
        [self.contentView addSubview:_handleView];
        _zipLabel.hidden = YES;
        [_phoneLabel setTextAlignment:NSTextAlignmentLeft];
        [self setup];
    }
    return self;
}
- (void)setup
{
    
    _nameLabel.textColor = [UIColor blackColor];
    _phoneLabel.textColor = [UIColor darkGrayColor];
    _zipLabel.textColor = [UIColor darkGrayColor];
    _addressLabel.textColor = [UIColor darkGrayColor];
    
    _nameLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(18)];
    _phoneLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(18)];
    _zipLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(16)];
    _addressLabel.font = [UIFont systemFontOfSize:kAppAsiaFontSize(16)];
    _addressLabel.textAlignment = NSTextAlignmentLeft;
    __weak typeof(self.contentView) weakSelf = self.contentView;
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).mas_offset(kScaleWidth(8));
        make.top.equalTo(weakSelf.mas_top).mas_offset(kScaleHeight(10));
    }];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).mas_offset(kScaleHeight(5));
        make.right.equalTo(weakSelf.mas_right).mas_offset(-kScaleWidth(8));
        make.left.equalTo(weakSelf.mas_left).mas_offset(kScaleWidth(8));
    }];
    [_zipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_top);
        make.right.equalTo(weakSelf.mas_right).mas_offset(-kScaleWidth(8));
        make.height.equalTo(_nameLabel.mas_height);
    }];
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_phoneLabel.mas_bottom).mas_offset(kScaleHeight(5));
        make.right.equalTo(weakSelf.mas_right).mas_offset(-kScaleWidth(8));
        make.left.equalTo(weakSelf.mas_left).mas_offset(kScaleWidth(8));
    }];
    [_handleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).mas_offset(-kScaleWidth(8));
        make.left.equalTo(weakSelf.mas_left).mas_offset(kScaleWidth(8));
        make.bottom.equalTo(weakSelf.mas_bottom);
    }];
}

#pragma mark other delegate
- (void)addressHandleClickDelete
{
    if([_delegate respondsToSelector:@selector(addressManagerDeleteWithCell:)])
    {
        [_delegate addressManagerDeleteWithCell:self];
    }
}
- (void)addressHandleClickEdit
{
    if([_delegate respondsToSelector:@selector(addressManagerEditWithCell:)])
    {
        [_delegate addressManagerEditWithCell:self];
    }
}
- (void)addressHandleClickDefaulfAddress{
    if([_delegate respondsToSelector:@selector(addressManagerIsDefaultWithCell:)])
    {
        [_delegate addressManagerIsDefaultWithCell:self];
    }
}

#pragma mark - setter and getter
- (void)setModel:(AddressModel *)model
{
    
    _model = model;
    _nameLabel.text = model.name;
    _phoneLabel.text = model.telePhone?:model.phone;
    _zipLabel.text = [LaguageControlAppend(@"邮编") stringByAppendingString: model.zip?:@""];
    _addressLabel.text = model.address;
    _handleView.isDefault = model.defaultAddress;
}
- (void)setIsDefault:(BOOL)isDefault
{
    _isDefault = isDefault;
    _handleView.isDefault = isDefault;
    _model.defaultAddress = isDefault;
}
/**
 *  调整cell之间间距
 *
 *  @param frame <#frame description#>
 */
- (void)setFrame:(CGRect)frame
{
    
    frame.size.height -= kScaleHeight(15);
    [super setFrame:frame];
}
@end
