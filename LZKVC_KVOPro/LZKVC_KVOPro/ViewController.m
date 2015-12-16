//
//  ViewController.m
//  LZKVC_KVOPro
//
//  Created by comst on 15/12/16.
//  Copyright (c) 2015年 com.comst1314. All rights reserved.
//

#import "ViewController.h"
#define kColorEntityName @"ColorComponent"
#define kRedKeyPath @"red"
#define kGreenKeyPath @"green"
#define kBlueKeyPath @"blue"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *colorView;
@property (weak, nonatomic) IBOutlet UISlider *redSlider;
@property (weak, nonatomic) IBOutlet UISlider *greenSlider;

@property (weak, nonatomic) IBOutlet UISlider *blueSlider;

@property (nonatomic, strong) ColorComponent *currentColorComponent;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self loadData];
    [self configView];
    
    [self.currentColorComponent addObserver:self forKeyPath:kRedKeyPath options:NSKeyValueObservingOptionNew context:nil];
    [self.currentColorComponent addObserver:self forKeyPath:kGreenKeyPath options:NSKeyValueObservingOptionNew context:nil];
    [self.currentColorComponent addObserver:self forKeyPath:kBlueKeyPath options:NSKeyValueObservingOptionNew context:nil];
}

- (void)loadData{
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:kColorEntityName];
    
    NSArray *result =  [self.context executeFetchRequest:request error:nil];
    if ([result count] == 0) {
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:kColorEntityName inManagedObjectContext:self.context];
        
        ColorComponent *item = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:self.context];
        
        [self.context insertObject:item];
        
        [self.context save:nil];
        
        self.currentColorComponent = item;
    }else{
        
        self.currentColorComponent = (ColorComponent *)result[0];
        
    }
    
}



- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    if ([keyPath isEqualToString:kRedKeyPath]) {
        self.colorView.backgroundColor = [UIColor colorWithRed:self.redSlider.value green:self.greenSlider.value blue:self.blueSlider.value alpha:YES];
    }
    
    if ([keyPath isEqualToString:kGreenKeyPath]) {
        self.colorView.backgroundColor = [UIColor colorWithRed:self.redSlider.value green:self.greenSlider.value blue:self.blueSlider.value alpha:YES];
    }
    
    if ([keyPath isEqualToString:kBlueKeyPath]) {
        self.colorView.backgroundColor = [UIColor colorWithRed:self.redSlider.value green:self.greenSlider.value blue:self.blueSlider.value alpha:YES];
    }
    
}

- (void)configView{
    
    self.redSlider.value = [self.currentColorComponent.red floatValue];
    self.greenSlider.value = [self.currentColorComponent.green floatValue];
    self.blueSlider.value = [self.currentColorComponent.blue floatValue];
    
    self.colorView.backgroundColor = [UIColor colorWithRed:self.redSlider.value green:self.greenSlider.value blue:self.blueSlider.value alpha:YES];
    
}


- (IBAction)redValueChanged:(UISlider *)sender {
    
    //self.currentColorComponent.red = @(sender.value);
    
    [self.currentColorComponent setValue:@(sender.value) forKey:kRedKeyPath];
    [self.context save:nil];
}

- (IBAction)greenValueChanged:(UISlider *)sender {
    self.currentColorComponent.green = @(sender.value);
    
    [self.context save:nil];
}

- (IBAction)blueValueChanged:(UISlider *)sender {
    
    self.currentColorComponent.blue = @(sender.value);
    [self.context save:nil];
}

@end
