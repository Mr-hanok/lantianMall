//
//  ComplaintGoodsCell.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/12.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseSpaceTableViewCell.h"
@class FillComplaintInfoCell,DialogueDetailsCell,ComplaintDetailedModel,BuyerOrderModel,OrderGoodsModel,ComplaintGoodsCell,GoodsBriefInfoView;
@protocol ComplaintGoodsCellDelegate <NSObject>

@optional
- (void)complaintGoodsCellClick:(ComplaintGoodsCell *)cell good_id:(NSString *)good_id;

@end


/**
 *  投诉商品信息
 */
@interface ComplaintGoodsCell : BaseSpaceTableViewCell
@property (nonatomic , weak) BuyerOrderModel * buyerOrder;
@property (nonatomic , weak) NSArray <OrderGoodsModel *>* goodsModel;
@property (nonatomic , weak) ComplaintDetailedModel * model;
@property (nonatomic , weak) id <ComplaintGoodsCellDelegate> delegate;
@property (nonatomic , strong) NSMutableArray <GoodsBriefInfoView *>* contentArray;
@end

/**
 *  投诉商品描述
 */
@interface ComplaintDescribeCell : BaseSpaceTableViewCell
@property (nonatomic , weak) ComplaintDetailedModel * model;

@end


/**
 *  投诉信息状态
 */
@interface ComplaintStateCell : BaseSpaceTableViewCell
@property (nonatomic , weak) ComplaintDetailedModel * model;
//@property (nonatomic , weak) id delegate;

@end

@protocol FillComplaintInfoCellDelegate <NSObject>

- (void)fillComplaintWithCell:(FillComplaintInfoCell *)cell tag:(NSInteger)tag residual:(NSInteger)residual;
- (void)fillComplaintWithCell:(FillComplaintInfoCell *)cell appealContent:(NSString *)content;
@end
/**
 *   填写申诉信息
 */
@interface FillComplaintInfoCell : BaseSpaceTableViewCell
@property (nonatomic , weak) id <FillComplaintInfoCellDelegate> delegate;
- (NSArray *)allImages;
- (void)setPhotoImage:(UIImage *)image;
- (NSString *)appealContent;
@end
@protocol AppealInfoCellDelegate <NSObject>



@end
/**
 *  申诉信息
 */
@interface AppealInfoCell : BaseSpaceTableViewCell
@property (nonatomic , weak) ComplaintDetailedModel * model;
@end


@protocol DialogueDetailsCellDelegate <NSObject>
/**
 *  发布对话
 *
 *  @param cell <#cell description#>
 */
- (void)dialogueDetailsPublishWithCell:(DialogueDetailsCell *)cell;
/**
 *  刷新对话
 *
 *  @param cell <#cell description#>
 */
- (void)dialogueDetailsReloadWithCell:(DialogueDetailsCell *)cell;
/**
 *  提交仲裁
 *
 *  @param cell <#cell description#>
 */
- (void)dialogueDetailsSubmitWithCell:(DialogueDetailsCell *)cell;
@end
/**
 *   双方对话详情
 */
@interface DialogueDetailsCell : BaseSpaceTableViewCell
@property (nonatomic , weak) id <DialogueDetailsCellDelegate> delegate;
@property (nonatomic , weak) ComplaintDetailedModel * model;

@property (nonatomic , assign) BOOL isFinish;
- (void)reloadChatRecordWithArr:(NSArray *)arr;
@end

/**
 *  仲裁信息
 */
@interface ArbitrationInfoCell : BaseSpaceTableViewCell
@property (nonatomic , weak) ComplaintDetailedModel * model;
@end
