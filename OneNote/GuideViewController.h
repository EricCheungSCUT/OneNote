//
//  GuideViewController.h
//  OneNote
//
//  Created by Dongjia Zheng on 15/12/2.
//  Copyright © 2015年 Dongjia Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DidSelectedEnter)();
typedef void (^DidSelectedQQLogin)();

@interface GuideViewController : UIViewController

@property (nonatomic, copy) DidSelectedEnter didSelectedEnter;
@property (nonatomic, copy) DidSelectedQQLogin didSelectedQQLogin;

@end
