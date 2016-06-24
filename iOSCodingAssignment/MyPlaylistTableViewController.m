//
//  MyPlaylistTableViewController.m
//  iOSCodingAssignment
//
//  Created by Hari Krishna Palempati on 11/11/15.
//  Copyright © 2015 ios.hari. All rights reserved.
//

#import "MyPlaylistTableViewController.h"

#import "MyPlaylistDataRequestor.h"
#import "PlaylistTableViewCell.h"
#import "PlayListEntry.h"

static NSString * const PlaylistCellIdentifier  =  @"PlaylistCell";
static NSString * const PlaylistURLString       =  @"https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=50&playlistId=PLWz5rJ2EKKc_XOgcRukSoKKjewFJZrKV0&key=AIzaSyBkKJRvNKAJ4cgdVY604OfkzhqHh7bvyi0";
CGFloat const cellHeight                        =  125.0f;

@interface MyPlaylistTableViewController ()
@property (strong, nonatomic) MyPlaylistDataRequestor *requestor;
@property (strong, nonatomic) NSArray *tableViewItems;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@end

@implementation MyPlaylistTableViewController

#pragma mark - View Life cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupActivityIndicator];
    [self registerPlaylistCell];
    [self playListEntriesFromURL:PlaylistURLString];
}

#pragma mark - Private methods

- (void)setupActivityIndicator {
    
    self.activityIndicator =  [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    self.activityIndicator.center = self.view.center;
    [self.tableView addSubview:self.activityIndicator];
}

- (void)registerPlaylistCell {
    
    UINib *playlistCell = [UINib nibWithNibName:@"PlaylistTableViewCell" bundle:nil];
    [self.tableView registerNib:playlistCell forCellReuseIdentifier:PlaylistCellIdentifier];
}

- (void)playListEntriesFromURL:(NSString *)urlString {
    
    self.requestor = [[MyPlaylistDataRequestor alloc] init];
    
    [self showHUD];
    
    __weak typeof(self) weakSelf = self;
    
    [self.requestor getJSONFromURLString:urlString success:^(NSArray *playlist){
    
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.tableViewItems = playlist;
        strongSelf.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [strongSelf.tableView reloadData];
        [strongSelf hideHUD];
    }failure:^(NSError *error){
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Error in loading playlist entries" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
        [alertView show];
    }];
}

- (void)showHUD {
    
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
}

- (void)hideHUD {

    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidden = YES;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.tableViewItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PlaylistTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PlaylistCellIdentifier forIndexPath:indexPath];
    
    PlayListEntry *item = self.tableViewItems[indexPath.row];
    [cell configureCellWithPlayListEntry:item];
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return cellHeight;
}

@end
