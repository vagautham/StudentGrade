//
//  StudentDetailTableViewCell.m
//  StudentGrade
//
//  Created by VA Gautham  on 9/4/14.
//  Copyright (c) 2014 Gautham. All rights reserved.
//

#import "StudentDetailTableViewCell.h"

@implementation StudentDetailTableViewCell
@synthesize imageURLString;
@synthesize img_profile;
@synthesize lbl_Grade, lbl_name;
@synthesize loadingView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
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

-(void)dealloc
{
    [super dealloc];
    if(imageURLString)
    {
        [imageURLString release];
        imageURLString = nil;
    }
    if(img_profile)
    {
        [img_profile release];
        img_profile = nil;
    }
    if(lbl_Grade)
    {
        [lbl_Grade release];
        lbl_Grade = nil;
    }
    if(lbl_name)
    {
        [lbl_name release];
        lbl_name = nil;
    }
    if (loadingView)
    {
        [loadingView release];
        loadingView = nil;
    }
}
@end
