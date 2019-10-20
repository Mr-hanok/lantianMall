//
//  PropertyDetailsScrollView.h
//  TheProjectFrameWork
//
//  Created by TheMacBook on 16/7/26.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PropertyClickButton;
@protocol PropertyDetailsScrollViewDelegate <NSObject>

- (void)propertyDetailsScrollClickWithType:(NSInteger)type;

@end
@protocol PropertyHeaderViewDelegate <NSObject>

- (void)propertyHeaderClickWithIndex:(NSInteger)index;

@end
/**
 *  余额积分分类显示
 */
@interface PropertyDetailsScrollView : UIView
@property (nonatomic , weak) id <PropertyDetailsScrollViewDelegate> delegate;

@property (nonatomic , strong) NSArray * dataArray;
@property (nonatomic, assign) BOOL isGold;
- (void)reloadWithArray:(NSArray *)array withIsGold:(BOOL)isGold;

@end


@interface PropertyHeaderView : UIView
@property (nonatomic , weak) id <PropertyHeaderViewDelegate> delegate;

@property (nonatomic , strong) NSArray * titles;
- (instancetype)initWithTitles:(NSArray *)titles;
@end

@protocol PropertyClickButtonDelegate <NSObject>
@optional
- (void)propertyClickButton:(PropertyClickButton *)sender;
@end
@interface PropertyClickButton : UIView
@property (nonatomic , copy) NSString * title;
@property (nonatomic , assign) BOOL selected;

@property (nonatomic , weak) id <PropertyClickButtonDelegate> delegate;

@end