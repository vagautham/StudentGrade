//
//  HomeViewController.h
//  StudentGrade
//
//  Created by VA Gautham  on 9/4/14.
//  Copyright (c) 2014 Gautham. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *tbl_homeTable;
    
    NSString *currentURL;
    NSMutableData *receivedData;
}

@property(nonatomic, retain) UITableView *tbl_homeTable;

@property(nonatomic, retain) NSString *currentURL;
@property(nonatomic, retain) NSMutableData *receivedData;

@end
