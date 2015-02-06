//
//  CommentsViewController.m
//  InstagramFeed
//
//  Created by Gabriel Borri de Azevedo on 2/3/15.
//  Copyright (c) 2015 Gabriel Enterprises. All rights reserved.
//

#import "CommentsViewController.h"
#import "CommentTableViewCell.h"

@interface CommentsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView; // View's tableView

@end

@implementation CommentsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 50.0; // Setting estimated Row Height to 50
    self.tableView.rowHeight = UITableViewAutomaticDimension; //Using resizable row height
    self.title = @"Comments"; //Setting nav title
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.tableView reloadData]; // reload data with new row heights
    self.tableView.hidden = FALSE; // showing table view
}

-(void)viewWillAppear:(BOOL)animated
{
    self.tableView.hidden = TRUE; // hiding table view while rearranging row heights
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    // Code above for demo purpose only
    if (indexPath.row == 0)
    {
        cell.usernameLabel.text = @"username1";
        cell.commentLabel.text = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque in bibendum erat.";
    }
    else if (indexPath.row == 1)
    {
        cell.usernameLabel.text = @"username2";
        cell.commentLabel.text = @"Aliquam semper est ante, quis lacinia velit rutrum lobortis. Curabitur congue neque sodales nunc semper, nec auctor velit scelerisque. Proin sodales a felis ac pretium. Mauris interdum facilisis elit id vehicula. Praesent in dapibus eros, in consectetur.";

    }
    else if (indexPath.row == 2)
    {
        cell.usernameLabel.text = @"username3";
        cell.commentLabel.text = @"In sed efficitur mi. Mauris fermentum condimentum mi sed tincidunt. Integer id arcu dolor. Mauris tincidunt ultricies ornare. Praesent non ornare lorem, sed consequat nisl. Morbi vestibulum leo nec metus laoreet, ac porta massa gravida.";
    }
        return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3; // Change value accordingly
}

@end
