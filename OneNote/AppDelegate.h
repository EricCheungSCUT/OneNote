//
//  AppDelegate.h
//  OneNote
//
//  Created by Dongjia Zheng on 15/11/24.
//  Copyright © 2015年 Dongjia Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftSlideViewController.h"
#import <TencentOpenAPI/TencentOAuth.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    BOOL _isLogined;
}

@property (retain, nonatomic) TencentOAuth *tencentOAuth;
@property (retain, nonatomic) NSArray * permissions;

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) LeftSlideViewController *LeftSlideVC;
@property (strong, nonatomic) UINavigationController *mainNavigationController;

@end

