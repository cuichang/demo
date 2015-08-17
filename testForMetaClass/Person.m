//
//  Person.m
//  
//
//  Created by cc on 15/8/17.
//
//

#import "Person.h"


@implementation Person


- (void)personRun
{
    NSLog(@"run method was called");
}

- (void)eat{
    NSLog(@"eat method was called");
}

- (void)goToSchool:(NSString *)vehicle{
    NSLog(@"Person go to school by %@",vehicle);
}

+ (void)method1{
    NSLog(@"类方法");
}

@end
