//
//  ViewController.m
//  CoreDataCars
//
//  Created by Asdruval De Leon on 11/29/17.
//  Copyright © 2017 Asdruval De Leon. All rights reserved.
//

#import "ViewController.h"
#import "Vehicule+CoreDataClass.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtMake;

@property (weak, nonatomic) IBOutlet UITextField *txtModel;
@property (weak, nonatomic) IBOutlet UITextField *txtMPG;
@property (weak, nonatomic) IBOutlet UITextField *txtYear;

@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // get hold of teh AppDelegate
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    context = appDelegate.persistentContainer.viewContext;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dismissKeyboard:(id)sender {
    
}

- (IBAction)btnSaveRecord:(UIButton *)sender {
    
    Vehicule *myCar = [[Vehicule alloc]initWithContext:context];
    
    [myCar setValue:_txtMake.text forKey:@"make"];
    [myCar setValue:_txtModel.text forKey:@"model"];
    
    //format string into a decimal before comming to context
    NSNumberFormatter * f = [[NSNumberFormatter alloc]init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * myMPG = [f numberFromString:_txtMPG.text];
    [myCar setValue:myMPG forKey:@"mpg"];
    
    //format string into appropriate data type before comming to context
    [f setNumberStyle:NSNumberFormatterNoStyle];
    NSNumber *myYear = [f numberFromString:_txtYear.text];
    [myCar setValue:myYear forKey:@"year"];
    
    //zero out the ui fields
    _txtMake.text = @"";
    _txtModel.text = @"";
    _txtMPG.text = @"";
    _txtYear.text = @"";
    
    NSError *error;
    [context save:&error];
    _lblStatus.text = @"Car Saved";
}

- (IBAction)btnFindRecord:(UIButton *)sender {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Vehicle"];
    NSError *error = nil;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    
    Vehicule *myCar;
    
    if ([objects count]==0){
        NSLog(@"Error fetching Vehicle objects: %@\n%@", [error localizedDescription], [error userInfo]);
        _lblStatus.text = @"No Matches";
    }
    else
    {
        myCar = objects[0];
        _txtMake.text = [myCar valueForKey:@"make"];
        _txtModel.text = [myCar valueForKey:@"model"];
        _txtMPG.text = [[myCar valueForKey:@"mpg"]stringValue];
        _txtYear.text = [[myCar valueForKey:@"year"]stringValue];
        
        _lblStatus.text = [NSString stringWithFormat:@"%lu Match(es) found.",(unsigned long)[objects count]];
        
    }
}

@end
