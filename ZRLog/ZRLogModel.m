
//
//  ZRLogModel.m
//  RescueExam
//
//  Created by Ryan on 2017/12/5.
//  Copyright © 2017年 xiaohesong. All rights reserved.
//

#import "ZRLogModel.h"

@implementation ZRLogModel

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (instancetype)initWithCoder: (NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.content = [aDecoder decodeObjectForKey:@"content"];
        self.time = [aDecoder decodeObjectForKey:@"time"];
    }
    return self;
}

- (void)encodeWithCoder: (NSCoder *)coder
{
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.content forKey:@"content"];
    [coder encodeObject:self.time forKey:@"time"];
}

@end
