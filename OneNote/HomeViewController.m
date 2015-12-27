//
//  HomeViewController.m
//  OneNote
//
//  Created by Dongjia Zheng on 15/12/2.
//  Copyright © 2015年 Dongjia Zheng. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "HomeView.h"
#import <BmobSDK/Bmob.h>

#define vBackBarButtonItemName  @"backArrow.png"    //导航条返回默认图片名

@interface HomeViewController ()

@property (nonatomic,strong) HomeView* homeVC;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.homeVC = [[HomeView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.homeVC];
    self.title = NSLocalizedString(@"Home", "Home");
    
    //设置侧边栏Button
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.frame = CGRectMake(0, 0, 20, 18);
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    
    //从QQ接口获取账户信息：初始化 用户头像+用户名
    BmobUser* user = [[BmobUser alloc]init];
    [user setUsername:@"zheng"];
    [user setPassword:@"666"];
    [user setEmail:@"zdj@mail.com"];
    [user signUpInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            NSLog(@"User Successful");
        }else{
            NSLog(@"User Failed");
        }
        
        if (error) {
            NSLog(@"Error!");
        }
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) openOrCloseLeftList
{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (tempAppDelegate.LeftSlideVC.closed)
    {
        [tempAppDelegate.LeftSlideVC openLeftView];
    }
    else
    {
        [tempAppDelegate.LeftSlideVC closeLeftView];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear");
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
