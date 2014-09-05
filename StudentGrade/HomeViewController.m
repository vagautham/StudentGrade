//
//  HomeViewController.m
//  StudentGrade
//
//  Created by VA Gautham  on 9/4/14.
//  Copyright (c) 2014 Gautham. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"
#import "AppDelegate.h"
#import "StudentModal.h"
#import "StudentDetailViewController.h"

@interface HomeViewController ()
{
    NSIndexPath *firstCellIndexPath;
}

@end

@implementation HomeViewController
@synthesize tbl_homeTable;
@synthesize currentURL, receivedData;

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
    [self.navigationItem setHidesBackButton:TRUE];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    
    [tbl_homeTable registerNib:[UINib nibWithNibName:@"HomeTableViewCell" bundle:nil ] forCellReuseIdentifier:@"HomeTVC"];

//    if (!firstCellIndexPath)
//        firstCellIndexPath = [[NSIndexPath alloc] init];
    
    //[self downloadDataFile];
}

-(void)downloadDataFile
{
    currentURL = @"https://dl.dropbox.com/s/siajtkyzworpuh3/challenge_grades.json?token_hash=AAHh9lQ4QInS-D18W0474instLN3rnEDehBd0MvShlwU4g&dl=1";
    
    NSURL *url = [NSURL URLWithString:currentURL];
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    
    receivedData = [[NSMutableData alloc] initWithLength:0];
    NSURLConnection * connection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self startImmediately:YES];
    [connection start];
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [receivedData setLength:0];
}

- (void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"StudentData.json"];
    NSLog(@"Succeeded! Received %d bytes of data",[receivedData length]);
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    if (firstCellIndexPath)
    {
        HomeTableViewCell *cell = (HomeTableViewCell *)[tbl_homeTable cellForRowAtIndexPath:firstCellIndexPath];
        [cell.loadingView stopAnimating];
        firstCellIndexPath = nil;
    }
    [receivedData writeToFile:dataPath atomically:YES];
    [self parseDownloadedData];
    [tbl_homeTable reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* foofile = [documentsPath stringByAppendingPathComponent:@"StudentData.json"];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:foofile];

    if (fileExists)
        return 2;

    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
    UILabel *label = [[UILabel alloc] initWithFrame:view.frame];
    [label setFont:[UIFont systemFontOfSize:15]];
    [label setTextColor:[UIColor lightGrayColor]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:@"Student Grades"];
    [view addSubview:label];
    [view setBackgroundColor:[UIColor blueColor]];
    
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"HomeTVC";
    HomeTableViewCell *cell = (HomeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"HomeTableViewCell" owner:self options:nil];
        cell = (HomeTableViewCell *)[topLevelObjects objectAtIndex:0];
    }
    
    if (indexPath.row == 0)
    {
        cell.backgroundColor = [UIColor redColor];
        [cell.cellLabel setText:@"Load Grades"];
        [cell.loadingView stopAnimating];
    }
    else if (indexPath.row == 1)
    {
        cell.backgroundColor = [UIColor greenColor];
        [cell.cellLabel setText:@"Show Grades"];
        [cell.loadingView stopAnimating];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        firstCellIndexPath = [indexPath copy];
        HomeTableViewCell *cell = (HomeTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        [cell.loadingView startAnimating];
        [self downloadDataFile];
    }
    else if (indexPath.row == 1)
    {
        if ([[self getAppDelegateInstance].studentDetailArray count] <= 0)
            [self parseDownloadedData];
       
        NSString *nibName;
        NSString *deviceType = [[self getAppDelegateInstance] getDeviceType];
        if ([deviceType isEqualToString:@"iPad"] || [deviceType isEqualToString:@"iPad Simulator"])
            nibName = @"StudentDetailViewController-iPad";
        else
            nibName = @"StudentDetailViewController";
        
        StudentDetailViewController *mStudentDetailViewController = [[StudentDetailViewController alloc] initWithNibName:nibName bundle:nil];
        [self.navigationController pushViewController:mStudentDetailViewController animated:TRUE];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:FALSE];
}

-(void)parseDownloadedData
{
    NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* foofile = [documentsPath stringByAppendingPathComponent:@"StudentData.json"];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:foofile];
    if (fileExists)
    {
        NSString *content = [[NSString alloc] initWithContentsOfFile:foofile usedEncoding:nil error:nil];
        NSData* data = [content dataUsingEncoding:NSUTF8StringEncoding];

        NSDictionary *gradeDict = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: nil];
        NSMutableArray *tempArray = [[NSMutableArray alloc]  initWithArray:[gradeDict valueForKey:@"grades"]];
        [[self getAppDelegateInstance].studentDetailArray removeAllObjects];
        for (NSDictionary *stuDict in tempArray)
        {
            StudentModal *newStudent = [[StudentModal alloc] init];
            newStudent.student_name = [stuDict valueForKey:@"student"];
            newStudent.student_grade = [stuDict valueForKey:@"grade"];
            newStudent.student_imageURL = [stuDict valueForKey:@"thumbnail"];
            [[self getAppDelegateInstance].studentDetailArray addObject:newStudent];
        }
    }
}

- (AppDelegate *)getAppDelegateInstance
{
    return ((AppDelegate *) [UIApplication sharedApplication].delegate);
}

-(void)dealloc
{
    [super dealloc];
    if (tbl_homeTable)
    {
        [tbl_homeTable release];
        tbl_homeTable = nil;
    }
    if (receivedData)
    {
        [receivedData release];
        receivedData = nil;
    }
    if (currentURL)
    {
        [currentURL release];
        currentURL = nil;
    }
}

@end
