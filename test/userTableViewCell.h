//
//  userTableViewCell.h
//  test
//
//  Created by Joe Slack on 1/13/14.
//  Copyright (c) 2014 Joe Slack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface userTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *detail;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@end
