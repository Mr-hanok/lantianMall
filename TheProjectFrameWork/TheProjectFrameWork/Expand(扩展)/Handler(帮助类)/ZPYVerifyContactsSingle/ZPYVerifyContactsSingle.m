//
//  VerifyContactsSingle.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/10/11.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "ZPYVerifyContactsSingle.h"
#import "PopVerifyView.h"

@interface ZPYVerifyContactsSingle ()<PopVerifyViewOtherDelegate>
@property (nonatomic , strong) NSMutableArray <VerifyContacts *> *verifyContacts;
@end
static ZPYVerifyContactsSingle * single = nil;

@implementation ZPYVerifyContactsSingle

+ (instancetype)shareVerifyContacts
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        single = [[ZPYVerifyContactsSingle alloc] init];
    });
    return single;
}

- (PopVerifyView *)verifyPopViewWithKey:(NSString *)key type:(NSInteger)type Template:(NSString *)templateString
{
    for (VerifyContacts * content in self.verifyContacts) {
        if([content.key isEqualToString:key] && [templateString isEqualToString:content.templateString])
        {
            return content.value;
        }
    }

        PopVerifyView * pop = [PopVerifyView creatPopVerifyWithType:type sender:key];
        pop.otherDelegate = self;
        pop.templateString = templateString;
        VerifyContacts * content = [[VerifyContacts alloc] init];
        content.key = key;
        content.value = pop;
        content.type = type;
        content.templateString = templateString;
        [self.verifyContacts addObject:content];
        return pop;
    
}

- (void)removeVerifyPopView:(PopVerifyView *)verify key:(NSString *)key
{
    if(self.verifyContacts.count == 0)
    {
        return;
    }
    for (VerifyContacts * content in self.verifyContacts) {
        if([content.key isEqualToString:key])
        {
            [self.verifyContacts removeObject:content];
        }
    }
}
- (void)takeOutWithKey:(NSString *)key content:(verifyPopViewBlcok)block
{
    for (VerifyContacts * content in self.verifyContacts) {
        if([content.key isEqualToString:key])
        {
            if(block)
            {
                block(content.value,content.key,content.type);
                break;
            }
        }
    }
}

- (void)popVerifyTimeToCompleteAndNoSuperView:(PopVerifyView *)verifyView
{
    [self removeVerifyPopView:verifyView key:verifyView.senderString];
}

- (NSMutableArray *)verifyContacts
{
    if(!_verifyContacts)
    {
        _verifyContacts = [@[] mutableCopy];
    }
    return _verifyContacts;
}

@end

@implementation VerifyContacts



@end
