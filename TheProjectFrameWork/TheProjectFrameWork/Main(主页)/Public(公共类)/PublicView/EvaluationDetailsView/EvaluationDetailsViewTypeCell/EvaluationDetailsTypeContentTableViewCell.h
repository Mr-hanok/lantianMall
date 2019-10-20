//
//  EvaluationDetailsTypeContentTableViewCell.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/8.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EvaluationDetailsTypeContentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UIView *levelView;
@property (weak, nonatomic) IBOutlet UIView *starView;
@property (weak, nonatomic) IBOutlet UILabel *evalutaionName;
@property (weak, nonatomic) IBOutlet UILabel *evaluationTime;
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameWIdth;
-(void)LoadData:(id)Model;
@end
