//
//  DetailViewController.m
//  LZTaskManger
//
//  Created by comst on 15/12/12.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"
@interface DetailViewController ()<UITextFieldDelegate>

@property (nonatomic, copy) NSString *sourceText;
@property (weak, nonatomic) IBOutlet UITextField *textfield;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [[self.detailItem valueForKey:@"timeStamp"] description];
        self.textfield.text = [self.detailItem valueForKey:@"taskText"];
        self.sourceText = self.textfield.text;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [self updateItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

- (void)updateItem{
    if ([self.textfield.text isEqualToString:self.sourceText]) {
        return;
    }
    [self.detailItem setValue:self.textfield.text forKey:@"taskText"];
    
    AppDelegate *addD = [UIApplication sharedApplication].delegate;
    
    NSManagedObjectContext *context  = addD.managedObjectContext;
    
    [context save:nil];
    
}
@end
