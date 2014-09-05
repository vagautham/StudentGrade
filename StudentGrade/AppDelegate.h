//
//  AppDelegate.h
//  StudentGrade
//
//  Created by VA Gautham  on 9/4/14.
//  Copyright (c) 2014 Gautham. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSMutableArray *studentDetailArray;
}
@property (retain, nonatomic) UIWindow *window;
@property (retain, nonatomic) UINavigationController  *navigationController;
@property (retain, nonatomic) NSMutableArray *studentDetailArray;

-(NSString *)getDeviceType;

@end
