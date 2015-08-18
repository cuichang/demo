//
//  ViewController.m
//  testForSqlite
//
//  Created by cuichang on 15/8/18.
//  Copyright (c) 2015年 cuichang. All rights reserved.
//

#import "ViewController.h"
#import "DataBase.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    DataBase *manager = [DataBase shareBase];
    /*
    BOOL s = [manager createTableWithSql:@"create table if not exists user (id integer primary key autoincrement,name text not null unique,phone text,createDate text);"];
    if (s) {
        NSLog(@"create table success");
    }
     */
    /*
    BOOL i = [manager insertTableWithSql:@"insert into user(name,phone,createDate) values('123','123','123');"];
    
    if (i) {
        NSLog(@"insert table success");
    }
     */
    
    NSArray *userArray = [manager queryMessageWithSQL:@"select * from user where name like ? " andObject:@"123"];
    NSLog(@"%@",userArray);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
