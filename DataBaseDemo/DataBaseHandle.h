//
//  DataBaseHandle.h
//  DataBaseDemo
//
//  Created by 聂银龙 on 2017/7/28.
//  Copyright © 2017年 nieyinlong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface DataBaseHandle : NSObject
{
    sqlite3 *_db;
}


/**
 初始化

 @return 单例对象
 */
+ (instancetype)shareInstance;



/**
 创建表

 @param sql sql
 */
-(void)creatTableWithSql:(NSString *)sql;



/**
 向指定表中插入数据

 @param sql sql语句
 */
- (void)insertDataSql:(NSString *)sql;



/**
 关闭数据库
 */
-(void)closeDB;




#pragma mark -  删除某表中的一条数据
- (void)deleteDataSql:(NSString *)sql;


#pragma mark -更新数据
- (void)updateDataSql:(NSString *)sql;

#pragma mark -  查询
- (id)selectDataSql:(NSString *)sql ;

@end
