//
//  BuyAndSendCostTableViewCell.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/11.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//
@class BuyAndSendCostTableViewCell;
#import <UIKit/UIKit.h>

@protocol BuyAndSendCostTableViewCellDelegate <NSObject>

-(void)BuyAndSendCostTableShowCostButtonClicked:(TaxTypes)type;
- (void)buyAndSendCostTableViewCell:(BuyAndSendCostTableViewCell *)cell btn:(UIButton *)btn;

@end

@interface BuyAndSendCostTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *selvippriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *selvippricebtn;
@property (weak, nonatomic) IBOutlet UILabel *manJianMoneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *vipPriceMoneyLabel;

@property(weak,nonatomic) id<BuyAndSendCostTableViewCellDelegate>delegate;
/** 运费宽度 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *freightLabelWidth;
/** 销售瑞宽度 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *salesstaxLabelWidth;

@property (weak, nonatomic) IBOutlet UIButton *salesTaxButton;

@property (weak, nonatomic) IBOutlet UIButton *costDetialButton;
/** 商品金额 */
@property (weak, nonatomic) IBOutlet UILabel *amountgoodsLabel;
/** 销售税 */
@property (weak, nonatomic) IBOutlet UILabel *salestaxLabel;
/** 运费 */
@property (weak, nonatomic) IBOutlet UILabel *freightLabel;

/** 总价 */
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
/** 税费 */
@property (weak, nonatomic) IBOutlet UILabel *taxesLabel;
/** 运费 */
@property (weak, nonatomic) IBOutlet UILabel *shipLabel;

@property (weak, nonatomic) IBOutlet UILabel *viplabel;

@property (weak, nonatomic) IBOutlet UILabel *manjianLabel;

@property (weak, nonatomic) IBOutlet UIImageView *bottomline;

@property (weak, nonatomic) IBOutlet UIImageView *bottomLine2;
@property (weak, nonatomic) IBOutlet UIImageView *bottomline3;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viplabelHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *manjianLabelHeigth;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *selvipbtnHeight;

@property (weak, nonatomic) IBOutlet UIView *fapiaoview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fapiaoviewheight;
@property (weak, nonatomic) IBOutlet UIButton *kaifapiaoBtn;
@property (weak, nonatomic) IBOutlet UILabel *kaifapiaoLabel;
@property (weak, nonatomic) IBOutlet UIButton *companyBtn;
@property (weak, nonatomic) IBOutlet UIButton *personBtn;
@property (weak, nonatomic) IBOutlet UITextField *fapiaoHeadTF;
@property (weak, nonatomic) IBOutlet UITextField *fapiaoPersonTF;
@property (weak, nonatomic) IBOutlet UILabel *taxNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *fapiaotypeLabel;

@property (weak, nonatomic) IBOutlet UILabel *taitouLabel;
@property (weak, nonatomic) IBOutlet UIView *taxnumView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *taxnumviewheight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fapiaotypeLabelHeight;

@property (nonatomic, copy) void (^selKaiFaPiaoBlock)(BOOL isSel);
/**0个人 1 公司 2 不开*/
@property (nonatomic, copy) void (^selKaiFaPiaoTypeBlocy)(NSString *isCompany);
@property (nonatomic, copy) void (^taxNumBlock)(NSString *string);
@property (nonatomic, copy) void (^yingYeNumBlock)(NSString *string);

@end
