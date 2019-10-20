//
//  PersonViewModel.m
//  TheProjectFrameWork
//
//  Created by TheMacBook on 2016/10/21.
//  Copyright © 2016年 MapleDongSen. All rights reserved.
//

#import "PersonViewModel.h"
#import "ShopModel.h"
#import "BaseViewController.h"
#import "MineTableViewHeaderView.h"
#import "PhotoInfoModel.h"
@implementation PersonViewModel
{
    BOOL _isLoad;
}
- (void)refreshUserInfo
{
    if(![UserAccountManager shareUserAccountManager].loginStatus)
    {
        [self.controller endRefresh];
        return;
    }
    WeakSelf(self)
    [[UserAccountManager shareUserAccountManager] getUserInfoComplete:^(id error ,BOOL successful) {
        [weakSelf.controller endRefresh];
        if(!successful && !error)
        {
            return ;
        }
        if(error)
        {
            [HUDManager showWarningWithError:error];
        }else
        {
            [weakSelf.tableView reloadData];
            [weakSelf.headerView updateViewInfo];
        }
    }];
}
- (void)getUserShopInfo
{
    if(_isLoad)
    {
        return;
    }
    _isLoad = YES;
    [NetWork PostNetWorkWithUrl:@"/seller/my_store_info" with:@{@"user_id":kUserId} successBlock:^(NSDictionary *dic) {
        _isLoad = NO;
        BOOL status = [dic[@"status"] boolValue];
        if(status)
        {
            NSInteger storeStatus = [dic[@"data"][@"storeStatus"] integerValue];
            switch (storeStatus) {
                case 0:
                case -1:
                case 1:
                case 3:
                {
//                    SellerRegisterAuthenViewController * view = [[SellerRegisterAuthenViewController alloc] init];
//                    view.registerState = [NSString stringWithFormat:@"%zd",storeStatus];
//                    view.hidesBottomBarWhenPushed = YES;
//                    [self.controller.navigationController pushViewController:view animated:YES];
                }
                    break;
                case 2:
                {
                }
                    break;
                    
                default:
                {
                    [HUDManager showWarningWithText:@"店铺不可用,请联系管理员"];
                }
                    break;
            }
        }else
        {
            if([dic[@"statusStr"] isKindOfClass:[NSNull class]])
            {
                [HUDManager showWarningWithText:@"获取店铺信息失败"];
                return ;
            }
            if([dic[@"statusStr"] isEqualToString:@"-1"])
            {
               
                UIAlertController *alertControl = [UIAlertController alertControllerWithTitle:LaguageControl(@"提示") message:LaguageControl(@"暂未开通店铺，请去注册") preferredStyle:UIAlertControllerStyleAlert];
                // 2.实例化按钮:actionWithTitle
                [alertControl addAction:[UIAlertAction actionWithTitle:@"注册" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action)
                                         {
//                                             SellerRegisterChoseViewController * view = [[SellerRegisterChoseViewController alloc] init];
//                                             view.hidesBottomBarWhenPushed = YES;
//                                             [self.controller.navigationController pushViewController:view animated:YES];
                                         }]];
                
                [alertControl addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
                [self.controller presentViewController:alertControl animated:YES completion:nil];
            }else if([dic[@"statusStr"] isEqualToString:@"0"]){
                [HUDManager showWarningWithText:@"平台暂时关闭了申请店铺功能!"];
            }else
            {
                [HUDManager showWarningWithText:@"获取店铺信息失败"];
            }
        }
    } errorBlock:^(NSString *error) {
        _isLoad = NO;
//        [HUDManager showWarningWithError:@"请检查网络"];
    }];
}


- (void)replaceUserIconWithImage:(UIImage *)image
{
    [HUDManager showLoadingHUDView:self.controller.view withText:@"请稍候"];
    __block PhotoInfoModel * model;
    [NetWork PostUpLoadImageWithImages:@[image] successBlock:^(NSArray<PhotoInfoModel *> *photoInfoArray) {
        model = [photoInfoArray firstObject];
        [self uploadUserIcon:image model:model];
    } FailureBlock:^(NSString *msg) {
        [HUDManager hideHUDView];
        [HUDManager showWarningWithError:msg];
    } errorBlock:^(id error) {
        [HUDManager hideHUDView];
        [HUDManager showWarningWithError:error];
    }];
}
- (void)uploadUserIcon:(UIImage *)icon model:(PhotoInfoModel *)model
{
    [NetWork PostNetWorkWithUrl:@"/buyer/update_photo" with:@{@"user_id":kUserId,@"photo_id":@(model.photoID)} successBlock:^(NSDictionary *dic) {
        [UserAccountManager shareUserAccountManager].userModel.iconUrl = dic[@"data"][@"url"];
        [self.headerView settingUserIconWithImage:icon];
        [HUDManager hideHUDView];
        [HUDManager showWarningWithText:@"头像更换成功"];
    } FailureBlock:^(NSString *msg) {
        [HUDManager hideHUDView];
        [HUDManager showWarningWithError:msg];
    } errorBlock:^(id error) {
        [HUDManager hideHUDView];
        [HUDManager showWarningWithError:error];
    }];
}

- (void)downloadNewIconUrl:(NSString *)url
{
    [NetWork loadImageWithUrl:url ImageDownloaderProgressBlock:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } ImageCompletionWithFinishedBlock:^(UIImage *image, NSError *error, BOOL finished, NSURL *imageURL) {
        if(image)
        {
            [self.headerView settingUserIconWithImage:image];
        }
    }];
    
}
@end
