//
//  MovieDetailsTableViewCell.h
//  RottenTomatoes
//
//  Created by Henry Ching on 9/15/15.
//  Copyright © 2015 Henry Ching. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieDetailsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *movieDetailsImage;
@property (weak, nonatomic) IBOutlet UITextView *movieDetailsText;
@property (weak, nonatomic) IBOutlet UILabel *movieTitleText;
@property (weak, nonatomic) IBOutlet UILabel *criticsReviewText;
@property (weak, nonatomic) IBOutlet UILabel *audienceReviewText;
@end
