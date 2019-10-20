//
//  UserModel.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/6/23.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic , assign) NSInteger userId; ///< 流水号

@property (nonatomic , copy) NSString * username;///< 用户名

@property (nonatomic , copy) NSString * truename; ///< 真实姓名

@property (nonatomic , assign) NSInteger userType; ///< 用户类型 1:游客 2:普通用户 3:vip用户 4:o2o用户 其余的:游客
@property (nonatomic , copy) NSString * email; ///< 邮箱

@property (nonatomic , copy) NSString * userRank;///< 用户等级

@property (nonatomic , assign) BOOL isPayPassWord; ///< 是否有支付密码
@property (nonatomic , copy) NSString * birthday; ///< 生日
@property (nonatomic , assign) NSInteger goodsCount; ///< 关注商品
@property (nonatomic , assign) NSInteger storeCount; ///< 关注店铺
@property (nonatomic , copy) NSString * iconUrl;

@property (nonatomic , copy) NSString * accountBalance;///< 账户余额
@property (nonatomic , assign) CGFloat rebateTotal;///< 返利
@property (nonatomic , copy) NSString * defaultAdddress; ///< 默认地址
/**住址*/
@property (nonatomic, copy) NSString *address;
/**创建时间*/
@property (nonatomic, copy) NSString *addtime;
/**所属区域*/
@property (nonatomic, copy) NSString *areaId;
/**账户余额*/
@property (nonatomic, copy) NSString *availablebalance;
/**删除标志*/
@property (nonatomic, copy) NSString *deletestatus;
/**冻结金额*/
@property (nonatomic, copy) NSString *freezeblance;
/**金币数*/
@property (nonatomic, copy) NSString *gold;
/**积分*/
@property (nonatomic, copy) NSString *integral;
/**最后登录日期*/
@property (nonatomic, copy) NSString *lastlogindate;
/**最后登录ip*/
@property (nonatomic, copy) NSString *lastloginip;
/**登录次数*/
@property (nonatomic, copy) NSString *logincount;
/**登录日期*/
@property (nonatomic, copy) NSString *logindate;
/**登录ip*/
@property (nonatomic, copy) NSString *loginip;
/**手机号码*/
@property (nonatomic, copy) NSString *mobile;
/**msn*/
@property (nonatomic, copy) NSString *msn;
/**父级编号*/
@property (nonatomic, copy) NSString *parentId;
/**登录密码*/
@property (nonatomic, copy) NSString *password;
/**photo_id*/
@property (nonatomic, copy) NSString *photoId;
/**qq*/
@property (nonatomic, copy) NSString *qq;
/**qqOpenid*/
@property (nonatomic, copy) NSString *qqOpenid;
/**report*/
@property (nonatomic, copy) NSString *report;
/**性别*/
@property (nonatomic, copy) NSString *sex;
/**sina_openid*/
@property (nonatomic, copy) NSString *sinaOpenid;
/**状态*/
@property (nonatomic, copy) NSString *status;
/**店铺编号*/
@property (nonatomic, copy) NSString *storeId;
/**店铺面板菜单*/
@property (nonatomic, copy) NSString *storeQuickMenu;
/**信用等级*/
@property (nonatomic, copy) NSString *userCredit;
/**用户角色*/
@property (nonatomic, copy) NSString *userrole;
/**网址*/
@property (nonatomic, copy) NSString *ww;
/**年龄*/
@property (nonatomic, copy) NSString *years;
/**推荐码*/
@property (nonatomic, copy) NSString *referralCode;
@end
