//
//  BaseSpaceTableViewCell.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/8/4.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>


@class BackGroundView;
@interface BackGroundView : UIView
@property (nonatomic , assign) BOOL separator;

@end
@interface BaseSpaceTableViewCell : UITableViewCell
@property (nonatomic , weak) BackGroundView * backView;
@end
