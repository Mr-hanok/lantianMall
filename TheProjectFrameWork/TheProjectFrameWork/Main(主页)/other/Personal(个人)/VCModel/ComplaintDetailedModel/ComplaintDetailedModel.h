//
//  ComplaintDetailedModel.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/18.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ComplaintGoods,Arbitration,ComplaintAppeal;
@interface ComplaintDetailedModel : NSObject
@property (nonatomic , assign) NSInteger complaintID;
@property (nonatomic , assign) ComplaintManagerStatus status;
@property (nonatomic , assign) NSInteger of_id; //orderform
@property (nonatomic , copy) NSString * of_sn; ///< 订单编号
@property (nonatomic , strong) NSArray<ComplaintGoods *> * goodsList;
@property (nonatomic , copy) NSString * title; ///< 投诉主题
@property (nonatomic , copy) NSString * addTime;///< 投诉时间
@property (nonatomic , copy) NSString * describe; ///< 问题描述
@property (nonatomic , copy) NSString * fromContent;///< 投诉内容
@property (nonatomic , copy) NSString * storeName;

@property (nonatomic , copy) NSString * totalMoney;
@property (nonatomic , strong) NSArray * talkContent; ///< 对话记录
@property (nonatomic , copy) NSString * type;

@property (nonatomic , strong) Arbitration * mArbitration; ///< 仲裁信息
@property (nonatomic , strong) ComplaintAppeal * mAppeal; ///< 上诉信息
@property (nonatomic , copy) NSString * fromPath1; ///< 投诉图片1
@property (nonatomic , copy) NSString * fromPath2; ///< 投诉图片2
@property (nonatomic , copy) NSString * fromPath3; ///< 投诉图片3

@end


@interface ComplaintGoods : NSObject

@property (nonatomic , assign) NSInteger goodsID;
@property (nonatomic , copy) NSString * goods_name;
@property (nonatomic , assign) NSInteger count;
@property (nonatomic , assign) CGFloat goods_price;
@property (nonatomic , copy) NSString * path;
@property (nonatomic , copy) NSString * desc;


@end
@interface Arbitration : NSObject

@property (nonatomic , copy) NSString * handle_content;
@property (nonatomic , copy) NSString * handle_time;
@property (nonatomic , copy) NSString * handle_name;

@end

@interface ComplaintAppeal : NSObject

@property (nonatomic , copy) NSString * toPath1;
@property (nonatomic , copy) NSString * toPath2;
@property (nonatomic , copy) NSString * toPath3;
@property (nonatomic , copy) NSString * appeal_time;
@property (nonatomic , copy) NSString * toContent;





@end
