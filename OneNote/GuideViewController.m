//
//  GuideViewController.m
//  OneNote
//
//  Created by Dongjia Zheng on 15/12/2.
//  Copyright © 2015年 Dongjia Zheng. All rights reserved.
//

#import "GuideViewController.h"
#import "GuideView.h"

@interface GuideViewController () <GuideViewDelegate>
@property GuideView *guideView;

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    if (![defaults objectForKey:@"intro_screen_viewed"]) {
        self.guideView = [[GuideView alloc] initWithFrame:self.view.frame];
        self.guideView.delegate = self;
        self.guideView.backgroundColor = [UIColor colorWithWhite:0.149 alpha:1.000];
        [self.view addSubview:self.guideView];
//    }
}

#pragma mark - GuideViewDelegate Methods

-(void)onDoneButtonPressed{
    
    //    Uncomment so that the guideView does not show after the user clicks "DONE"
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        [defaults setObject:@"YES"forKey:@"intro_screen_viewed"];
//        [defaults synchronize];
    
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.guideView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.guideView removeFromSuperview];
        
        //进入主界面
        self.didSelectedEnter();
    }];
}

-(void)onQQLoginButtonPressed{
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.guideView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.guideView removeFromSuperview];
        
        //进入QQ登陆界面
        self.didSelectedQQLogin();
    }];
}

@end
