//
//  EvaluationDetailsTableViewCell.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/11.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EvaluationDetailsTableViewCell : UITableViewCell
/** <#注释#> */
@property (weak, nonatomic) IBOutlet UILabel *titleNameLabel;
/** <#注释#> */
@property (weak, nonatomic) IBOutlet UIView *starView;
/** <#注释#> */
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
/** <#注释#> */
@property (weak, nonatomic) IBOutlet UILabel *commentContentLabel;
@end
