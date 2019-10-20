//
//  NetWork.h
//  TheProjectFrameWork
//
//  Created by maple on 16/6/4.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//
typedef enum : NSUInteger {
    MessageCodeTypeRegister=2,
    MessageCodeTypeChangePwd=3,
    MessageCodeTypeChangePhone=4,
    MessageCodeTypeChangePayPwd=4,
} MessageCodeType;
#import <Foundation/Foundation.h>
@class PhotoInfoModel;
@interface NetWork : NSObject
/** 成功回调 */
typedef void(^SuccessBlock)(NSDictionary * dic);
/** 失败回调 */
typedef void(^ErrorBlock)(NSString * error);

/** 成功回调 state = 0 */
typedef void(^SuccessCallBack)(NSDictionary * dic);
/** 错误回调 */
typedef void(^ErrorCallBack)(id error);
/** 失败 state ！= 0 */
typedef void(^FailureCallBack)(NSString * msg);

typedef void (^PhotoSuccessCallBlock)(NSArray<PhotoInfoModel *> * photoInfoArray);

typedef void(^ImageDownloaderProgressBlock)(NSInteger receivedSize, NSInteger expectedSize);
typedef void(^ImageCompletionWithFinishedBlock)(UIImage *image, NSError *error, BOOL finished, NSURL *imageURL);

/**
 *  Get请求
 *
 *  @param url        接口除根域名外地址
 *  @param block      成功回调
 *  @param errorblock 失败回调
 */
+(void)GETNetWorkWithUrl:(NSString*)url successBlock:(SuccessBlock)block errorBlock:(ErrorBlock)errorblock;
/**
 *  Post请求
 *
 *  @param url        接口除根域名外地址
 *  @param data       参数
 *  @param block      成功回调
 *  @param errorblock 失败回调
 */
+(void)PostNetWorkWithUrl:(NSString*)url with:(id)data successBlock:(SuccessBlock)block errorBlock:(ErrorBlock)errorblock;
/**
 *  post请求
 *
 *  @param url        地址
 *  @param data       参数
 *  @param dicback    成功回调data内容
 *  @param msgback    成功但state ！=1
 *  @param errorblock 失败回调
 */

+(void)PostNetWorkWithUrl:(NSString*)url with:(id)data successBlock:(SuccessCallBack)dicback FailureBlock:(FailureCallBack)msgback errorBlock:(ErrorCallBack)errorblock;
/**聚合页请求*/
+ (void)PostJuHeNetWorkWithUrl:(NSString*)url with:(id)data successBlock:(SuccessCallBack)dicback FailureBlock:(FailureCallBack)msgback errorBlock:(ErrorCallBack)errorblock;
/**
 *  上传图片
 *
 *  @param url        url
 *  @param params     params
 *  @param image      image
 *  @param dicback    成功回调
 *  @param msgback    state ！=1
 *  @param errorblock error回调
 */
+ (void)PostUpLoadImageWithImages:(NSArray *)images successBlock:(PhotoSuccessCallBlock)dicback FailureBlock:(FailureCallBack)msgback errorBlock:(ErrorCallBack)errorblock;
+ (void)PostUpLoadImageAlbumsWithImages:(NSArray *)images successBlock:(PhotoSuccessCallBlock)dicback FailureBlock:(FailureCallBack)msgback errorBlock:(ErrorCallBack)errorblock;

/**
 *  下载图片
 *
 *  @param url             图片url
 *  @param progressBlock   下载进度
 *  @param completionBlock 完成回调
 */
+ (void)loadImageWithUrl:(NSString *)url ImageDownloaderProgressBlock:(ImageDownloaderProgressBlock)progressBlock
ImageCompletionWithFinishedBlock:(ImageCompletionWithFinishedBlock)completionBlock;

/**发送验证码统一接口*/
+(void)PostNetWorkSendMessageWith:(MessageCodeType )type mobile:(NSString *)mobile successBlock:(SuccessCallBack)dicback FailureBlock:(FailureCallBack)msgback errorBlock:(ErrorCallBack)errorblock;

+ (void)getH5TokenCompletion:(void (^)(NSString *tips, NSError *error,NSString *token))completion;
@end
