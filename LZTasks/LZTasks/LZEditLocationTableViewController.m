//
//  LZEditLocationTableViewController.m
//  LZTasks
//
//  Created by comst on 15/12/16.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZEditLocationTableViewController.h"
#import "LZEditTextTableViewController.h"

@interface LZEditLocationTableViewController ()<NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchController;

@end

@implementation LZEditLocationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewLocation)];
    
    self.navigationItem.rightBarButtonItem = item;
    
    NSError *error = nil;
    
    if (![self.fetchController performFetch:&error] ){
        NSLog(@"fetch location fail: %@", [error userInfo]);
    }
    
    
}

- (void)insertNewLocation{
    
    LZEditTextTableViewController *editTextVC = [self.storyboard instantiateViewControllerWithIdentifier:@"editTextVC"];
    Location *newLOcation = [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:self.context];
    
    [self.context save:nil];
    
    editTextVC.currentModel = (NSManagedObjectModel *)newLOcation;
    editTextVC.keyString = @"name";
    editTextVC.context = self.context;
    
    [self.navigationController pushViewController:editTextVC animated:YES];
}

#pragma mark - lazyload 

- (NSFetchedResultsController *)fetchController{
    if (!_fetchController) {
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Location" inManagedObjectContext:self.context];
        
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[entity name]];
        
        NSSortDescriptor *sortDes = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
        
        fetchRequest.sortDescriptors = @[sortDes];
        
        _fetchController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.context sectionNameKeyPath:nil cacheName:nil];
        _fetchController.delegate = self;
        
        
    }
    return _fetchController;
}

#pragma mark - fetchcontroller delegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    
    [self.tableView reloadData];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    id<NSFetchedResultsSectionInfo> sectionInfo = [self.fetchController sections][section];
    
    return  [sectionInfo numberOfObjects];
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"locationCell" forIndexPath:indexPath];
    
    [self configCell:cell atIndexPath:indexPath];
    
    
    
    return cell;
}

- (void)configCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{
    
    Location *obj = [self.fetchController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = obj.name;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    Location *obj = [self.fetchController objectAtIndexPath:indexPath];
    self.currentTask.location = obj;
    
    NSError *error = nil;
    if (![self.context save:&error]) {
        NSLog(@"select location fail : %@", [error userInfo]);
        
        [self.context rollback];
        
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Location *obj  = [self.fetchController objectAtIndexPath:indexPath];
        
        [self.context deleteObject:obj];
        
        NSError *error = nil;
        if (![self.context save:&error]) {
            NSLog(@"delete fail : %@", [error userInfo]);
            
            [self.context rollback];
        }
    }
    
    
}

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
