//
//  ClassScreeningDetialTableViewCell.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/7.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassScreeningDetialTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *namelabel;
@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;
-(void)LoadDatawith:(id)model and:(BOOL)isselected;
@end
