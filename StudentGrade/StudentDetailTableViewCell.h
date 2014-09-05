//
//  StudentDetailTableViewCell.h
//  StudentGrade
//
//  Created by VA Gautham  on 9/4/14.
//  Copyright (c) 2014 Gautham. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentDetailTableViewCell : UITableViewCell
{
    IBOutlet UIImageView *img_profile;
    IBOutlet UILabel *lbl_name;
    IBOutlet UILabel *lbl_Grade;
    NSString *imageURLString;
    IBOutlet UIActivityIndicatorView *loadingView;
}

@property(nonatomic, retain) UIImageView *img_profile;
@property(nonatomic, retain) UILabel *lbl_name;
@property(nonatomic, retain) UILabel *lbl_Grade;
@property(nonatomic, retain) NSString *imageURLString;
@property(nonatomic, retain) UIActivityIndicatorView *loadingView;

@end
