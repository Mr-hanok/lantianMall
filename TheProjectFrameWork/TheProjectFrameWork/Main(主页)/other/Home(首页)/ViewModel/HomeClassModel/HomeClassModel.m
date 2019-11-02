//
//  HomeClassModel.m
//  TheProjectFrameWork
//
//  Created by maple on 16/7/27.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "HomeClassModel.h"

@implementation HomeClassModel

+(NSDictionary*)mj_replacedKeyFromPropertyName
{
        return @{
                 @"goodsID" : @"id",
                 @"goodsName" : @"className",
                 @"childrens" : @"childs",
                 };
}
+(NSDictionary *)mj_objectClassInArray{
    return @{@"childrens":@"HomeClassModel"};
}
-(float)configHeight{
    if (self.height) {
        return self.height;
    }else{
        
        NSInteger row = 0;
        for (HomeClassModel *model in self.childrens) {
            NSInteger temp = model.childrens.count%3?1:0;
            row = row +(model.childrens.count/3.0+temp);
        }
        //(KSCREEN_WIDTH-120-20-40)/3.0+35)
        //(collectionView.frame.size.width-40)/3+35
        float height = ((KSCREEN_WIDTH-120-60)/3.0+45)*row +40*self.childrens.count;
        if (KSCREEN_WIDTH==320) {
            height = ((KSCREEN_WIDTH-120*320/375.0-60)/3.0+60)*row +40*self.childrens.count;
        }
//        if (height<KScreenBoundHeight-kStatusHeight-KTabBarHeight) {
//            self.height = KScreenBoundHeight-kStatusHeight-KTabBarHeight;
//            return KScreenBoundHeight-kStatusHeight-KTabBarHeight;
//        }
        self.height = height+10;
        return self.height;
        
    }
}

@end
