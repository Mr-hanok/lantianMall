//
//  AppAsiaShare.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/29.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShareView.h"
@class FacebookUserModel;
/**
 *  分享成功
 */
typedef void (^shareSuccessBlock) ();
/**
 *  分享失败
 */
typedef void (^shareFailBlock) (NSString * errorMessage);
/**
 *  分享取消
 */
typedef void (^shareCancelBlock) ();


@interface AppAsiaShare : NSObject
/**
 *  注册应用社会化组件信息
 */
+ (void)registerAppAsiaShare;
/**
 *  判断是否支持调用FaceBook客户端
 */
+ (BOOL)isClientInstalledFaceBook;
/**
 *  分享
 *
 *  @param shareType 分享平台
 *  @param content   分享内容（url）
 */
+ (void)shareType:(ShareTypes)shareType title:(NSString *)title text:(NSString *)text WithContentUrl:(NSString *)content imagePath:(NSString *)imagePath success:(shareSuccessBlock)success fail:(shareFailBlock)fail cancel:(shareCancelBlock)cancel;
/**
 *  点击Facebook
 */
+ (void)loginFacebookWithCompleteBlock:(void(^)(FacebookUserModel * facebookUser , NSError * err))block;
/**
 *  取消授权（退出登录时调用）
 */
+ (void)cancelCurrentAuthorization;
@end
