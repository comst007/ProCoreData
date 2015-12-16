//
//  LZEditDateViewController.m
//  LZTasks
//
//  Created by comst on 15/12/16.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZEditDateViewController.h"

@interface LZEditDateViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tv;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;


@end

@implementation LZEditDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.datePicker.date = self.currentTask.dueDate;
    [self.view sendSubviewToBack:self.tv];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveDate)];
    
    self.navigationItem.rightBarButtonItem = item;
}

- (void)saveDate{
    
    self.currentTask.dueDate = self.datePicker.date;
    
    [self.context save:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)selectDate:(UIDatePicker *)sender {
    
    [self.tv reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dateCell"];
    
    [self configCell:cell];
    return cell;
}

- (void)configCell:(UITableViewCell *)cell{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateStyle = NSDateFormatterLongStyle;
    
    cell.textLabel.text =  [formatter stringFromDate:self.datePicker.date];
    
}
@end
