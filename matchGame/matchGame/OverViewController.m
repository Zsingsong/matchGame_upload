//
//  OverViewController.m
//  matchGame
//
//  Created by singsong on 13-11-30.
//  Copyright (c) 2013年 singsong. All rights reserved.
//

#import "OverViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "RankViewController.h"
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
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"rankList" ofType:@"plist"];
        NSDictionary *oldContent = [NSDictionary dictionaryWithContentsOfFile:plistPath];
        // Make a mutable copy.
        NSMutableDictionary *newContent = [oldContent  mutableCopy] ;
        // Add new stuff.
        [newContent setObject:tf.text forKey:[NSString stringWithFormat:@"%d",finalScore]];
        // Now, write the plist:
        [newContent writeToFile:plistPath atomically:YES];
        NSLog(@"%@", oldContent);
        NSLog(@"%@", newContent);
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
   RankViewController *rank=[[RankViewController alloc] init];
    CATransition* transition = [CATransition animation];
    //执行时间长短
    transition.duration = 0.5;
    //动画的开始与结束的快慢
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //各种动画效果
    transition.type = @"cube"; //kCATransitionMoveIn, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    //动画方向
    //transition.subtype = kCATransitionFromTop; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    //将动画添加在视图层上
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    //[[self navigationController] popViewControllerAnimated:NO];
    [self.navigationController pushViewController:rank animated:NO];
    
}
@end
