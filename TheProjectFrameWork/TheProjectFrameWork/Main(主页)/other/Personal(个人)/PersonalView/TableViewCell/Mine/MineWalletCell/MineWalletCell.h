//
//  MineWalletCell.h
//  TheProjectFrameWork
//
//  Created by ZengPengYuan on 16/7/8.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "BaseSpaceTableViewCell.h"

@interface MineWalletCell : BaseSpaceTableViewCell
@property (nonatomic , strong) UIImage * image;
@property (nonatomic , copy) NSString * title;
@property (nonatomic , copy) NSString * value;
@end
