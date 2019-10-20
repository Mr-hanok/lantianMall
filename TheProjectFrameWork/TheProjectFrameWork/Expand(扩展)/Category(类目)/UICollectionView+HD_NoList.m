//
//  UICollectionView+HD_NoList.m
//  TheProjectFrameWork
//
//  Created by yuntai on 2017/12/15.
//  Copyright © 2017年 MapleDongSen. All rights reserved.
//

#import "UICollectionView+HD_NoList.h"
#import <objc/runtime.h>
#import "UIView+Frame.h"

static const void *kshowNoView = @"kkshowNoView";

@implementation UICollectionView (HD_NoList)
///
-(UIImageView *)im{
    UIImageView *im = [[UIImageView alloc]init];
    im.image = [UIImage imageNamed:@"emptyOrderImage"];
    im.contentMode =UIViewContentModeCenter;
    
    return im  ;
}
/// <#annotation#>
-(UILabel *)label{
    UILabel  *_label = [[UILabel alloc]init];
    _label.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:153/255.0];
    _label.font = [UIFont systemFontOfSize:15];
    _label.text = @"暂无相关数据";
    _label.numberOfLines = 0;
    _label.textAlignment = NSTextAlignmentCenter;
    return _label;
}
-(UIView *)containerV{
    UIView *v = [[UIView alloc]init];
    v.tag = 8808;
    //    v.backgroundColor = [UIColor redColor];
    return v;
    
}


#pragma mark - BOOL类型的动态绑定
- (BOOL)showNoView {
    return [objc_getAssociatedObject(self, kshowNoView) boolValue];
}
-(BOOL)isShowNoView{
    return [objc_getAssociatedObject(self, kshowNoView) boolValue];
}
- (void)setShowNoView:(BOOL)showNoView {
    objc_setAssociatedObject(self, kshowNoView, [NSNumber numberWithBool:showNoView], OBJC_ASSOCIATION_ASSIGN);
}

-(void)showNoView:(NSString *)title image:(UIImage *)placeImage certer:(CGPoint)p isShow:(BOOL)isShow{
    
    if (!isShow) {
        [self dismissNoView];
        return;
    }else{
        __block BOOL ishave ;
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.tag == 8808) {
                ishave = YES;
            }
        }];
        if (ishave) {
            return;
        }
    }

    UIView *containerV = [self containerV];
    
    containerV.width =[UIScreen mainScreen].bounds.size.width;
    //    containerV.height = 100;
    UILabel *label = [self label];
    UIImageView *iv = [self im];
    
    if (title) {
        label.text = title;
    }
    if (placeImage) {
        iv.image =placeImage;
    }
    
    
    
    
    iv.size = iv.image.size;
    iv.y = 0;
    iv.centerX = containerV.width/2.0;
    [iv sizeToFit];
    label.width =containerV.width;
    [label sizeToFit];
    label.centerX = containerV.width/2.0;
    label.y = CGRectGetMaxY(iv.frame)+12;
    
    containerV.height = CGRectGetMaxY(label.frame);
    if (p.x>0&&p.y>0) {
        containerV.center = p;
    }else{
        containerV.x = 0;
        containerV.y = 100;
    }
    
    [containerV addSubview:iv];
    [containerV addSubview:label];
    [self addSubview: containerV];
    [self setShowNoView:YES];
    
}
-(void)dismissNoView{
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.tag == 8808) {
            [obj removeFromSuperview];
            [self setShowNoView:NO];
        }
    }];
}

@end
