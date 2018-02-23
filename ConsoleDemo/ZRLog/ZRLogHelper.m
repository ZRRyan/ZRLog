
//
//  ZRLogHelper.m
//  RescueExam
//
//  Created by Ryan on 2017/12/5.
//  Copyright © 2017年 xiaohesong. All rights reserved.
//

#import "ZRLogHelper.h"
#import "ZRLogModel.h"
#import "ZRLogConsoleView.h"


@interface ZRLogHelper()


/**
 是否在进行拖拽
 */
@property (nonatomic, assign, getter=isDrawing) BOOL drawing;
@property (nonatomic, weak) UIButton *logBtn;
@end

@implementation ZRLogHelper

+ (ZRLogHelper *)shareInstance {
    
    static ZRLogHelper *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[self alloc]init];
        
        
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
    
    }
    return self;
}


#pragma mark - 配置log按钮
- (void)configLog {
    UIButton *logBtn = [[UIButton alloc] init];
    logBtn.backgroundColor = [UIColor blueColor];
    [[UIApplication sharedApplication].keyWindow addSubview:logBtn];
    CGSize size = [UIApplication sharedApplication].keyWindow.bounds.size;
    
    logBtn.frame = CGRectMake(size.width - 60, size.height - 60, 60, 60);
    logBtn.layer.cornerRadius = 30;
    logBtn.layer.masksToBounds = YES;
    [logBtn addTarget:self action:@selector(logBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [logBtn addTarget:self action:@selector(dragMoving: withEvent:) forControlEvents:UIControlEventTouchDragInside];
    [logBtn addTarget:self action:@selector(dragEnd: withEvent:) forControlEvents:UIControlEventTouchDragOutside | UIControlEventTouchUpInside];
    self.logBtn = logBtn;
}


- (void)logBtnClick {
    if (self.isDrawing == YES) {
        return;
    }
    [self showLogList];
}

- (void)dragMoving: (UIButton *)btn withEvent: (UIEvent *)event {
    self.drawing = YES;
    btn.center = [[[event allTouches] anyObject] locationInView:[UIApplication sharedApplication].keyWindow];
}

- (void)dragEnd: (UIButton *)btn withEvent: (UIEvent *)event {
    self.drawing = NO;
    btn.center = [[[event allTouches] anyObject] locationInView:[UIApplication sharedApplication].keyWindow];
}

#pragma mark - 打印日志

/**
 打印log
 
 @param content 内容
 */
- (void)printWithContent: (NSString *)content {
    [self printWithTitle:@"" content:content];
}

/**
 打印log

 @param title 标题
 @param content 内容
 */
- (void)printWithTitle: (NSString *)title content: (NSString *)content {
    
    if (title == nil || [title isEqualToString:@""]) {
        title = content;
    }
    
    ZRLogModel *logModel = [[ZRLogModel alloc] init];
    logModel.title = title;
    logModel.content = content;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    logModel.time = [dateFormatter stringFromDate:[NSDate date]];
    
    NSMutableArray *arrM = [NSMutableArray arrayWithArray:self.arrLog];
    [arrM addObject:logModel];
    self.arrLog = arrM;
    
    if (self.isCache) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.arrLog];
        [[NSUserDefaults standardUserDefaults] setValue:data forKey:ZRLOGCACHE];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

#pragma mark - 删除日志
- (void)deleteWithLog: (ZRLogModel *)log {
    NSMutableArray *arrM = [NSMutableArray arrayWithArray: self.arrLog];
    for (ZRLogModel *logModel in arrM) {
        if ([logModel.time isEqualToString:log.time]) {
            [arrM removeObject:logModel];
            break;
        }
    }
    self.arrLog = arrM;
    if (self.isCache) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.arrLog];
        [[NSUserDefaults standardUserDefaults] setValue:data forKey:ZRLOGCACHE];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}


/**
 删除所有日志
 */
- (void)deleteAllLog {
    self.arrLog = @[];
    if (self.isCache) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.arrLog];
        [[NSUserDefaults standardUserDefaults] setValue:data forKey:ZRLOGCACHE];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

#pragma mark - log显示
- (void)showLogList {
    [ZRLogConsoleView show];
}



#pragma mark - 懒加载
- (NSArray *)arrLog {
    if (_arrLog == nil) {
        _arrLog = [NSArray array];
        if (self.isCache) {
            if ([[NSUserDefaults standardUserDefaults] valueForKey:ZRLOGCACHE] != nil) {
                NSData *data = [[NSUserDefaults standardUserDefaults] valueForKey:ZRLOGCACHE];
                _arrLog = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            }
        }
    }
    return _arrLog;
}

@end
