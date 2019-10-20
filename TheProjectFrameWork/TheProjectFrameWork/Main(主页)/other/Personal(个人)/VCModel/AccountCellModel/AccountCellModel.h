//
//  AccountCellModel.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/1.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountCellModel : NSObject

@property (nonatomic , copy) NSString * title;
@property (nonatomic , assign) double value;
@property (nonatomic , copy) NSString * prompt;
@property (nonatomic , assign) BOOL isAccessory;

- (instancetype)initWithTitle:(NSString *)title
                        value:(NSNumber *)value
                       prompt:(NSString *)prompt
                  isAccessory:(NSNumber *)isAccessory;
@end
