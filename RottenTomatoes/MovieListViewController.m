//
//  MovieListViewController.m
//  RottenTomatoes
//
//  Created by Henry Ching on 9/15/15.
//  Copyright © 2015 Henry Ching. All rights reserved.
//

#import "MovieListViewController.h"
#import "MovieTableViewCell.h"
#import "NetworkErrorTableViewCell.h"
#import "MovieDetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "AMTumblrHud.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface MovieListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *movieListTableView;
@property (strong, atomic) NSArray *movieData;
@property NSInteger rowselected;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property BOOL networkError;
@end

@implementation MovieListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Movies";
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.movieListTableView insertSubview:self.refreshControl atIndex:0];
    
    self.view.backgroundColor = UIColorFromRGB(0x34465C);
    AMTumblrHud *tumblrHUD = [[AMTumblrHud alloc] initWithFrame:CGRectMake((CGFloat) ((self.view.frame.size.width - 55) * 0.5),
                                                                           (CGFloat) ((self.view.frame.size.height - 20) * 0.5), 55, 20)];
    tumblrHUD.hudColor = UIColorFromRGB(0xF1F2F3);
    [self.view addSubview:tumblrHUD];
    [tumblrHUD showAnimated:YES];
    
    NSURL *url = [NSURL URLWithString: @"https://gist.githubusercontent.com/timothy1ee/d1778ca5b944ed974db0/raw/489d812c7ceeec0ac15ab77bf7c47849f2d1eb2b/gistfile1.json"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * response, NSData * data, NSError * connectionError) {
        
        if (connectionError == nil) {
            self.networkError = NO;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.movieData = [responseDictionary objectForKey:@"movies"];
        } else {
            self.networkError = YES;
        }
        [tumblrHUD showAnimated:NO];
        [self.movieListTableView reloadData];
    }];
}

- (void)onRefresh {
    NSURL *url = [NSURL URLWithString:@"https://gist.githubusercontent.com/timothy1ee/d1778ca5b944ed974db0/raw/489d812c7ceeec0ac15ab77bf7c47849f2d1eb2b/gistfile2.json"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (connectionError == nil) {
            self.networkError = NO;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.movieData = [responseDictionary objectForKey:@"movies"];
        } else {
            self.networkError = YES;
        }
        [self.movieListTableView reloadData];
        [self.refreshControl endRefreshing];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.networkError == NO) {
        self.movieListTableView.rowHeight = 110;
        return self.movieData.count;
    } else {
        self.movieListTableView.rowHeight = 25;
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.networkError == NO) {
        MovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"com.yahoo.moviecell"];
        NSDictionary *movieObj = self.movieData[indexPath.row];
        cell.movieTitleLabel.text = movieObj[@"title"];
        cell.movieSynopsisLabel.text = movieObj[@"synopsis"];
        [cell.posterImageView setImageWithURL:[NSURL URLWithString:movieObj[@"posters"][@"original"]]];
        return cell;
    } else {
        NetworkErrorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"com.yahoo.networkerrorcell"];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.rowselected = indexPath.row;
    [self performSegueWithIdentifier:@"movieDetailsSegway" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"movieDetailsSegway"])
    {
        // Get reference to the destination view controller
        MovieDetailsViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        
        NSDictionary *movieObj = self.movieData[self.rowselected];
        NSString *urlString = movieObj[@"posters"][@"original"];
        NSURL *url = [[NSURL alloc] initWithString: urlString];
        
        //NSLog(@"response: %@", url);
        [vc setPosterURL:url];
        [vc setMovieTitle:movieObj[@"title"]];
        [vc setMovieText:movieObj[@"synopsis"]];
        [vc setCriticsReview:[NSString stringWithFormat:@"Critics Review: %@", movieObj[@"ratings"][@"critics_score"]]];
        [vc setAudienceReview:[NSString stringWithFormat:@"Audience Score: %@", movieObj[@"ratings"][@"audience_score"]]];
    }
}


@end
