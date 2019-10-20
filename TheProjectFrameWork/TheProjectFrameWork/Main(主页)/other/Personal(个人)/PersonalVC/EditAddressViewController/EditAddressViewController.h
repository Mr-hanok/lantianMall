//
//  EditAddressViewController.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/8.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "LeftViewController.h"
typedef NS_ENUM(NSInteger , EditAddressOptions) {
    /**
     *  收货人
     */
    EditAddressOptionName = 0,
    /**
     *  联系电话
     */
    EditAddressOptionPhone = 1,
    /**
     *  国家
     */
    EditAddressOptionCountry = 2,
    /**
     *  邮编
     */
    EditAddressOptionPostCode = 3,
    /**
     *  详细地址
     */
    EditAddressOptionAddress = 4,
};
@class AddressModel,EditAddressViewController;
@protocol EditAddressViewControllerDelegate <NSObject>

- (void)editAddressViewController:(EditAddressViewController *)controller;

@end

@interface EditAddressViewController : LeftViewController
@property (nonatomic , strong) AddressModel * model; ///< 地址数据模型
@property (nonatomic , strong) NSIndexPath * indexPath;
@property (nonatomic , weak) id <EditAddressViewControllerDelegate> delegate;

@end
