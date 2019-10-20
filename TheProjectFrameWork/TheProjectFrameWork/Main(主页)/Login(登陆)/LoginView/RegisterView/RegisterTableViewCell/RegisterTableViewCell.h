//
//  RegisterTableViewCell.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/4.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterTableViewCell : UITableViewCell
- (void)setText:(NSString *)text detailText:(NSString *)detailText;
- (void)setText:(NSString *)text detailText:(NSString *)detailText phone:(NSString *)phone;
@end
