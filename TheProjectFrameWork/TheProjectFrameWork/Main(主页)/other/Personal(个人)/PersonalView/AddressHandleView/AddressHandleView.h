//
//  AddressHandleView.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/5.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ImageButton;
typedef NS_ENUM(NSInteger , AddressHandleTypes) {
    AddressHandleDefault = 1 << 0,///< 是否默认
    AddressHandleEdit = 1 << 1, ///< 编辑
    AddressHandleDelete = 1 << 2, ///< 删除
};

@protocol AddressHandleViewDelegate <NSObject>
@optional
/**
 *  点击设置默认地址
 */
- (void)addressHandleClickDefaulfAddress;
/**
 *  点击编辑
 */
- (void)addressHandleClickEdit;
/**
 *  点击删除
 */
- (void)addressHandleClickDelete;
@end
@interface AddressHandleView : UIView

@property (nonatomic , weak) id<AddressHandleViewDelegate> delegate;
@property (nonatomic , assign ) BOOL isDefault;

@end
