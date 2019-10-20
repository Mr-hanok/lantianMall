//
//  TextFieldTableCell.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/7.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
@protocol TextFieldTableCellDelegate <NSObject>
@optional
- (void)textFieldValueChange:(UITextField *)textField;
@end
@interface TextFieldTableCell : BaseTableViewCell

@property (nonatomic , copy) NSString * text;
@property (nonatomic , weak) id <TextFieldTableCellDelegate> delegate;

- (void)loadTextFieldTag:(NSInteger)tag placeholder:(NSString *)placeholder;

@end
