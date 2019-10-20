//
//  AllorderCell.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/6/29.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
@protocol AllorderCellDelegate <NSObject>
@optional
- (void)allorderClickEventWithType:(NSInteger)type;
@end
@interface AllorderCell : BaseTableViewCell
- (void)loadTitle:(NSString *)title
        accessory:(NSString *)accessory
            image:(UIImage *)image;
@property (nonatomic , weak) id <AllorderCellDelegate> delegate;
@property (nonatomic , assign) NSInteger type;
@end
