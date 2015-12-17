//
//  DatabaseControl.m
//  Demo02_LocalFileAndSetting
//
//  Created by 李海龙 on 15/11/27.
//  Copyright © 2015年 北京千锋互联科技有限公司（大连）. All rights reserved.
//

#import "DatabaseControl.h"
#import "FMDatabase.h"

@implementation DatabaseControl {
    FMDatabase *fmdb;
}

- (instancetype)init {
    self = [super init];
    if (self) {
       NSString * fileName = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"/BookData.db"];
        
        NSFileManager *fm = [NSFileManager defaultManager];
        BOOL isFolder;
        BOOL isExist = [fm fileExistsAtPath:fileName isDirectory:&isFolder];
        
        fmdb = [FMDatabase databaseWithPath:fileName];
        
        [fmdb open];
        
        if (!isExist || isFolder) {
            // 创建表
            NSString *sql = @"create table if not exists books(bid text, title text, lastCname text);";
            [fmdb executeUpdate:sql];
        }
    }

    return self;
}

- (void)dealloc {
    [fmdb close];
}

- (NSArray *)getBooks {
    NSMutableArray *resultCollection = [[NSMutableArray alloc] init];
    FMResultSet *resultSet = [fmdb executeQuery:@"Select * From books"];
    
    while ([resultSet next]) {
        SQLiteBookModel *info = [[SQLiteBookModel alloc] init];
        info.bid = [resultSet stringForColumn:@"bid"];
        info.title = [resultSet stringForColumn:@"title"];
        info.lastCname = [resultSet stringForColumn:@"lastCname"];
        [resultCollection addObject:info];
    }
    [resultSet close];
    

    return resultCollection;
}

- (void)insertStudent:(SQLiteBookModel *)info {
    
    NSString *sql = @"Insert into books values(?,?,?)";
    
    if ([fmdb executeUpdate:sql, info.bid, info.title, info.lastCname]) {
        NSLog(@"Insert OK");
    }
    
}

- (void)updateStudent:(SQLiteBookModel *)info {
    
    NSString *sql = @"update books set lastCname=? where bid=?;";
    
    if ([fmdb executeUpdate:sql, info.lastCname, info.bid]) {
        NSLog(@"updateStudent OK");
    }
    
}

- (void)deleteStudent:(SQLiteBookModel *)info {
    
    NSString *sql = @"delete from books where bid=?;";
    
    if ([fmdb executeUpdate:sql, info.bid]) {
        NSLog(@"删除数据 OK");
    }
    
}

@end
