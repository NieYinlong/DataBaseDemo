//
//  ViewController.m
//  DataBaseDemo
//
//  Created by 聂银龙 on 2017/7/28.
//  Copyright © 2017年 nieyinlong. All rights reserved.
//

#import "ViewController.h"
#import "DataBaseHandle.h"
#import <sqlite3.h>
@interface ViewController ()
@property(nonatomic, strong) DataBaseHandle *dbHandle;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    _dbHandle = [DataBaseHandle shareInstance];
    
}



- (IBAction)actionCreateTable:(UIButton *)sender {
    // 创建学生表
    NSString *sql1 = @"CREATE TABLE  IF NOT EXISTS students (stuID text paimary key not NULL, name TEXT, age INTEGER, weight INTEGER);";
    [_dbHandle creatTableWithSql:sql1];
}

- (IBAction)actionInsert:(UIButton *)sender {
    
    // 向表中循环插入数据
    for (int i = 0; i < 5; i++) {
        
        NSString *sql2 = [NSString stringWithFormat:@"INSERT INTO students (stuID, name, age, weight) values ('%d', '张飞%d号', '%d', '%d')",  i,  i, 20 + i, 60 + i];
        
        [_dbHandle insertDataSql:sql2];
    }
}

- (IBAction)actionDelete:(UIButton *)sender {
    
    // 删除
    NSString *sql3 = @"delete from students where name = '张飞2号' ";
    [_dbHandle deleteDataSql:sql3];
    
    
}

- (IBAction)actionUpdate:(UIButton *)sender {
    
    NSString *sql = @"update  students set age = 1000 , name = '诸葛亮' where name = '张飞1号' ";
    [_dbHandle updateDataSql:sql];
}

- (IBAction)actionQuery:(UIButton *)sender {
    
    NSString *sql = @"select * from students";
    id v = [_dbHandle selectDataSql:sql];
    NSLog(@"查询结果😆 = %@", v);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
