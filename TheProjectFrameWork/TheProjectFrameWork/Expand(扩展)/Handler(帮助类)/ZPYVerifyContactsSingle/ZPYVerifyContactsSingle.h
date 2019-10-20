//
//  VerifyContactsSingle.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/10/11.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class VerifyContacts,PopVerifyView;
typedef void (^verifyPopViewBlcok) (id content, NSString * key, NSInteger type);
@interface ZPYVerifyContactsSingle : NSObject

+ (instancetype)shareVerifyContacts;

- (PopVerifyView *)verifyPopViewWithKey:(NSString *)key type:(NSInteger)type Template:(NSString *)templateString;
- (void)removeVerifyPopView:(PopVerifyView *)verify key:(NSString *)key;

- (void)takeOutWithKey:(NSString *)key content:(verifyPopViewBlcok)block;

@end


@interface VerifyContacts : NSObject

@property (nonatomic , strong) id value;
@property (nonatomic , copy) NSString * key;
@property (nonatomic , assign) NSInteger type;
@property (nonatomic , copy) NSString * templateString;


@end
