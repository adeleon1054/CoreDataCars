//
//  ViewController.h
//  CoreDataCars
//
//  Created by Asdruval De Leon on 11/29/17.
//  Copyright © 2017 Asdruval De Leon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ViewController : UIViewController
{
    AppDelegate* appDelegate;
    NSManagedObjectContext* context;
}

@end

