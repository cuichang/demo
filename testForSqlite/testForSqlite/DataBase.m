//
//  DataBase.m
//  testForSqlite
//
//  Created by cuichang on 15/8/18.
//  Copyright (c) 2015年 cuichang. All rights reserved.
//

#import "DataBase.h"

static DataBase *database = nil;

@implementation DataBase

+ (instancetype)shareBase{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        database = [[DataBase alloc] init];
    });
    return database;
}

- (int)openDB{
    NSString *dbpath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"123.sqlite"];
    
    NSLog(@"%@",dbpath);
    int result = sqlite3_open([dbpath UTF8String], &db);
    if (result == SQLITE_OK) {
        NSLog(@"open success");
    }
    return result;
}

- (int)closeDB{
    return sqlite3_close(db);
}

- (BOOL)insertTableWithSql:(NSString*)sql{
    if ([self openDB] == SQLITE_OK ) {
        char *error;
        int result = sqlite3_exec(db, [sql UTF8String], NULL, NULL, &error);
        [self closeDB];
        if (result == SQLITE_OK) {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    return NO;
}

- (BOOL)createTableWithSql:(NSString *)sql{
    if ([self openDB] == SQLITE_OK) {
        char *error;
        int result = sqlite3_exec(db, [sql UTF8String], NULL, NULL, &error);
        [self closeDB];
        
        if (result == SQLITE_OK) {
            NSLog(@"create table success");
        }
        else
        {
            NSLog(@"create table error %s",error);
        }
        return YES;
    }
    return NO;
}

- (NSArray*)queryMessageWithSQL:(NSString *)sql andObject:(NSString*)obj{
    if ([self openDB] == SQLITE_OK) {
        sqlite3_stmt *stmt ;
        if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, nil) == SQLITE_OK) {
            
            NSString *searchContent = [NSString stringWithFormat:@"%%%@%%",obj];
            if (sqlite3_bind_text(stmt, 1, [searchContent UTF8String], -1, NULL) == SQLITE_OK) {
                NSMutableArray *resultlist = [NSMutableArray array];
                
                while (sqlite3_step(stmt) == SQLITE_ROW) {
                    char *name = (char *)sqlite3_column_text(stmt, 1);
                    char *phone = (char *)sqlite3_column_text(stmt, 2);
                    char *time = (char *)sqlite3_column_text(stmt, 3);
                    NSDictionary *info = @{@"name":[NSString stringWithUTF8String:name],@"phone":[NSString stringWithUTF8String:phone],@"time":[NSString stringWithUTF8String:time]};
                    [resultlist addObject:info];
                }
                [self closeDB];
                return resultlist;
            }
        }
    }
    return nil;
}


@end
