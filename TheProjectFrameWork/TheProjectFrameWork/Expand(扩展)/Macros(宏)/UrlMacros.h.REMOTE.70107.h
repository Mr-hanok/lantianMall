//
//  UrlMacros.h
//  TheProjectFrameWork
//
//  Created by maple on 16/6/3.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#ifndef UrlMacros_h
#define UrlMacros_h

//服务器根路径
//#define KAppRootUrl  @"http://192.168.1.204:8888"
//#define KAppRootUrl  @"http://192.168.1.159:8080/mobile"
#define KAppRootUrl  @"http://192.168.1.54:8080"
//#define KAppRootUrl  @"http://192.168.1.54:8080"
//#define KAppRootUrl  @"http://192.168.1.191:8080/mobile"

#define KAppRootUrl  @"http://192.168.1.190:8080/mobile"
// 外网测试
//#define KAppRootUrl  @"http://124.205.102.6:10290"


//#define KApploginUrl  @"192.168.1.1"



#define kImageUrlAppend(imagemodel) [NSString stringWithFormat:@"%@/%@/%@",KAppRootUrl,imagemodel.album_cover.path,imagemodel.album_cover.name];

//#define kUserId  @"32768"
#define kUserId [[NSNumber numberWithInteger:[UserAccountManager shareUserAccountManager].userModel.userId] stringValue]


/**图片服务器地址*/
#define SERVER_FILE_PRODUCT             @"http://192.168.1.54:8080/upload"

#endif /* UrlMacros_h */
