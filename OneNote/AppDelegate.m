//
//  AppDelegate.m
//  OneNote
//
//  Created by Dongjia Zheng on 15/11/24.
//  Copyright © 2015年 Dongjia Zheng. All rights reserved.
//

#import "AppDelegate.h"
#import "GuideViewController.h"
#import "HomeViewController.h"
#import "LeftSortsViewController.h"

#import <TencentOpenAPI/TencentOAuth.h>
#import <BmobSDK/Bmob.h>

#define FirstTimeIn @"firstTimeIn"
#define TencentRedirectURL @"www.qq.com"

@interface AppDelegate () <TencentSessionDelegate>

@property (nonatomic,strong) GuideViewController* guideVC;
@property (nonatomic,strong) HomeViewController* homeVC;

//QQ登陆
@property (retain, nonatomic) IBOutlet UITextField *QQLoginResultText;
@property (retain, nonatomic) IBOutlet UITextField *QQLoginAccessTokenText;
@property (retain,nonatomic) NSString *QQAccessToken;
@property (retain,nonatomic) NSString *QQOpenID;
@property (retain,nonatomic) NSDate *QQExpirationDate;

@end

@implementation AppDelegate

#pragma mark - Lifecycle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //启动Bmob后台云服务
    [Bmob registerWithAppKey:AppKey_Bmob];
    
    //QQ接口：初始化TencentOAuth
    _tencentOAuth = [[TencentOAuth alloc] initWithAppId:AppID_QQ andDelegate:self];
    _tencentOAuth.redirectURI = TencentRedirectURL;
    _permissions = [NSArray arrayWithObjects:
                    kOPEN_PERMISSION_GET_USER_INFO,
                    kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                    kOPEN_PERMISSION_ADD_ALBUM,
                    kOPEN_PERMISSION_ADD_IDOL,
                    kOPEN_PERMISSION_ADD_ONE_BLOG,
                    kOPEN_PERMISSION_ADD_PIC_T,
                    kOPEN_PERMISSION_ADD_SHARE,
                    kOPEN_PERMISSION_ADD_TOPIC,
                    kOPEN_PERMISSION_CHECK_PAGE_FANS,
                    kOPEN_PERMISSION_DEL_IDOL,
                    kOPEN_PERMISSION_DEL_T,
                    kOPEN_PERMISSION_GET_FANSLIST,
                    kOPEN_PERMISSION_GET_IDOLLIST,
                    kOPEN_PERMISSION_GET_INFO,
                    kOPEN_PERMISSION_GET_OTHER_INFO,
                    kOPEN_PERMISSION_GET_REPOST_LIST,
                    kOPEN_PERMISSION_LIST_ALBUM,
                    kOPEN_PERMISSION_UPLOAD_PIC,
                    kOPEN_PERMISSION_GET_VIP_INFO,
                    kOPEN_PERMISSION_GET_VIP_RICH_INFO,
                    kOPEN_PERMISSION_GET_INTIMATE_FRIENDS_WEIBO,
                    kOPEN_PERMISSION_MATCH_NICK_TIPS_WEIBO,
                    nil];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //如果不是第一次进入App，直接进入主界面;否则，进入引导页
    if ([defaults objectForKey:FirstTimeIn]) {
        [self enterHomeView];
    }else{
        [self enterGuideView];
        //添加已经进入过App的记录
//        [defaults setObject:@"YES"forKey:FirstTimeIn];
//        if ([defaults synchronize]) {
//            NSLog(@"NSUserDefaults:Data was saved successfully to disk!");
//        }else{
//            NSLog(@"NSUserDefaults:Data was not saved to disk!");
//        }
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
//    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
//    [defaults removeObjectForKey:FirstTimeIn];
//    [defaults synchronize];
}

