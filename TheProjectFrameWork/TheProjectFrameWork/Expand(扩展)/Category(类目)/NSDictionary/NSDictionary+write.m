//
//  NSDictionary+write.m
//  TheProjectFrameWork
//
//  Created by maple on 2017/2/8.
//  Copyright © 2017年 MapleDongSen. All rights reserved.
//

#import "NSDictionary+write.h"
#import "AppDelegate+PrivateMethods.h"

@implementation NSDictionary (write)

-(BOOL)ds_writefiletohomePath:(NSString*)path
{
    if ([path isEqualToString:@"/index_mall"]) {
        BOOL isShowIntegral = [[self objectForKey:@"data"][@"integralStoreSwitch"] boolValue];
        
        NSString *isb2cstr = [self objectForKey:@"data"][@"mall_trpe"];
        BOOL isB2C = [isb2cstr isEqualToString:@"B2C"] ? YES: NO;
        [[NSUserDefaults standardUserDefaults] setBool:isB2C forKey:kIsB2cStr];
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"integralStoreSwitch"] != isShowIntegral) {
            
            [[NSUserDefaults standardUserDefaults] setBool:isShowIntegral forKey:@"integralStoreSwitch"];
            AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate ;
            [appdelegate ProjectSetRootViewController];
        }
        
        NSString *subCash = [self objectForKey:@"data"][@"subCash"];
        NSString *weixinSubCash = [self objectForKey:@"data"][@"weixinSubCash"];
        NSString *zfbSubCash = [self objectForKey:@"data"][@"zfbSubCash"];
        NSString *realSubCash = [self objectForKey:@"data"][@"realSubCash"];
        
        [[NSUserDefaults standardUserDefaults] setBool:[subCash isEqualToString:@"true"] ? YES:NO forKey:@"subCash"];
        [[NSUserDefaults standardUserDefaults] setBool:[weixinSubCash isEqualToString:@"true"] ? YES:NO forKey:@"weixinSubCash"];
        [[NSUserDefaults standardUserDefaults] setBool:[zfbSubCash isEqualToString:@"true"] ? YES:NO forKey:@"zfbSubCash"];
        [[NSUserDefaults standardUserDefaults] setBool:[realSubCash isEqualToString:@"true"] ? YES:NO forKey:@"realSubCash"];
        [[NSUserDefaults standardUserDefaults] synchronize];



        
    }
    
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    return [jsonData writeToFile:[self ds_getRootPath:path] atomically:YES];
}
+(NSDictionary*)ds_readfiletohomePath:(NSString*)path
{
    NSData * datas = [NSData dataWithContentsOfFile:[[NSDictionary dictionary] ds_getRootPath:path]];
    NSDictionary * dic = [NSDictionary dictionary];
    if (datas) {
        dic =[NSJSONSerialization JSONObjectWithData:datas options:NSJSONReadingMutableLeaves error:nil];
    }
    return dic;
}
-(NSString*)ds_getRootPath:(NSString*)path
{
    NSString *rootPath = [path stringByReplacingOccurrencesOfString:@"/" withString:@""];
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documents = [array lastObject];
    return  [documents stringByAppendingPathComponent:rootPath];
}

@end
