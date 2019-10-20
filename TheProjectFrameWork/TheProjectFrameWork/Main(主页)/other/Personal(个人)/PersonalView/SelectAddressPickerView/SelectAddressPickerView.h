//
//  SelectAddressPickerView.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 2017/2/14.
//  Copyright © 2017年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AreaModel;
@protocol SelectAddressPickerViewDelegate <NSObject>

- (void)selectAddress:(NSString *)address areaId:(NSString *)areaId;

@end
@interface SelectAddressPickerView : UIView
@property (nonatomic , weak) id<SelectAddressPickerViewDelegate> delegate;

- (instancetype)initWithAreaInfos:(NSArray <AreaModel *>*)infos;

- (void)displayToWindow;
@end
