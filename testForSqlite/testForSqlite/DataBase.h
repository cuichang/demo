//
//  DataBase.h
//  testForSqlite
//
//  Created by cuichang on 15/8/18.
//  Copyright (c) 2015年 cuichang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DataBase : NSObject
{
    sqlite3 *db;
}

+ (instancetype)shareBase;

- (BOOL)createTableWithSql:(NSString*)sql;

- (NSArray *)queryWithSql:(NSString *)sql andObject:(NSString *)obj;
- (BOOL)insertTableWithSql:(NSString*)sql;

- (NSArray*)queryMessageWithSQL:(NSString *)sql andObject:(NSString*)obj;

@end
