//
//  LZEditPriorityTableViewController.h
//  LZTasks
//
//  Created by comst on 15/12/16.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@interface LZEditPriorityTableViewController : UITableViewController
@property (nonatomic, strong) Task *currentTask;
@property (nonatomic, strong) NSManagedObjectContext *context;

@end
