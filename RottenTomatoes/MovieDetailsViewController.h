//
//  MovieDetailsViewController.h
//  RottenTomatoes
//
//  Created by Henry Ching on 9/15/15.
//  Copyright © 2015 Henry Ching. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieDetailsViewController : UIViewController

@property (strong, nonatomic) NSURL *posterURL;
@property (strong, nonatomic) NSString *movieText;
@property (strong, nonatomic) NSString *movieTitle;
@property (strong, nonatomic) NSString *criticsReview;
@property (strong, nonatomic) NSString *audienceReview;
@end
