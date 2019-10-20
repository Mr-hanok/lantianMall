//
//  HomeTableViewHeadSectionViewDelegate.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/14.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HomeTableViewHeadSectionViewDelegate <NSObject>

@optional
-(void)HomeTableViewHeadSectionViewDidSelectedWith:(NSIndexPath*)indexpath;

-(void)MorebuttonClicked:(UIButton*)button withSection:(NSInteger)section;

@end
