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
@synthesize comment,picture;
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
    finalScore=(int)(scores*0.5+times*0.5);
    if (finalScore<=0) {
        comment.text=@"Everything's hard in the beginning!";
       picture.image=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"11" ofType:@"png"]];
    }
    if (finalScore<=100 && finalScore>0) {
        comment.text=@"good! keep working.";
         picture.image=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"22" ofType:@"png"]];
    }
    if (finalScore<=200 && finalScore>100) {
        comment.text=@"great! you are my idol.";
         picture.image=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"33" ofType:@"png"]];
    }
    if (finalScore>200) {
        comment.text=@"perfect! you are a genius.";
         picture.image=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"44" ofType:@"png"]];
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)alertView : (UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //得到输入框
    NSLog(@"ddd");
    if ([alertView textFieldAtIndex:0]!=nil) {
        UITextField *tf=[alertView textFieldAtIndex:0];
        NSLog(@"%@",tf.text);
    }
   
}
- (IBAction)upload:(id)sender {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"name"
                                                    message:@"please input your name"
                                                   delegate:self
                                          cancelButtonTitle:@"cancel"
                                          otherButtonTitles:@"OK", nil];
    // 基本输入框，显示实际输入的内容
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
    
}

- (IBAction)rank:(id)sender {
}
@end
