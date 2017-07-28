//
//  DataBaseHandle.m
//  DataBaseDemo
//
//  Created by 聂银龙 on 2017/7/28.
//  Copyright © 2017年 nieyinlong. All rights reserved.
//

#import "DataBaseHandle.h"

static DataBaseHandle *_instance;

@implementation DataBaseHandle



+ (instancetype)shareInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[DataBaseHandle alloc] init];
    
    });
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super  allocWithZone:zone];
    });
    return _instance;
}


- (id)copyWithZone:(NSZone *)zone
{
    return _instance;
}




#pragma mark ---关闭数据库(链接)
-(void)closeDB{
    
    int ret = sqlite3_close(_db);
    if (ret == SQLITE_OK) {
        printf("关闭成功");
        _db = NULL;
    } else {
        printf("关闭失败");
    }
    
}





// sqlite3 * 表示咱们的数据库
- (sqlite3 *)openDB
{

    if (_db != nil) {
        return _db;
    }
    
    NSString *docuPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    
    // 数据库路径
    NSString *db_suffix = [NSString stringWithFormat:@"%@.db", @"YLDataBase"];
    
    NSString *dbPath = [docuPath stringByAppendingPathComponent:db_suffix];
    
    int result = sqlite3_open(dbPath.UTF8String, &_db);
    if (result == SQLITE_OK) {
        NSLog(@"创建(链接)数据库成功! %d = %@",result, dbPath);
    } else {
        NSLog(@"创建(链接)数据库失败! %d",result);
    }
    return _db;
}


#pragma mark ---创建数据库中的表(table)
-(void)creatTableWithSql:(NSString *)sql {
 
    [self openDB];
    
    char *errmsg = NULL;
    int ret = sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &errmsg);
    
    if (ret == SQLITE_OK) {
        NSLog(@"创建表成功");
        
    }else {
        
        printf("创建表失败: %s", errmsg);
    }
    
}


#pragma mark - 向指定表中插入数据
- (void)insertDataSql:(NSString *)sql {
    [self openDB];
    char *errmsg = NULL;
    
    int result = sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &errmsg);
    
    if (result == SQLITE_OK) {
        
        NSLog(@"插入成功");
        
    } else {
        
        NSLog(@"插入失败");
        
    }
    
}



#pragma mark -  删除某表中的一条数据
- (void)deleteDataSql:(NSString *)sql {
    [self openDB];
    char *errmsg = NULL;
    
    int result = sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &errmsg);
    
    if (result == SQLITE_OK) {
        
        NSLog(@"删除成功");
        
    } else {
        
        NSLog(@"删除失败");
    }
}


#pragma mark -更新数据 
- (void)updateDataSql:(NSString *)sql {
    
    
    [self openDB];
    char *errmsg = NULL;
    
    int result = sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &errmsg);
    
    if (result == SQLITE_OK) {
        
        NSLog(@"更新成功");
        
    } else {

        
        NSLog(@"更新失败 ");
    }
}

#pragma mark -  查询
- (id)selectDataSql:(NSString *)sql {

    NSMutableArray *arr = [NSMutableArray array];
    
    [self openDB];
    // 查询的跟随指针
    sqlite3_stmt *stmt;
    
    int ret = sqlite3_prepare(_db, sql.UTF8String, -1, &stmt, NULL);
    if (ret == SQLITE_OK) {
        NSLog(@"查询成功");
        
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            
        
            // 一条数据中 第0个字段
            NSString *v0 = [NSString stringWithUTF8String:( char *)sqlite3_column_text(stmt, 0)];
            //  第1个字段
            NSString *v1 = [NSString stringWithUTF8String:( char *)sqlite3_column_text(stmt, 1)];
            
            //  第2个字段
            NSString *v2 = [NSString stringWithUTF8String:( char *)sqlite3_column_text(stmt, 2)];
            //  第3个字段
            NSString *v3 = [NSString stringWithUTF8String:( char *)sqlite3_column_text(stmt, 3)];
            
      
            // 打印所有数据
            NSLog(@"=== %@  %@  %@  %@", v0, v1, v2, v3);
            
            NSDictionary *dic = @{@"stuID" : v0,
                                  @"name"  : v1,
                                  @"age"   : v2,
                                  @"weight": v3};
            
            [arr addObject:dic];
            
            
        }
        
    } else {
        NSLog(@"查询失败");
    }
    return arr;
}


@end
