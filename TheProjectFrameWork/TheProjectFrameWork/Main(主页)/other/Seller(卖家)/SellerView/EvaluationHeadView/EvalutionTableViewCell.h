//
//  EvalutionTableViewCell.h
//  TheProjectFrameWork
//
//  Created by maple on 16/8/4.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IQTextView.h>

@interface EvalutionTableViewCell : UITableViewCell
/** 加一分 */
@property (weak, nonatomic) IBOutlet UILabel *addapointLabel;
/** 不加分 */
@property (weak, nonatomic) IBOutlet UILabel *noaddapointLabel;
/** 减一份 */
@property (weak, nonatomic) IBOutlet UILabel *minusonepointsLabel;



/** 好评 */

@property (weak, nonatomic) IBOutlet UIButton *HighpraiseButton;
/** 中评 */
@property (weak, nonatomic) IBOutlet UIButton *middleButton;
/** 差评 */
@property (weak, nonatomic) IBOutlet UIButton *lowButton;
/** 评价内容 */
@property (weak, nonatomic) IBOutlet IQTextView *evaluationTextView;
@end