#pragma mark - QQ接口登陆：重写AppDelegate 的 handleOpenURL & openURL
- (BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(nonnull id)annotation{
    return [TencentOAuth HandleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(nonnull NSURL *)url{
    return [TencentOAuth HandleOpenURL:url];
}

#pragma mark - Enter Guide View 引导页
- (void)enterGuideView{
    //添加引导页
    self.guideVC = [[GuideViewController alloc] init];
    [self.window setRootViewController:self.guideVC];
    
    __weak AppDelegate *weakSelf = self;
    
    //进入主页
    self.guideVC.didSelectedEnter = ^(){
        [weakSelf.guideVC.view removeFromSuperview];
        weakSelf.guideVC = nil;
        [weakSelf enterHomeView];
    };
    
    //进入QQ登陆界面
    self.guideVC.didSelectedQQLogin = ^(){
        [weakSelf.guideVC.view removeFromSuperview];
        weakSelf.guideVC = nil;
        [weakSelf enterQQLoginView];
    };
}

#pragma mark - Enter Home View 主界面
- (void)enterHomeView{
    self.homeVC = [[HomeViewController alloc] init];
    self.mainNavigationController = [[UINavigationController alloc] initWithRootViewController:self.homeVC];
    LeftSortsViewController *leftVC = [[LeftSortsViewController alloc] init];
    self.LeftSlideVC = [[LeftSlideViewController alloc] initWithLeftView:leftVC andMainView:self.mainNavigationController];
    self.window.rootViewController = self.LeftSlideVC;
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor purpleColor]];
    [self.window setRootViewController:self.LeftSlideVC];
}

#pragma mark - Enter QQ Login View QQ登陆界面
- (void)enterQQLoginView{
    [_tencentOAuth authorize:_permissions inSafari:NO];
}


#pragma mark - TencentLoginDelegate
/**
 * 登录成功后的回调
 */
- (void)tencentDidLogin{
    //进入主界面
    [self enterHomeView];
    
    _QQLoginResultText = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    _QQLoginResultText.text = @"已经登录！";
    _QQAccessToken = [_tencentOAuth accessToken];
    _QQOpenID = [_tencentOAuth openId];
    _QQExpirationDate = [_tencentOAuth expirationDate];
    NSLog(@"登陆结果:%@ \n 登陆Token:%@ \n 登陆Open ID:%@  \nToken失效日期:%@",_QQLoginResultText.text, _QQAccessToken, _QQOpenID, _QQExpirationDate);
    
    if (_tencentOAuth.accessToken && 0 != [_tencentOAuth.accessToken length]) {
        //记录登录用户的OpenID & Token & 过期时间
        _QQLoginAccessTokenText = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        _QQLoginAccessTokenText.text = _tencentOAuth.accessToken;
    }else{
        _QQLoginAccessTokenText.text = @"登陆失败，没有获取access token";
    }
}

/**
 * 登录失败后的回调
 * \param cancelled 代表用户是否主动退出登录
 */
- (void)tencentDidNotLogin:(BOOL)cancelled{
    if (cancelled) {
        _QQLoginResultText.text = @"用户取消登陆";
    }else{
        _QQLoginResultText.text = @"登录失败";
    }
    NSLog(@"%@",_QQLoginResultText.text);
}

/**
 * 登录时网络有问题的回调
 */
- (void)tencentDidNotNetWork{
    _QQLoginResultText.text = @"无网络连接，请设置网络";
}

#pragma mark - TencentSessionDelegate
/**
 * 获取用户个人信息回调
 * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
 * \remarks 正确返回示例: \snippet example/getUserInfoResponse.exp success
 *          错误返回示例: \snippet example/getUserInfoResponse.exp fail
 */
- (void)getUserInfoResponse:(APIResponse*) response{
    NSLog(@"%@",response);
}

/**
 * 通知第三方界面需要被关闭
 * \param tencentOAuth 返回回调的tencentOAuth对象
 * \param viewController 需要关闭的viewController
 */
- (void)tencentOAuth:(TencentOAuth *)tencentOAuth doCloseViewController:(UIViewController *)viewController{
    NSLog(@"closing view controller");
}
@end
