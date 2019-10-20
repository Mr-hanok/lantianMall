//
//  EvalutaionTypeContentTableViewCellDelegate.h
//  TheProjectFrameWork
//
//  Created by maple on 16/7/29.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EvalutaionTypeContentTableViewCellDelegate <NSObject>
-(void)EvalutaionTypeContentTableViewCellEvaluationClickedWithIndexPath:(NSIndexPath*)indexPath;
-(void)EvalutaionTypeContentTableViewCellthumbUpButton:(UIButton*)button WithIndexPath:(NSIndexPath*)indexPath;
@end
