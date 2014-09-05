//
//  StudentDetailViewController.m
//  StudentGrade
//
//  Created by VA Gautham  on 9/4/14.
//  Copyright (c) 2014 Gautham. All rights reserved.
//

#import "StudentDetailViewController.h"
#import "AppDelegate.h"
#import "StudentDetailTableViewCell.h"
#import "StudentModal.h"

@interface StudentDetailViewController ()

@end

@implementation StudentDetailViewController
@synthesize tbl_Studentdetail;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.png"]];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (AppDelegate *)getAppDelegateInstance
{
    return ((AppDelegate *) [UIApplication sharedApplication].delegate);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self getAppDelegateInstance].studentDetailArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"StudentDetailTVC";
    StudentDetailTableViewCell *cell = (StudentDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSString *nibName;
        NSString *deviceType = [[self getAppDelegateInstance] getDeviceType];
        if ([deviceType isEqualToString:@"iPad"] || [deviceType isEqualToString:@"iPad Simulator"])
            nibName = @"StudentDetailTableViewCell-iPad";
        else
            nibName = @"StudentDetailTableViewCell";

        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
        cell = (StudentDetailTableViewCell *)[topLevelObjects objectAtIndex:0];
    }
    
    StudentModal *currentStudent = [[self getAppDelegateInstance].studentDetailArray objectAtIndex:indexPath.row];
    cell.lbl_Grade.text = [NSString stringWithFormat:@"%@",currentStudent.student_grade];
    cell.lbl_name.text = currentStudent.student_name;
    if (currentStudent.student_image)
    {
        [cell.img_profile setImage:currentStudent.student_image];
        [cell.loadingView stopAnimating];
    }
    else
    {
        [cell.loadingView startAnimating];
        NSString *identifier = [NSString stringWithFormat:@"Cell%d" ,
                                indexPath.row];
        NSUInteger objectIndex = indexPath.row;
        char const * s = [identifier  UTF8String];
        dispatch_queue_t queue = dispatch_queue_create(s, 0);
        dispatch_async(queue, ^{
            NSString *url = currentStudent.student_imageURL;
            UIImage *img = nil;
            NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
            img = [[UIImage alloc] initWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([tableView indexPathForCell:cell].row == indexPath.row) {
                    StudentModal *toReplace = [[self getAppDelegateInstance].studentDetailArray objectAtIndex:objectIndex];
                    toReplace.student_image = [img copy];
                    [[self getAppDelegateInstance].studentDetailArray replaceObjectAtIndex:objectIndex withObject:toReplace];
                    [cell.loadingView stopAnimating];
                    [cell.img_profile setImage:img];
                }
            });
        });
    }
    
    return cell;
}

                                    
-(void)dealloc
{
    [super dealloc];
    if (tbl_Studentdetail)
    {
        [tbl_Studentdetail release];
        tbl_Studentdetail = nil;
    }
}
@end
