//
//  AttentionDelegate.h
//  TheProjectFrameWork
//
//  Created by maple on 16/8/19.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AttentionDelegate <NSObject>
-(void)AttentionView:(id)view withIndexPath:(NSIndexPath*)indexpath;
-(void)AttentionViewAddShopCart:(id)view withIndexPath:(NSIndexPath*)indexpath;
-(void)AttentionViewShareButton:(id)view withIndexPath:(NSIndexPath*)indexpath;

@end


