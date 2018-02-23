//
//  ZRLogHelper.h
//  RescueExam
//
//  Created by Ryan on 2017/12/5.
//  Copyright © 2017年 xiaohesong. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ZRLOGCACHE @"ZRLOGCACHE" // 缓存log的减
@class ZRLogModel;

@interface ZRLogHelper : NSObject

/**
 是否本地缓存
 */
@property (nonatomic, assign, getter=isCache) BOOL cache;

/**
 日志数组
 */
@property (nonatomic, copy) NSArray *arrLog;


+ (ZRLogHelper *)shareInstance;

- (void)configLog;

/**
 打印log
 
 @param content 内容
 */
- (void)printWithContent: (NSString *)content;
/**
 打印log
 
 @param title 标题
 @param content 内容
 */
- (void)printWithTitle: (NSString *)title content: (NSString *)content;

/**
 显示log
 */
- (void)showLogList;


- (void)deleteWithLog: (ZRLogModel *)log;

/**
 删除所有日志
 */
- (void)deleteAllLog;
@end
