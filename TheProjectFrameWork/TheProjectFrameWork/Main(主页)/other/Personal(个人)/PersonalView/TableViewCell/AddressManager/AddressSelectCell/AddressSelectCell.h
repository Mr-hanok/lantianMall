//
//  AddressSelectCell.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/12.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseTableViewCell.h"
@class AddressSelectCell,AdressAreaModel;
@protocol AddressSelectCellDelegate <NSObject>
@optional
- (void)addressCell:(AddressSelectCell *)cell zipCode:(NSString *)code;
- (void)addressCell:(AddressSelectCell *)cell areaModel:(AdressAreaModel *)model;
@end
@interface AddressSelectCell : BaseTableViewCell

- (void)configCellWithAreaArray:(NSMutableArray *)array withcountry:(CountryType)countryId;
@property (nonatomic , weak) id <AddressSelectCellDelegate> delegate;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) AdressAreaModel *proModel;
@property (nonatomic, strong) AdressAreaModel *cityModel;
@property (nonatomic, strong) AdressAreaModel *dowmModel;
@property (nonatomic, assign) CountryType countryId;
@end
