//
//  StudentModal.h
//  StudentGrade
//
//  Created by VA Gautham  on 9/4/14.
//  Copyright (c) 2014 Gautham. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StudentModal : NSObject
{
    NSString *student_name;
    NSNumber *student_grade;
    NSString *student_imageURL;
    UIImage *student_image;
}

@property(nonatomic, retain) NSString *student_name;
@property(nonatomic, retain) NSNumber *student_grade;
@property(nonatomic, retain) NSString *student_imageURL;
@property(nonatomic, retain) UIImage *student_image;

@end
