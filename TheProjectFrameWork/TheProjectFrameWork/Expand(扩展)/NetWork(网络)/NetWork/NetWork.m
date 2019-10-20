//
//  NetWork.m
//  TheProjectFrameWork
//
//  Created by maple on 16/6/4.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "NetWork.h"
#import "NetWorkType.h"
#import "NetWork+BodyAndCookie.h"
#import "PhotoInfoModel.h"
@implementation NetWork
/**
 *  get请求
 *
 *  @param url        请求Url
 *  @param block      <#block description#>
 *  @param errorblock <#errorblock description#>
 */
+(void)GETNetWorkWithUrl:(NSString*)url successBlock:(SuccessBlock)block errorBlock:(ErrorBlock)errorblock
{
    if ([NetWorkType CheckNetWorkType]==NetWorkTypesNoNe) {
        errorblock(@"没有网络");
        return;
    }
    //接口拼接
    NSString * getUrl = [NSString stringWithFormat:@"%@%@",KAppRootUrl,url];
    //接口空字符去掉
    NSString * getReplaceUrls = [getUrl stringByReplacingOccurrencesOfString:@" " withString:@""];
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //设置请求头
    [NetWork setHttpBody:manager.requestSerializer];
    [manager.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", nil]];
    [manager GET:getReplaceUrls parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        [NetWork getHttpCookie];
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        block(dic);
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        errorblock(error.description);
    }];
}
/**
 *  PosT请求
 *
 *  @param url        请求url
 *  @param data       参数
 *  @param block      <#block description#>
 *  @param errorblock <#errorblock description#>
 */
+(void)PostNetWorkWithUrl:(NSString*)url with:(id)data successBlock:(SuccessBlock)block errorBlock:(ErrorBlock)errorblock
{
    
//    if ([NetWorkType CheckNetWorkType]==NetWorkTypesNoNe) {
//        errorblock(@"没有网络");
//        return;
//    }
    //接口拼接
    NSString * postUrl = [NSString stringWithFormat:@"%@%@",KAppRootUrl,url];
    //接口空字符去掉
    NSString * postReplaceUrls = [postUrl stringByReplacingOccurrencesOfString:@" " withString:@""];
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    //设置请求头
    [NetWork setHttpBody:manager.requestSerializer];
    [manager.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", @"text/plain", nil]];
    // 请求
    [manager POST:postReplaceUrls parameters:data success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        // 获取的数据传回去
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        block(dic);
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
//        [HUDManager showWarningWithError:error];
        
        errorblock(error.description);
    }];

}

