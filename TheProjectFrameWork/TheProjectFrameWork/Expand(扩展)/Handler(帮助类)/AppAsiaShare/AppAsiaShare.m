//
//  AppAsiaShare.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/29.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "AppAsiaShare.h"
#import "ShareMacros.h"
#import "WXApi.h"
#import "UIImage+Compression.h"


@implementation AppAsiaShare

+ (void)registerAppAsiaShare{
    
}
+ (BOOL)isClientInstalledFaceBook
{
//    return [ShareSDK isClientInstalled:SSDKPlatformTypeFacebook];
    return NO;
}

+ (void)loginFacebookWithCompleteBlock:(void(^)(FacebookUserModel * facebookUser , NSError * err))block
{
//    [ShareSDK getUserInfo:SSDKPlatformTypeFacebook conditional:nil onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
//        if(user.platformType == SSDKPlatformTypeFacebook && user && SSDKResponseStateSuccess == state)
//        {
//            FacebookUserModel * facebook = [FacebookUserModel mj_objectWithKeyValues:user.rawData];
//            if (block) {
//                block(facebook,nil);
//            }
//        }else
//        {
//            if(block)
//            {
//                block(nil,error);
//            }
//        }
//    }];
}


+ (void)cancelCurrentAuthorization
{
//    if([ShareSDK hasAuthorized:SSDKPlatformTypeFacebook])
//    {
//        [ShareSDK cancelAuthorize:SSDKPlatformTypeFacebook];
//    }
}


+ (void)shareType:(ShareTypes)shareType title:(NSString *)title text:(NSString *)text WithContentUrl:(NSString *)content imagePath:(NSString *)imagePath success:(shareSuccessBlock)success fail:(shareFailBlock)fail cancel:(shareCancelBlock)cancel
{
    
    
    //创建发送对象实例
    SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
    sendReq.bText = NO;//不使用文本信息
    sendReq.scene = shareType ==ShareTypeQQTypeWechatSession ? 0 : 1;//0 = 好友列表 1 = 朋友圈 2 = 收藏
    
    //创建分享内容对象
    WXMediaMessage *urlMessage = [WXMediaMessage message];
    urlMessage.title = title?:@"";//分享标题
    urlMessage.description = text?:@"";//分享描述
    
    
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    UIImage *img;
    if ([manager diskImageExistsForURL:[NSURL URLWithString:imagePath?:@""]])
    {
        img =  [[manager imageCache] imageFromDiskCacheForKey:imagePath];
        img = [img imageWithImage:img scaledToSize:CGSizeMake(200, 200)];
    }
    else
    {
        //从网络下载图片
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imagePath]];
        img = [UIImage imageWithData:data];
        img = [img imageWithImage:img scaledToSize:CGSizeMake(200, 200)];
        
    }
    
    if (img) {
        [urlMessage setThumbImage:img];//分享图片,使用SDK的setThumbImage方法可压缩图片大小
    }
    
    //创建多媒体对象
    WXWebpageObject *webObj = [WXWebpageObject object];
    webObj.webpageUrl = content?:@"";//分享链接
    
    //完成发送对象实例
    urlMessage.mediaObject = webObj;
    sendReq.message = urlMessage;
    
    //发送分享信息
    [WXApi sendReq:sendReq];
    
    if(cancel)
    {
        cancel();
    }
    
    
    
    
    
    
//    NSURL * imageURL = [NSURL URLWithString:imagePath?imagePath:[UserAccountManager shareUserAccountManager].logoImageUrl];
//    NSMutableDictionary * shareParams = [NSMutableDictionary dictionary];
//    SSDKPlatformType shareSDKType = (SSDKPlatformType)shareType;
//    
//    if(shareType == ShareTypeGooglePlus)
//       {
//           [shareParams SSDKSetupGooglePlusParamsByText:LaguageControl(text) url:[NSURL URLWithString:content] type:SSDKContentTypeAuto];
//       }else{
//           if(shareType == ShareTypesFaceBook)
//           {
//               [shareParams SSDKSetupFacebookParamsByText:LaguageControl(title) image:nil url:[NSURL URLWithString:content] urlTitle:LaguageControl(text) urlName:nil attachementUrl:nil type:SSDKContentTypeAuto];
//           }else
//           {
//               if(shareType == ShareTypeEmail || shareType == ShareTypeSMS)
//               {
//                   NSString * shareContent = [NSString stringWithFormat:@"%@\n%@",LaguageControl(text),content];
//                   [shareParams SSDKSetupShareParamsByText:shareContent
//                                                    images:@[imageURL] url:[NSURL URLWithString:content]
//                                                     title:LaguageControl(title)
//                                                      type:SSDKContentTypeAuto];
//               }else
//               {
//                   if(shareType == ShareTypeWhatsApp || shareType == ShareTypeQQTypeWechatSession ||shareType == ShareTypeQQTypeWechatTimeline)
//                   {
//                       NSString * whatsAppShare = [NSString stringWithFormat:@"%@\n%@",LaguageControl(text),content];
////                       [shareParams SSDKSetupWhatsAppParamsByText:whatsAppShare image:nil audio:nil video:nil menuDisplayPoint:CGPointZero type:SSDKContentTypeAuto];
//                       
//                       [shareParams SSDKSetupWeChatParamsByText:text title:title url:[NSURL URLWithString:whatsAppShare] thumbImage:imagePath image:imagePath musicFileURL:nil extInfo:nil fileData:nil emoticonData:nil sourceFileExtension:nil sourceFileData:nil type:SSDKContentTypeWebPage forPlatformSubType:shareSDKType];
//                       
//                       
//                       
//                   }else
//                   {
//                       [shareParams SSDKSetupShareParamsByText:LaguageControl(text)
//                                                        images:@[imageURL] url:[NSURL URLWithString:content]
//                                                         title:LaguageControl(title)
//                                                          type:SSDKContentTypeAuto];
//                   }
//                  
//               }
//               
//           }
//          
//       }
////    if(shareType == ShareTypeWhatsApp)
//
//    
//    [ShareSDK share:shareSDKType parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
//        switch (state) {
//            case SSDKResponseStateBegin:
//                NSLog(@"share Begin");
//                break;
//            case SSDKResponseStateSuccess:
//            {
//                if(userData.count == 0)
//                {
//                    if (cancel) {
//                        cancel();
//                    }
//                    return ;
//                }
//                if(success)
//                {
//                    success();
//                }
//            }
//                break;
//            case SSDKResponseStateFail:
//            {
//                if(fail)
//                {
//                    NSString * errorMsg = nil;
//                    switch (error.code) {
//                        case 208:
//                            errorMsg = @"未安装客户端";
//                            break;
//                        case 201:
//                            errorMsg = error.userInfo[@"error_message"];
//                            break;
//                        default:
//                            errorMsg = @"未知错误";
//                            break;
//                    }
//                    fail(errorMsg);
//                }
//            }
//            default:
//                if (cancel) {
//                    cancel();
//                }
//                break;
//        }
//    }];
}
@end
