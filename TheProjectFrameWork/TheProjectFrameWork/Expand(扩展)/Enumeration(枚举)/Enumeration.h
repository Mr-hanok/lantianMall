//
//  Enumeration.h
//  TheProjectFrameWork
//
//  Created by maple on 16/6/4.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//
#ifndef Enumeration_h
#define Enumeration_h
/** 网络状态枚举 */
#import <Foundation/Foundation.h>

typedef NS_ENUM (NSInteger, NetWorkTypes){
    NetWorkTypesWifi = 1 ,
    NetWorkTypesPhone = 2,
    NetWorkTypesNoNe = 0
};

/** 注册方法 */
typedef NS_ENUM(NSInteger , RegisterTypes) {
    /**
     *  电子邮箱注册
     */
    kRegisterTypeEmail = 2,
    /**
     *  手机号注册
     */
    kRegisterTypePhone = 1,
    /**
     *  Facebook注册
     */
    kRegisterTypeFaceBook = 1 << 2,
    /**
     *  google注册
     */
    kRegisterTypeGoogle = 1 << 3,
};

typedef NS_ENUM(NSInteger , PopVerifyTypes) {
    PopVerifyTypesPhone = 0,
    PopVerifyTypesEmail = 1,
};

/** 订单状态 */

/**
 *  <#Description#>
 */
typedef NS_ENUM(NSUInteger, OrderTypes)
{
    /**
     *  已完成
     */
    OrderTypesScuccess  = 50,
    /**
     *  申请退款中
     */
    OrderTypesApplyRefunding  = 45,
    /**
     *  卖家拒绝退款
     */
    OrderTypesRefundCanCel = 48,
    /**
     *  退款失败
     */
    OrderTypesRefundFailure  = 49,
    /**
     *  已成功
     */
    OrderTypesRefundSuccess = 47,
    /**
     *  已取消
     */
    OrderTypesCanCel = 0,
    /**
     *  待付款
     */
    OrderTypesToPayment = 10,
    /**
     *  线下付款
     */
    OrderTypesToPayUnderLine =15,
    /**
     *  待发货
     */
    OrderTypesToSend = 20,
    
    /**
     *  卖家点完准备发货状态
     */
    OrderTypesToSendING = 25,
    /**
     *  待收货
     */
    OrderTypesToAccePt = 30,
    /**
     *  待评价
     */
    OrderTypesToEvaluation = 40,
    
    /**
     *  退款
     */
    OrderTypesRefund = 45,
    /**
     *  备用
     */
    OrderTypesAllTypes = 9,
    /**
     *  拼团
     */
    OrderTypesPingTuan = 17,
};
/**
 *  税类型
 */
typedef NS_ENUM(NSUInteger, TaxTypes) {
    /**
     *  销售税
     */
    TaxTypesSales =1,
    /**
     *  运费
     */
    TaxTypesFreight =2,
    /**
     *  其他
     */
    TaxTypesOthers =3,
};
/**
 *  弹出类型
 */
typedef NS_ENUM(NSUInteger, PoPTypes) {
    /**
     *  <#Description#>
     */
    PoPTypesDefault =0,
    /**
     *  <#Description#>
     */
    PoPTypesAddShopCart  =1,
    /**
     *  <#Description#>
     */
    PoPTypesBuyNow =2,
};
/**
 *  选择类型
 */
typedef NS_ENUM(NSUInteger, SelectTypes) {
    /**
     *  联系卖家
     */
    SelectTypesConnectSeller =1,
    /**
     *  投诉
     */
    SelectTypesComplaints =2,
};

/**
 *  卖家订单类型
 */
typedef NS_ENUM(NSUInteger, SellerOrderTypes) {
    /**
     *  已完成
     */
    SellerOrderTypesSuccess = 50,
    /**
     *  待付款
     */
    SellerOrderTypesToPay = 10,
    /** 
     线下支付待审核
     */
    SellerOrderTypesToPayUnderLine =15,

    /**
     *  待发货
     */
    SellerOrderTypesToSend = 20,
    /**
     *  准备发货
     */
    SellerOrderTypesSendIng = 25,
    /**
     *  待收货
     */
    SellerOrderTypesToAccept = 30,
    /**
     *  待评价
     */
    SellerOrderTypesToEvaluation = 40,
    
//
//    /**
//     *  已评价
//     */
//    SellerOrderTypesEvaluationed = 50,

    /**
     *  已取消
     */
    SellerOrderTypesCanCeled = 0,
    /**
     *  退款
     */
    SellerOrderTypesRefund = 45,
    
    /** 退款成功 */
    SellerOrderTypesRefundSuccess = 47,

    /**
     *  退款取消。拒绝退款
     */
    SellerOrderTypesRefundRecord = 48,
    /**
     *  退款失败
     */
    SellerOrderTypesRefundFailure = 49,


};
/**
 *  注册地址
 */
typedef NS_ENUM(NSUInteger, SellserRegistreAdress) {
    /**
     *  公司地址
     */
    SellserRegistreAdressCompany =1,
    /**
     *  收件人地址
     */
    SellserRegistreAdressReceive =2,
    /**
     *  寄件人地址
     */
    SellserRegistreAdressSend =3,
};
/**
 *  投诉管理
 */
typedef NS_ENUM(NSInteger , ComplaintManagerStatus) {
    /**
     *  备用
     */
    ComplaintManagerUnknown = -1,
    /**
     *  新投诉
     */
    ComplaintManagerNew = 0,
    /**
     *  待申诉
     */
    ComplaintManagerWaitComplaint = 1,
    /**
     *  对话中
     */
    ComplaintManagerDialogue = 2,
    /**
     *  待仲裁
     */
    ComplaintManagerWaitArbitrate = 3,
    /**
     *  已完成
     */
    ComplaintManagerFinish = 4,
};
/**
 *  用户角色类型
 */
typedef NS_ENUM(NSInteger , UserRoleType)
{
    /**
     *  买家
     */
    UserRoleTypeBuyer = 1,
    /**
     *  卖家
     */
    UserRoleTypeSeller = 2,
};

/** 积分订单状态 */

typedef NS_ENUM(NSUInteger, IntegralOrderTypes)
{
    /**
     *  取消
     */
    IntegralOrderTypesCanCel = -1,
    /**
     *  待付款
     */
    IntegralOrderTypesToPayment = 0,
    /**
     *  待审核
     */
    IntegralOrderTypesCheck = 10,
    
    /**
     *  待发货
     */
    IntegralOrderTypesToSend = 20,
    /**
     *  待收货
     */
    IntegralOrderTypesToAccePt = 30,
    /**
     *  已完成
     */
    IntegralOrderTypesScuccess  = 40,

};

/**
 *  国家定义
 */
typedef NS_ENUM(NSInteger , CountryType) {
    /**
     *  中国
     */
    CountryTypeChina = 0,

    /**
     *  马来
     */
    CountryTypeMala = 1,
    /**
     *  文莱
     */
    CountryTypeBrunei = 2,
    /**
     *  新加坡
     */
    CountryTypeSingapura = 3,
};

#endif /* Enumeration_h */
