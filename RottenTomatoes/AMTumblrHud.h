//
//  AMTumblrHud.h
//  RottenTomatoes
//
//  Created by Henry Ching on 9/15/15.
//  Copyright © 2015 Henry Ching. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMTumblrHud : UIView

@property (nonatomic, strong) UIColor *hudColor;

-(void)showAnimated:(BOOL)animated;
-(void)hide;

@end