+ (void)PostNetWorkWithUrl:(NSString*)url with:(id)data successBlock:(SuccessCallBack)dicback FailureBlock:(FailureCallBack)msgback errorBlock:(ErrorCallBack)errorblock;
{
    if ([NetWorkType CheckNetWorkType]==NetWorkTypesNoNe) {
        [HUDManager hideHUDView];
        [HUDManager showWarningWithText:kDefaultNetWorkError];
        errorblock(@"没有网络");
        return;
    }
    //接口拼接
    NSString * postUrl = [NSString stringWithFormat:@"%@%@",KAppRootUrl,url];
    //接口空字符去掉
    NSString * postReplaceUrls = [postUrl stringByReplacingOccurrencesOfString:@" " withString:@""];
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithArray:@[@"POST", @"GET", @"HEAD"]];
    
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //设置请求头
    [NetWork setHttpBody:manager.requestSerializer];
    [manager.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", @"text/plain", nil]];
    
    // 请求
    [manager POST:postReplaceUrls parameters:data  success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSError * error = nil;
        NSDictionary * content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        [HUDManager hideHUDView];
        if([content[@"status"] integerValue] == 1)
        {
            dicback(content);
        }else{
            msgback([content[@"message"] isKindOfClass:[NSNull class]]?content[@"data"]?:@"数据异常":content[@"message"]);
        }
        // 获取的数据传回去
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        [HUDManager hideHUDView];
        [HUDManager showWarningWithText:kDefaultNetWorkError];
        errorblock(error);
    }];
    
}
+ (void)PostJuHeNetWorkWithUrl:(NSString*)url with:(id)data successBlock:(SuccessCallBack)dicback FailureBlock:(FailureCallBack)msgback errorBlock:(ErrorCallBack)errorblock;
{
    if ([NetWorkType CheckNetWorkType]==NetWorkTypesNoNe) {
        [HUDManager hideHUDView];
        [HUDManager showWarningWithText:kDefaultNetWorkError];
        errorblock(@"没有网络");
        return;
    }
    //接口拼接
    NSString *temprooturlstr = KAppRootUrl;
    temprooturlstr = [temprooturlstr stringByReplacingOccurrencesOfString:@"/mobile" withString:@"/cmsconsole/mobile"];
    NSString * postUrl = [NSString stringWithFormat:@"%@%@",temprooturlstr,url];
    //接口空字符去掉
    NSString * postReplaceUrls = [postUrl stringByReplacingOccurrencesOfString:@" " withString:@""];
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithArray:@[@"POST", @"GET", @"HEAD"]];
    
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //设置请求头
    [NetWork setHttpBody:manager.requestSerializer];
    [manager.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", @"text/plain", nil]];
    
    // 请求
    [manager POST:postReplaceUrls parameters:data  success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSError * error = nil;
        NSDictionary * content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        [HUDManager hideHUDView];
        if([content[@"code"] integerValue] == 0)
        {
            dicback(content);
        }else{
            msgback([content[@"msg"] isKindOfClass:[NSNull class]]?content[@"data"]?:@"数据异常":content[@"msg"]);
        }
        // 获取的数据传回去
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        [HUDManager hideHUDView];
        [HUDManager showWarningWithText:kDefaultNetWorkError];
        errorblock(error);
    }];
    
}
+ (void)PostUpLoadImageWithImages:(NSArray *)images successBlock:(PhotoSuccessCallBlock)dicback FailureBlock:(FailureCallBack)msgback errorBlock:(ErrorCallBack)errorblock
{
    if ([NetWorkType CheckNetWorkType]==NetWorkTypesNoNe) {
        errorblock(@"没有网络");
        return;
    }
    //接口拼接
    NSString * postUrl = [NSString stringWithFormat:@"%@%@",KAppRootUrl,@"/upload"];
    //接口空字符去掉
    NSString * postReplaceUrls = [postUrl stringByReplacingOccurrencesOfString:@" " withString:@""];
    //图片data
    
    //图片名称
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString * str = [formatter stringFromDate:[NSDate date]];
   
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
    
    //设置请求头
    [NetWork setHttpBody:manager.requestSerializer];
    [manager.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", @"text/plain", nil]];
    
     __block NSData * imageData = nil;
    [manager POST:postReplaceUrls parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 上传图片，以文件流的格式
        __block NSString * fileName = nil;
        [images enumerateObjectsUsingBlock:^(UIImage *  _Nonnull image, NSUInteger idx, BOOL * _Nonnull stop) {
             fileName = [NSString stringWithFormat:@"%@_%lu.jpg", str,(unsigned long)idx];
            imageData = UIImageJPEGRepresentation(image, .5);
            [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpg"];
        }];
        
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];

        if([content[@"status"] boolValue] == YES)
        {
            NSArray * photoInfoArray = [PhotoInfoModel mj_objectArrayWithKeyValuesArray:content[@"data"]];
            dicback(photoInfoArray);
        }else{
            if (content[@"message"]) {
                msgback(content[@"message"]);
            }else{
                msgback(@"服务器错误");
            }
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        errorblock(error);
    }];
}
+ (void)PostUpLoadImageAlbumsWithImages:(NSArray *)images successBlock:(PhotoSuccessCallBlock)dicback FailureBlock:(FailureCallBack)msgback errorBlock:(ErrorCallBack)errorblock
{
    if ([NetWorkType CheckNetWorkType]==NetWorkTypesNoNe) {
        errorblock(@"没有网络");
        return;
    }
    //接口拼接
    NSString * postUrl = [NSString stringWithFormat:@"%@%@",KAppRootUrl,@"/upload"];
    //接口空字符去掉
    NSString * postReplaceUrls = [postUrl stringByReplacingOccurrencesOfString:@" " withString:@""];
    //图片data
    
    //图片名称
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString * str = [formatter stringFromDate:[NSDate date]];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
    
    //设置请求头
    [NetWork setHttpBody:manager.requestSerializer];
    [manager.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", @"text/plain", nil]];
    
    __block NSData * imageData = nil;
    [manager POST:postReplaceUrls parameters:@{@"user_id":kUserId} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 上传图片，以文件流的格式
        __block NSString * fileName = nil;
        [images enumerateObjectsUsingBlock:^(UIImage *  _Nonnull image, NSUInteger idx, BOOL * _Nonnull stop) {
            fileName = [NSString stringWithFormat:@"%@_%lu.jpg", str,(unsigned long)idx];
            imageData = UIImageJPEGRepresentation(image, .5);
            [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpg"];
        }];
        
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        
        if([content[@"status"] boolValue] == YES)
        {
            NSArray * photoInfoArray = [PhotoInfoModel mj_objectArrayWithKeyValuesArray:content[@"data"]];
            dicback(photoInfoArray);
        }else{
            if (content[@"message"]) {
                msgback(content[@"message"]);
            }else{
                msgback(@"服务器错误");
            }
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        errorblock(error);
    }];
}

+ (void)loadImageWithUrl:(NSString *)url ImageDownloaderProgressBlock:(ImageDownloaderProgressBlock)progressBlock
ImageCompletionWithFinishedBlock:(ImageCompletionWithFinishedBlock)completionBlock
{

    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:url] options:SDWebImageRetryFailed progress:progressBlock completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if(completionBlock)
        {
        completionBlock(image,error,finished,imageURL);
        }
    }];
}
+(void)PostNetWorkSendMessageWith:(MessageCodeType )type mobile:(NSString *)mobile successBlock:(SuccessCallBack)dicback FailureBlock:(FailureCallBack)msgback errorBlock:(ErrorCallBack)errorblock{
    
    NSDictionary *params = @{@"phone":[mobile stringByReplacingOccurrencesOfString:@"+" withString:@""]
                             ,@"templateId":@(type)
                             };
    
    
    
    if ([NetWorkType CheckNetWorkType]==NetWorkTypesNoNe) {
        [HUDManager hideHUDView];
        [HUDManager showWarningWithText:kDefaultNetWorkError];
        errorblock(@"没有网络");
        return;
    }
    //接口拼接
    NSString * postUrl = [NSString stringWithFormat:@"%@%@",KAppRootUrl,@"/getMsgCode"];
    //接口空字符去掉
    NSString * postReplaceUrls = [postUrl stringByReplacingOccurrencesOfString:@" " withString:@""];
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithArray:@[@"POST", @"GET", @"HEAD"]];
    
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //设置请求头
    [NetWork setHttpBody:manager.requestSerializer];
    [manager.responseSerializer setAcceptableContentTypes: [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", @"text/plain", nil]];
    
    // 请求
    [manager POST:postReplaceUrls parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSError * error = nil;
        NSDictionary * content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
        [HUDManager hideHUDView];
        if([content[@"status"] integerValue] == 1)
        {
            dicback(content);
        }else{
            msgback([content[@"message"] isKindOfClass:[NSNull class]]?@"未知错误":content[@"message"]);
        }
        // 获取的数据传回去
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        [HUDManager hideHUDView];
        [HUDManager showWarningWithText:kDefaultNetWorkError];
        errorblock(error);
    }];

}
+ (void)getH5TokenCompletion:(void (^)(NSString *tips, NSError *error,NSString *token))completion{
    
    [NetWork PostNetWorkWithUrl:@"/get_h5token" with:@{@"userId":kUserId} successBlock:^(NSDictionary *dic) {
        NSString *token = dic[@"data"]?:@"";
        completion(dic[@"message"]?:@"", nil,token);


    } FailureBlock:^(NSString *msg) {
        completion(msg, nil,nil);

    } errorBlock:^(id error) {
        completion(nil, error,nil);
    }];
}
@end
