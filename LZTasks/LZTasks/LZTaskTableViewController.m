//
//  LZTaskTableViewController.m
//  LZTasks
//
//  Created by comst on 15/12/16.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZTaskTableViewController.h"
#import "LZEditTextTableViewController.h"
#import "LZEditPriorityTableViewController.h"
#import "LZEditLocationTableViewController.h"

@interface LZTaskTableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@property (weak, nonatomic) IBOutlet UILabel *priorityLabel;

@property (weak, nonatomic) IBOutlet UILabel *dueDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@end

@implementation LZTaskTableViewController


- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self configView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"detail task";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)configView{
    
    if (self.currentTask) {
        [self.context refreshObject:self.currentTask mergeChanges:YES];
    }
    self.textLabel.text = self.currentTask.text;
    self.priorityLabel.text = [self priorityFromNumber:self.currentTask.priority];
    
    self.dueDateLabel.text = [self stringFromDate:self.currentTask.dueDate];
    
    if ([self.currentTask.isOverdue boolValue] == YES) {
        self.dueDateLabel.textColor = [UIColor redColor];
    }else{
        self.dueDateLabel.textColor = [UIColor blackColor];
    }
    if (self.currentTask.location == nil) {
        
        self.locationLabel.text = @"Not Set";
        
    }else{
        
        self.locationLabel.text = self.currentTask.location.name;
        
    }
    
}


# pragma mark - utility 

- (NSString *)priorityFromNumber:(NSNumber *)priNumber{
    
    switch ([priNumber integerValue]) {
        case 0:
            
            return @"None";
            break;
        case 1:
            return @"Low";
            break;
        case 2:
            return @"Medium";
            break;
        case 3:
            return @"High";
            break;
        default:
            break;
    }
    
    return @"error Priority";
}

- (NSString *)stringFromDate:(NSDate *)date{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterLongStyle;
    
    return [formatter stringFromDate:date];
}


#pragma mark - setter 

- (void)setCurrentTask:(Task *)currentTask{
    
    _currentTask = currentTask;
    [self configView];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"editTaskText"]) {
                
        LZEditTextTableViewController *editVC = segue.destinationViewController;
        
        editVC.currentModel = (NSManagedObjectModel *)self.currentTask;
        editVC.keyString = @"text";
        editVC.context = self.context;
    }
    if ([segue.identifier isEqualToString:@"editPriority"]) {
        LZEditPriorityTableViewController *priorityVC = (LZEditPriorityTableViewController *)segue.destinationViewController;
        priorityVC.context = self.context;
        priorityVC.currentTask = self.currentTask;
    }
    
    if ([segue.identifier isEqualToString:@"editLocation"]) {
        LZEditLocationTableViewController *editLocationVC = segue.destinationViewController;
        
        editLocationVC.context = self.context;
        editLocationVC.currentTask = self.currentTask;
    }
}
#pragma mark - Table view data source



/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
