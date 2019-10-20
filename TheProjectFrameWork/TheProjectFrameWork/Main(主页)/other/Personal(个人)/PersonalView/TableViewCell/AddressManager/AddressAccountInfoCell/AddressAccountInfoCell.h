//
//  AddressAccountInfoCell.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/8.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
@protocol AddressAccountInfoCellDelegate <NSObject>
@optional
- (void)addrssAccountWithIndex:(NSInteger)index
                     textField:(UITextField *)textField;
@end
@interface AddressAccountInfoCell : BaseTableViewCell

@property (nonatomic , assign) NSInteger index;

@property (nonatomic , copy) NSString * title;

@property (nonatomic , copy) NSString * text;


@property (nonatomic , weak) id <AddressAccountInfoCellDelegate> delegate;

@end
