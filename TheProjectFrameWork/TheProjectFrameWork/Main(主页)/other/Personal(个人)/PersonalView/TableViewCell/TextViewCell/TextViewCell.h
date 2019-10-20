//
//  TextViewCell.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/8.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
@protocol TextViewCellDelegate <NSObject>
@optional
/**
 *  返回文本
 */
- (void)textViewCellValueChangeWithText:(NSString *)text;
@end
@interface TextViewCell : BaseTableViewCell
@property (nonatomic , copy) NSString * placeholder;
@property (nonatomic , copy) NSString * text;

@property (nonatomic , weak) id <TextViewCellDelegate> delegate;

@end
