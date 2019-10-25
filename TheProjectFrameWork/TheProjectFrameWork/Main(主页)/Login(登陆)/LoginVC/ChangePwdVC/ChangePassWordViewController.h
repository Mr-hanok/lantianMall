//
//  ChangePassWordViewController.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/6/28.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "LeftViewController.h"

@interface ChangePassWordViewController : LeftViewController
@property (nonatomic , copy) NSString * userName;///< 实际上是user_id
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *phone;
@end
