//
//  ReferrerViewController.h
//  TheProjectFrameWork
//
//  Created by yuntai on 2018/7/12.
//  Copyright © 2018年 MapleDongSen. All rights reserved.
//

#import "LeftViewController.h"

@interface ReferrerViewController : LeftViewController

@end

@interface ReferrerModel : NSObject
@property (nonatomic, copy) NSString *img_url;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *childs;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *type;
@end
