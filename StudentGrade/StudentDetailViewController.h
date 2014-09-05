//
//  StudentDetailViewController.h
//  StudentGrade
//
//  Created by VA Gautham  on 9/4/14.
//  Copyright (c) 2014 Gautham. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StudentDetailViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *tbl_Studentdetail;
}

@property(nonatomic, retain) UITableView *tbl_Studentdetail;

@end
