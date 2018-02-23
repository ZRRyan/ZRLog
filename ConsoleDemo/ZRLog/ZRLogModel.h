//
//  ZRLogModel.h
//  RescueExam
//
//  Created by Ryan on 2017/12/5.
//  Copyright © 2017年 xiaohesong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZRLogModel : NSObject

/**
 日志标题
 */
@property (nonatomic, copy) NSString *title;

/**
 日志内容
 */
@property (nonatomic, copy) NSString *content;

/**
 日志时间
 */
@property (nonatomic, copy) NSString *time;
@end
