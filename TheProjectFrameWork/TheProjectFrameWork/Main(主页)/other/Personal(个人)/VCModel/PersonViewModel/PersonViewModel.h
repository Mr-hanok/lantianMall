//
//  PersonViewModel.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 2016/10/21.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BaseViewController;
@class MineTableViewHeaderView;
@interface PersonViewModel : NSObject

@property (nonatomic , weak , nullable) __kindof BaseViewController *  controller;
@property (nonatomic , weak , nullable) __kindof UITableView * tableView;
@property (nonatomic , weak , nullable) MineTableViewHeaderView * headerView;

/**
 *  刷新用户数据
 */
- (void)refreshUserInfo;

- (void)getUserShopInfo;

/**
 *  更换用户头像
 */
- (void)replaceUserIconWithImage:(UIImage  * _Nonnull)image;

- (void)downloadNewIconUrl:(NSString * _Nonnull)url;
@end
