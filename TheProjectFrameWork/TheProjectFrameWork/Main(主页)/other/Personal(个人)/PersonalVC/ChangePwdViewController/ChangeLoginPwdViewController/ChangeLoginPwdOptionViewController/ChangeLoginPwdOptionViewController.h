//
//  ChangeLoginPwdOptionViewController.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/6.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "LeftViewController.h"
typedef NS_ENUM(NSInteger , ChangeLoginPwdOptions) {
    ChangeLoginPwdOptionsPhone = 0,
    ChangeLoginPwdOptionsEmail = 1,
    ChangeLoginPwdOptionsOldPwd = 2,
};
@interface ChangeLoginPwdOptionViewController : LeftViewController

@end
