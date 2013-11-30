//
//  OverViewController.m
//  matchGame
//
//  Created by singsong on 13-11-30.
//  Copyright (c) 2013年 singsong. All rights reserved.
//

#import "OverViewController.h"

@interface OverViewController ()

@end

@implementation OverViewController
@synthesize time,score;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
     NSInteger times = [userDefaultes integerForKey:@"times"];
    time.text=[NSString stringWithFormat:@"%d",times];
    NSInteger scores = [userDefaultes integerForKey:@"scores"];
    score.text=[NSString stringWithFormat:@"%d",scores];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)upload:(id)sender {
}

- (IBAction)rank:(id)sender {
}
@end
