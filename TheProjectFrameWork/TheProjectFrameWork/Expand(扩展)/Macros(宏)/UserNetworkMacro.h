//
//  UserNetworkMacro.h
//  TheProjectFrameWork
//
//  Created by yuntai on 16/8/17.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#ifndef UserNetworkMacro_h
#define UserNetworkMacro_h


#define kDefaultServerError @"服务器错误"
#define kDefaultNetWorkError @"请检查网络"

/**卖家注册*/
#define SellerRegisterAction  @"/store_class/stroe_register"
/**银行信息*/
#define SellerBankInfoAction  @"/store_class/query_bank"


/**积分商品列表*/
#define IntegralHomeUrlAction  @"/buyer/integral_goods_list"
/**积分轮播图*/
#define IntegralBannerAction  @"/buyer/advertList_mark"
/**积分兑换记录*/
#define IntegralExchangerecord @"/buyer/exchange_record"
/**积分商品加入购物车*/
#define IntegralGoodsAddCar     @"/buyer/cart_integral_save"
/**积分购物车列表*/
#define IntegralGoodsCarListAction  @"/buyer/cart_integral_list"
/**积分购物车商品加减*/
#define IntegralGoodsPlusMinusAction @"/buyer/cart_integral_update"
/**积分购物车商品删除*/
#define IntegralGoodsDeleteAction   @"/buyer/cart_integral_delete"
/**积分兑换接口*/
#define IntegralGoodsExchangeAction  @"/buyer/exchang_integral_goods"
/**我的积分*/
#define IntegralInfoUrlAction     @"/buyer/integral_info"
/**删除积分订单*/
#define IntegralOrderDelAction    @"/buyer/delete_order"
/**确认收货接口*/
#define IntegralOrderReceivAction @"/buyer/complete_order"
/**积分日志列表*/
#define IntegralLogDetialListAction @"/buyer/integral_log_list"
/**积分待支付订单取消接口*/
#define IntegralCanCelAction @"/buyer/cancel_integral_order"
/**积分商品详情接口*/
#define IntegralGoodsDetailAction @"/buyer/integral_goods_info"


/**卖家相册列表*/
#define SellerAlbumListAction @"/seller/album"
/**卖家新建相册*/
#define SellerAddAlbumAction @"/seller/album_save"
/**卖家编辑相册*/
#define SellerEditAlbumAction @"/seller/album_update"
/**卖家删除相册*/
#define SellerDelAlbumAction @"/seller/album_delete"
/**相册明细*/
#define SellerAlbumDetailAction @"/seller/getAlbumList"
/**转移相册*/
#define SellerAlbumMoveAction  @"/seller/transfer_photo"
/**删除照片*/
#define SellerAlbumPicDelAction  @"/seller/photo_delete"
/**设为封面*/
#define SellerAlbumSetCoverAction  @"/seller/album_cover"
/**保存到相册*/
#define SellerAlbumSaveAction  @"/seller/save_photo"


/**获取地址列表*/
#define UserAdressListAction  @"/buyer/cart_address"
/**删除地址*/
#define UserAdressDelListAction  @"/buyer/cart_address_del"
/**地址详情*/
#define UserAdressDetailAction  @"/buyer/address_detail"
/**编辑保存地址*/
#define UserAdressSaveListAction @"/buyer/cart_address_save"
/**获取区域数据*/
#define UserAdressAreaInfoAction @"/buyer/getAreaByCountry"
/**设置默认地址*/
#define UserAdressDefaultAction @"/buyer/address_default"
/**根据邮编获取区域*/
#define UserAdressByeZipAction @"/buyer/cart_areaByZip"

/**卖家金币兑换接口*/
#define UserGoldRecordAction @"/goldRecordSave"
/**卖家账户充值接口*/
#define UserBalanceRecordAction @"/storeBalanceDeposit"

/**个人开店攻略*/
#define PersonKaidiangonglv  [KAppRootUrl stringByAppendingString:@"/doc_personalStoreHowOpen"]
/**公司开店攻略*/
#define CompanyKaidiangonglv [KAppRootUrl stringByAppendingString:@"/doc_companyStoreHowOpen"]
/**隐私政策*/
#define UserstoreAgreePolicy [KAppRootUrl stringByAppendingString:@"/doc_storeAgreePolicy"]
/**使用条款和服务*/
#define UserstoreAgreeService [KAppRootUrl stringByAppendingString:@"/doc_storeAgreeService"]
/**商业协议*/
#define UserstoreAgreeMerchant [KAppRootUrl stringByAppendingString:@"/doc_storeAgreeMerchant"]
#endif /* UserNetworkMacro_h */
