//
//  CustomTableViewCell.h
//  InstagramFeed
//
//  Created by Gabriel Borri de Azevedo on 2/3/15.
//  Copyright (c) 2015 Gabriel Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
//Custom table view cell to hold custom labels and buttons
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *usernameButton;
@property (weak, nonatomic) IBOutlet UIImageView *heartImage;

@end
