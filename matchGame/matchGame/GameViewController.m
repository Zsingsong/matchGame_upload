//
//  GameViewController.m
//  matchGame
//
//  Created by singsong on 13-11-30.
//  Copyright (c) 2013年 singsong. All rights reserved.
//

#import "GameViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface GameViewController ()

@end

@implementation GameViewController
@synthesize image1,image2,image3,image4,image5,image6,image7,image8,image9,image10,image11,image12;
@synthesize time,score;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        rememberTimes=4;
        state=NO;
        tempArray=[[NSMutableArray alloc]initWithObjects:@"1",@"1",@"2",@"2",@"3",@"3",@"4",@"4",@"5",@"5",@"6",@"6", nil ];
        imagesArray=[[NSMutableArray alloc] init];
        int temp;
        for (int i=0; i<12; i++) {
            temp=arc4random()%tempArray.count;
            [imagesArray addObject:[tempArray objectAtIndex:temp]];
            [tempArray removeObjectAtIndex:temp];
            NSLog(@"temp: %d,length: %d",temp,tempArray.count);
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    imagesOriginArray=[[NSMutableArray alloc] initWithObjects:image1,image2,image3,image4,image5,image6,image7,image8,image9,image10,image11,image12, nil];
   //定时器
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerHandler:) userInfo:nil repeats:YES];
    //暂停定时器
   [timer setFireDate:[NSDate distantFuture]]; 
}
//定时器处理函数
-(void)timerHandler:(NSTimer*)timer
{
    if (rememberTimes>0) {
        if (rememberTimes==1) {
            [self getAllBackgroundImages];
        }
    }
    --rememberTimes;
}
//获取背景图片
-(UIImage*)getBackgroundImage
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"background" ofType:@"png"];
    return [UIImage imageWithContentsOfFile:path];
}
//所有图片翻转为背面
-(void)getAllBackgroundImages
{
    for (int i=0; i<12; i++) {
        [(UIImageView*)[imagesOriginArray objectAtIndex:i] setImage:[self getBackgroundImage]];
    }
}
//获取制定图片源
-(NSString*)getImageOrigin:(UIImageView*)imageView
{
    for (int i=0; i<12; i++) {
        if ([[imagesOriginArray objectAtIndex:i] isEqual:imageView]) {
            return [imagesArray objectAtIndex:i];
            //break;
        }
    }
    return nil;
}
//翻转制定的图片
-(void)rollImageOver:(UIImageView*)imageView
{
    NSString *path;
    for (int i=0; i<12; i++) {
        if ([[imagesOriginArray objectAtIndex:i] isEqual:imageView]) {
            path=[[NSBundle mainBundle] pathForResource:[imagesArray objectAtIndex:i] ofType:@"png"];
            [(UIImageView*)[imagesOriginArray objectAtIndex:i] setImage:[UIImage imageWithContentsOfFile:path]];
         }
    }
}
//增加单击事件
-(void)addTapSingleEvent:(UIImageView*)imageView
{
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yourHandlingCode:)];
    [imageView addGestureRecognizer:singleTap];
}
//增加动画
-(void)animation:(UIView*)view
{
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    //动画的开始与结束的快慢
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //各种动画效果
    transition.type = @"oglFlip";//kCATransitionFade; kCATransitionMoveIn, kCATransitionPush, kCATransitionReveal, kCATransitionFade
    //动画方向
    //transition.subtype = kCATransitionFromTop; //kCATransitionFromLeft, kCATransitionFromRight, kCATransitionFromTop, kCATransitionFromBottom
    //将动画添加在视图层上
    [view.layer addAnimation:transition forKey:nil];    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)start:(id)sender {
    if (state) {
        [timer setFireDate:[NSDate distantPast]];  
        state=NO;
        [(UIButton*)sender setTitle:@"pause" forState:nil];
       }
    else
       {
           [timer setFireDate:[NSDate distantFuture]];
           state=YES;
       [(UIButton*)sender setTitle:@"play" forState:nil];
       }
}
@end
