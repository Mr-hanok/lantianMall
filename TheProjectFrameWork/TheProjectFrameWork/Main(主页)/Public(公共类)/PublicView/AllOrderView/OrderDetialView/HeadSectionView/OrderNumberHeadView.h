//
//  OrderNumberHeadView.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/21.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderNumberHeadView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UILabel *orderNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeNameLabel;

- (void)configOrderHeadWithOrderNum:(NSString *)num orderState:(NSString *)state;
@end
