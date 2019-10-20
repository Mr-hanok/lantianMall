//
//  EvaluateContentCell.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/25.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseTableViewCell.h"
@class EvaluateContentCell,OrderGoodsModel,EvalutionDetialModel;
@protocol EvaluateContentCellDelegate <NSObject>
- (void)evaluateContent:(EvaluateContentCell *)cell photoIndex:(NSInteger)index;
- (void)evaluateCell:(EvaluateContentCell *)cell Text:(NSString *)text;
- (void)evaluateTypeCell:(EvaluateContentCell *)cell WithType:(NSInteger)type;
@end
/**
 *  评价内容
 */
@interface EvaluateContentCell : BaseTableViewCell
@property (nonatomic , weak) id <EvaluateContentCellDelegate> delegate;
@property (nonatomic , strong) NSArray * allImage;
@property (nonatomic , strong) OrderGoodsModel * model;
@property (nonatomic , strong) EvalutionDetialModel * contentModel;
@property (nonatomic , assign) NSInteger row;
- (void)setPhotoSelectImage:(UIImage *)image imagePath:(NSString *)imagePath tag:(NSInteger)tag;
@end
