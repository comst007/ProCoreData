//
//  Task.h
//  LZTasks
//
//  Created by comst on 15/12/16.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Location;

@interface Task : NSManagedObject

@property (nonatomic, retain) NSDate * dueDate;
@property (nonatomic, retain) NSNumber * isOverdue;
@property (nonatomic, retain) NSNumber * priority;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) Location *location;
@property (nonatomic, strong) NSArray *highPriTasks;
@property (nonatomic, strong) NSArray *soonerTasks;
@end
