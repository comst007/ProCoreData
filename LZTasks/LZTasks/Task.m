//
//  Task.m
//  LZTasks
//
//  Created by comst on 15/12/16.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "Task.h"
#import "Location.h"


@implementation Task

@dynamic dueDate;
@dynamic isOverdue;
@dynamic priority;
@dynamic text;
@dynamic location;
@dynamic highPriTasks;
@dynamic soonerTasks;
- (NSNumber *)isOverdue{
    
    NSComparisonResult isTaskOverdue;
    
    NSDate *currentDate = [NSDate date];
    
    isTaskOverdue = [self.dueDate compare:currentDate];
    
    return @(isTaskOverdue == NSOrderedAscending);
}

- (void)awakeFromInsert{
    
    [super awakeFromInsert];
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:60 * 60 * 24 * 3];
    
    [self setPrimitiveValue:date forKey:@"dueDate"];
}
@end
