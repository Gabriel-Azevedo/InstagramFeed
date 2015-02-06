//
//  CommentTableViewCell.h
//  InstagramFeed
//
//  Created by Gabriel Borri de Azevedo on 2/4/15.
//  Copyright (c) 2015 Gabriel Enterprises. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTableViewCell : UITableViewCell
//Custom table view cell to hold custom labels and image
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@end
