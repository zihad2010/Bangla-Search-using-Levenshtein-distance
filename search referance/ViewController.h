//
//  ViewController.h
//  search referance
//
//  Created by Zihad on 3/21/16.
//  Copyright (c) 2016 zihad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    
    IBOutlet UIButton *savebutton;
    IBOutlet UIButton *butto;
}
@property (strong, nonatomic) IBOutlet UITableView *myView;
@property (strong,nonatomic) NSMutableArray *sortDistance;
@property (strong,nonatomic) NSMutableArray *sortString;
@property (strong,nonatomic) NSMutableArray *result;
@property (strong,nonatomic) NSMutableArray *resultTable;
@property (strong, nonatomic) IBOutlet UITextField *dataTextField;
- (IBAction)saveData:(id)sender;


- (IBAction)search:(id)sender;

@end

