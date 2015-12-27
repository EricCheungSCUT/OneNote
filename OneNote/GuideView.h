//
//  GuideView.h
//  OneNote
//
//  Created by Dongjia Zheng on 15/12/2.
//  Copyright © 2015年 Dongjia Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GuideViewDelegate <NSObject>

-(void)onDoneButtonPressed;


@end

@interface GuideView : UIView

@property id<GuideViewDelegate> delegate;

@end
