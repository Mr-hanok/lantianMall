//
//  ShareView.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/28.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShareView;

/**
 *  分享类型
 */
typedef NS_ENUM(NSInteger , ShareTypes) {
    /**
     *  邮箱
     */
    ShareTypeEmail = 18,
    /**
     *  Facebook
     */
    ShareTypesFaceBook = 10,
    /**
     *  Twitter
     */
    ShareTypeTwitter = 11,
    /**
     *  短信
     */
    ShareTypeSMS = 19,
    /**
     *  Google+
     */
    ShareTypeGooglePlus = 14,
    /**
     *  微信
     */
    ShareTypeWechat = 997,
    /**
     *  WhatsApp
     */
    ShareTypeWhatsApp = 43,
    /**
     *  QQ
     */
    ShareTypeQQ = 998,
    
    /**
     *  微信好友
     */
    ShareTypeQQTypeWechatSession    = 22,
    /**
     *  微信朋友圈
     */
    ShareTypeQQTypeWechatTimeline   = 23,
};
@protocol ShareViewDelegate <NSObject>
@optional
- (void)shareEventWithView:(ShareView *)view
                      type:(ShareTypes)type;

@end
/**
 *  分享视图
 */
@interface ShareView : UIView

@property (nonatomic , weak) id <ShareViewDelegate> delegate;
/**
 *  显示出来
 */
- (void)displayToWindow;
/**
 *  隐藏移除
 */
- (void)removeFromWindow;
@end

@interface ShareItem : UIButton
@property (nonatomic , assign) ShareTypes type;
- (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image
                         type:(ShareTypes)type;
@end
