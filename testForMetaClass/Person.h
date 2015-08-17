//
//  Person.h
//  
//
//  Created by cc on 15/8/17.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol PersonDelete <NSObject>

- (void)protocolMethod1;
- (void)protocolMethod2;

@end

@interface Person : NSObject <UITabBarDelegate>


@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign)NSUInteger age;
@property (nonatomic,copy)NSString *address;


- (void)personRun;
- (void)eat;
- (void)goToSchool:(NSString*) vehicle;

+ (void)method1;

@end
