//
//  RebateDetailsCell.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/11.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface RebateDetailsCell : BaseTableViewCell
- (void)loadDetails:(NSArray *)details;
@end


@interface  RebateDetails : UIView
@property (nonatomic , copy) NSString * date;
@property (nonatomic , copy) NSString * content;
@property (nonatomic , copy) NSString * value;



@end