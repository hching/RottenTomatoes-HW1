//
//  MovieDetailsViewController.m
//  RottenTomatoes
//
//  Created by Henry Ching on 9/15/15.
//  Copyright © 2015 Henry Ching. All rights reserved.
//

#import "MovieDetailsViewController.h"
#import "MovieDetailsTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface MovieDetailsViewController ()
@property (weak, nonatomic) IBOutlet MovieDetailsTableViewCell *movieDetailsCell;
@end

@implementation MovieDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.movieTitle;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (MovieDetailsTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"com.yahoo.moviedetailscell"];
    
    //NSLog(@"response: %@", self.photoURL);
    cell.movieDetailsText.text = self.movieText;
    cell.movieTitleText.text = self.movieTitle;
    cell.criticsReviewText.text = self.criticsReview;
    cell.audienceReviewText.text = self.audienceReview;

    NSString *url = [NSString stringWithFormat:@"%@", self.posterURL];
    NSRange range = [url rangeOfString:@".*cloudfront.net/" options:NSRegularExpressionSearch];
    if (range.location != NSNotFound) {
        url = [url stringByReplacingCharactersInRange:range withString:@"https://content6.flixster.com/"];
    }
    [cell.movieDetailsImage setImageWithURL:[NSURL URLWithString:url]];
    
    return cell;
}


@end
