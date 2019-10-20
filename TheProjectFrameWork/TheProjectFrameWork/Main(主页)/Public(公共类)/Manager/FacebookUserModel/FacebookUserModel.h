//
//  FaceBookUserModel.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/23.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FacebookUserModel : NSObject
@property (nonatomic , copy) NSString * FacebookID;

@property (nonatomic , copy) NSString * name;

@property (nonatomic , copy) NSString * first_name;

@property (nonatomic , copy) NSString * last_name;

@property (nonatomic , copy) NSString * birthday; ///< 生日
@property (nonatomic , copy) NSString * email;


@end
