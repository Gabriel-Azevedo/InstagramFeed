//
//  ViewController.m
//  InstagramFeed
//
//  Created by Gabriel Borri de Azevedo on 2/2/15.
//  Copyright (c) 2015 Gabriel Enterprises. All rights reserved.
//

#import "FeedViewController.h"
#import "CommentsViewController.h"
#import "CustomTableViewCell.h"

@interface FeedViewController () <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView; //view's tableView

@property NSInteger numberOfImagesToLoad; // numbers of photos displayed based on Parse count

@end

@implementation FeedViewController

#pragma mark - View Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.numberOfImagesToLoad = 5; //provisorily setting 5 photos to display
}

#pragma mark - Table View Methods
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Creating Cell
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    //Adding target to the button
    [cell.likeButton addTarget:self action:@selector(onLikeTapped:) forControlEvents:UIControlEventTouchUpInside];
    //Adding tag to button (later, use tag to identify which cell was tapped)
    cell.likeButton.tag = indexPath.section;
    //Adding target to the button
    [cell.commentButton addTarget:self action:@selector(onCommentButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    //Adding tag to button (later, use tag to identify which cell was tapped)
    cell.commentButton.tag = indexPath.section;
    //Adding target to the button
    [cell.usernameButton addTarget:self action:@selector(onHeaderUsernameTapped:) forControlEvents:UIControlEventTouchUpInside];
    //Adding tag to button (later, use tag to identify which cell was tapped)
    cell.usernameButton.tag = indexPath.section;
    //provisorily setting the username text
    cell.usernameButton.titleLabel.text = @"💬 username";
    //provisorily setting a photo palceholder
    cell.photoImageView.userInteractionEnabled = true;
    cell.photoImageView.image = [UIImage imageNamed:@"photo_placeholder.png"];
    cell.photoImageView.tag = indexPath.section;
    //Creating a tap gesture recognizer
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapGesture:)];
    tapGesture.numberOfTapsRequired = 2; //turning it into a double tap

    [cell.photoImageView addGestureRecognizer:tapGesture];//Adding tap to imageView (Photo)

    return cell; //Returning cell
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 485.0; // programatticly setting the cell's height to 505 pixels. Enough to display all info.
}

//To use custom headers (Profile photo and username) we have to create section.
//There will be a header for each section (photo), so we can have that "pushing up" effect.
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1; // one header per photo
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.numberOfImagesToLoad; // How many photos will be displayed ?
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // Here we're going to create a custom view in the header to display some information

    // We'll have a view the size of the header to contain all others subviews
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 50.0)];
    //View to display the user profile photo
    UIView *headerViewImage = [[UIView alloc] initWithFrame:CGRectMake(3.0, 3.0, 40.0, 40.0)];
    //View (Button) that contains the username
    UIButton *usernameButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    usernameButton.tag = section;
    //View to display that 1pxl line (separator)
    [usernameButton addTarget:self action:@selector(onHeaderUsernameTapped:) forControlEvents:UIControlEventTouchUpInside];
    //View to create an one pixel line (separator)
    UIView *headerSeparator = [[UIView alloc] initWithFrame:CGRectMake(0.0, 44.0, self.view.frame.size.width, 1.0)];
    //Setting the usernameButton properties
    [usernameButton setTitle:@"username" forState:UIControlStateNormal];
    usernameButton.tintColor = [UIColor blueColor];
    usernameButton.frame = CGRectMake(50.0, 3.0, 270.0, 40.0);
    usernameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //Setting the imageView (Photo) properties
    headerViewImage.backgroundColor = [UIColor greenColor]; // color to be replaced with image
    headerViewImage.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed: @"profile.png"]];
    headerView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.95]; // header transparency (translucidence)
    //Setting the separator properties
    headerSeparator.backgroundColor = [UIColor grayColor]; // separator color

    // adding subview to main view
    [headerView addSubview:headerViewImage];
    [headerView addSubview:usernameButton];
    [headerView addSubview:headerSeparator];

    // return the main view to display in the header
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45.0; // programmatically setting the header size
}

#pragma mark - Button Action Methods
- (IBAction)onHeaderUsernameTapped:(UIButton *)button // when photo liked to this...
{
    NSLog(@"username at section %li tapped", button.tag);
}

- (void)onCommentButtonTapped:(UIButton *)button // when comment button tapped do this...
{
    NSLog(@"comment button at section %li tapped", button.tag);
}

#pragma mark - Like Animation
-(void)onTapGesture:(UITapGestureRecognizer *)gesture
{
    [self animateHeartUsingSection:gesture.view.tag]; //the photo was double tapped, call animation
    NSLog(@"like button at section %li tapped", gesture.view.tag);
}

-(void)onLikeTapped:(UIButton *)button
{
    [self animateHeartUsingSection:button.tag]; //the photo was liked, call animation
    NSLog(@"like button at section %li tapped", button.tag);
}

-(void)animateHeartUsingSection:(NSInteger)section // animation for heart icon by Evan Vandenberg
{
    NSIndexPath *indexPath2 = [NSIndexPath indexPathForRow:0 inSection:section];
    CustomTableViewCell *cell = (CustomTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath2];
    cell.heartImage.image = [UIImage imageNamed:@"hearts-50"];
    [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        cell.heartImage.transform = CGAffineTransformMakeScale(1.3, 1.3);
        cell.heartImage.alpha = 1.0;
    }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.1f delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                             cell.heartImage.transform = CGAffineTransformMakeScale(1.0, 1.0);
                         }
                                          completion:^(BOOL finished) {
                                              [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                                                  cell.heartImage.transform = CGAffineTransformMakeScale(1.3, 1.3);
                                                  cell.heartImage.alpha = 0.0;
                                              }
                                                               completion:^(BOOL finished) {
                                                                   cell.heartImage.transform = CGAffineTransformMakeScale(1.0, 1.0);
                                                               }];
                                          }];
                     }];

}

#pragma mark - Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UIButton *)sender
{
    //When segue do this...
}

@end
