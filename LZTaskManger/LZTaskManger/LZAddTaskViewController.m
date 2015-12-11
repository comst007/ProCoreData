//
//  LZAddTaskViewController.m
//  LZTaskManger
//
//  Created by comst on 15/12/12.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "LZAddTaskViewController.h"
#import "AppDelegate.h"
@interface LZAddTaskViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *taskTextField;

@end

@implementation LZAddTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self insertNewTask];
    [self  dismissViewControllerAnimated:YES completion:nil];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self insertNewTask];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)insertNewTask{
    
    if (self.taskTextField.text == nil || [self.taskTextField.text length] == 0 ) {
        return;
    }
    
    AppDelegate *appD = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appD.managedObjectContext;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Task" inManagedObjectContext:context];
    NSLog(@"entity Name: %@", [entity name]);
    
    NSManagedObjectModel *newModel = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    [newModel setValue:self.taskTextField.text forKey:@"taskText"];
    [newModel setValue:[NSDate date] forKey:@"timeStamp"];
    
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"insert fail: %@", [error userInfo]);
        abort();
    }
}
@end
