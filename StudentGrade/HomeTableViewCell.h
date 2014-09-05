//
//  HomeTableViewCell.h
//  StudentGrade
//
//  Created by VA Gautham  on 9/4/14.
//  Copyright (c) 2014 Gautham. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableViewCell : UITableViewCell
{
    IBOutlet UILabel *cellLabel;
    IBOutlet UIActivityIndicatorView *loadingView;
}

@property(nonatomic, retain) UILabel *cellLabel;
@property(nonatomic, retain) UIActivityIndicatorView *loadingView;

@end
