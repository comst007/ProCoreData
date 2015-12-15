//
//  LZEditTextTableViewController.h
//  LZTasks
//
//  Created by comst on 15/12/16.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface LZEditTextTableViewController : UITableViewController
@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) NSManagedObjectModel *currentModel;
@property (nonatomic, copy) NSString *keyString;
@end
