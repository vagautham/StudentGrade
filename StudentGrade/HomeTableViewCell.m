
//
//  HomeTableViewCell.m
//  StudentGrade
//
//  Created by VA Gautham  on 9/4/14.
//  Copyright (c) 2014 Gautham. All rights reserved.
//

#import "HomeTableViewCell.h"

@implementation HomeTableViewCell
@synthesize cellLabel, loadingView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        if (!cellLabel)
            cellLabel = [[UILabel alloc] init];
        if (!loadingView)
            loadingView = [[UIActivityIndicatorView alloc] init];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
