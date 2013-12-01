//
//  GameViewController.m
//  matchGame
//
//  Created by singsong on 13-11-30.
//  Copyright (c) 2013年 singsong. All rights reserved.
//

#import "GameViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "OverViewController.h"
@interface GameViewController ()

@end

@implementation GameViewController
@synthesize image1,image2,image3,image4,image5,image6,image7,image8,image9,image10,image11,image12;
@synthesize time,score,play;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        rememberTimes=4;
        num=0;
        state=NO;
        times=0;
        scores=0;
        isFirst=YES;
        isSecond=YES;
        firstLastTime=3;
        secondLastTime=3;
        secondAnimationTime=1;
        tempArray=[[NSMutableArray alloc]initWithObjects:@"1",@"1",@"2",@"2",@"3",@"3",@"4",@"4",@"5",@"5",@"6",@"6", nil];
        imagesArray=[[NSMutableArray alloc] init];
        int temp;
        for (int i=0; i<12; i++) {
            temp=arc4random()%tempArray.count;
            [imagesArray addObject:[tempArray objectAtIndex:temp]];
            [tempArray removeObjectAtIndex:temp];
            NSLog(@"temp: %d,length: %d",temp,tempArray.count);
            NSLog(@"imageArrat:%d",imagesArray.count);
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    imagesOriginArray=[[NSMutableArray alloc]initWithObjects:image1,image2,image3,image4,image5,image6,image7,image8,image9,image10,image11,image12,nil];
      //定时器
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerHandler:) userInfo:nil repeats:YES];
    //暂停定时器
   [timer setFireDate:[NSDate distantFuture]];
 
}
//定时器处理函数
-(void)timerHandler:(NSTimer*)T
{
    if (rememberTimes>0) {
        if (rememberTimes==3) {
            [self rollAllOver];
        }
        if (rememberTimes==1) {
            [self getAllBackgroundImages];
            state=YES;
            [self addAllEvent];
            [play setEnabled:YES];
            
        }
    --rememberTimes;
    }
    else
    {
        if (firstImage!=nil && secondImage==nil) {
            if (firstLastTime>0) {
                if (firstLastTime==1) {
                    firstImage.image=[self getBackgroundImage];
                    [self animation:firstImage];
                    firstImage=nil;
                    isFirst=YES;
                }
                --firstLastTime;
            }
        }
        else
            if (firstImage!=nil &&secondImage!=nil) {
                if ([[self getImageOrigin:firstImage] isEqual:[self getImageOrigin:secondImage]]) {
//                    if (secondAnimationTime>0) {
//                        if (secondAnimationTime==1) {
                            firstImage.hidden=YES;
                            secondImage.hidden=YES;
                            //firstImage.userInteractionEnabled=NO;
                            //secondImage.userInteractionEnabled=NO;
                            firstImage=nil;
                            secondImage=nil;
                            isFirst=YES;
                            isSecond=YES;
                            scores+=100;
                            score.text=[NSString stringWithFormat:@"%d",scores];
                             ++num;
//                        }
//                        secondAnimationTime--;
//                    }
                    if (num==6) {
                        [timer invalidate];
                        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                         [userDefaults setInteger:scores        forKey:@"scores"];
                           [userDefaults setInteger:times        forKey:@"times"];
                        [userDefaults synchronize]; 
                        OverViewController *over=[[OverViewController alloc] init];
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
                        [self.navigationController pushViewController:over animated:NO];
                    }
                }
                else
                {  if (secondLastTime>0) {
                    if (secondLastTime==1) {
                        firstImage.image=[self getBackgroundImage];
                        secondImage.image=[self getBackgroundImage];
                        [self animation:firstImage];
                        [self animation:secondImage];
                        firstImage=nil;
                        secondImage=nil;
                        isFirst=YES;
                        isSecond=YES;
                        scores-=50;
                         score.text=[NSString stringWithFormat:@"%d",scores];
                       }
                    --secondLastTime;
                    }
                }
            }
        
        
        
        
        time.text=[NSString stringWithFormat:@"%d",++times];
    }
    
        
  
}
-(void)viewWillAppear:(BOOL)animated
{
    //开启定时器
    [timer setFireDate:[NSDate distantPast]];
}
//翻转正面
-(void)rollAllOver
{
    NSString *path;
    for (int i=0; i<12; i++) {
        path = [[NSBundle mainBundle] pathForResource:[imagesArray objectAtIndex:i] ofType:@"png"];
        NSLog(@"%@",[imagesArray objectAtIndex:i]);
        [(UIImageView*)[imagesOriginArray objectAtIndex:i] setImage:[UIImage imageWithContentsOfFile:path]];
         NSLog(@"imageoriginArra:%d",imagesOriginArray.count);
        path=nil;
        [self animation:(UIImageView*)[imagesOriginArray objectAtIndex:i]];
    }
}
//翻转制定的图片
-(void)rollImageOver:(UIImageView*)imageView
{
    NSString *path;
    for (int i=0; i<12; i++) {
        if ([[imagesOriginArray objectAtIndex:i] isEqual:imageView]) {
            path=[[NSBundle mainBundle] pathForResource:[imagesArray objectAtIndex:i] ofType:@"png"];
            [(UIImageView*)[imagesOriginArray objectAtIndex:i] setImage:[UIImage imageWithContentsOfFile:path]];
            [self animation:(UIImageView*)[imagesOriginArray objectAtIndex:i]];
        }
    }
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
        [self animation:(UIImageView*)[imagesOriginArray objectAtIndex:i]];
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

//增加单击事件
-(void)addTapSingleEvent:(UIImageView*)imageView
{
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSingleHandler:)];
    [imageView addGestureRecognizer:singleTap];
}
//单击处理函数
-(void)tapSingleHandler:(UITapGestureRecognizer *)sender
{
    NSLog(@"danji");
    if (isFirst) {
        isFirst=NO;
        firstImage=(UIImageView*)[sender view];
        NSLog(@"%@",firstImage);
        [self rollImageOver:firstImage];
    }
    else
    if(isSecond)
    {
       secondImage=(UIImageView*)[sender view];
        if ([firstImage isEqual:secondImage]) {
            if (firstImage !=nil && secondImage !=nil) {
          
            firstImage.image=[self getBackgroundImage];
            [self animation:firstImage];
            isFirst=YES;
            firstImage=nil;
            secondImage=nil;
            firstLastTime=3;}
        }
        else
        {
            isSecond=NO;
            [self rollImageOver:secondImage];
        }
    }
    else
    {
        if (firstImage!=nil && secondImage!=nil) {
        
        firstImage.image=[self getBackgroundImage];
        [self animation:firstImage];
        secondImage.image=[self getBackgroundImage];
        [self animation:secondImage];
        isFirst=YES;
        isSecond=YES;
        firstImage=nil;
        secondImage=nil;
        firstLastTime=3;
        secondAnimationTime=2;
        secondLastTime=3;
        scores-=50;
            score.text=[NSString stringWithFormat:@"%d",scores];}
        
    }
    
}
//为所有图片添加单击事件
-(void)addAllEvent
{
    for (int i=0; i<12; i++) {
        [self addTapSingleEvent: (UIImageView*)[imagesOriginArray objectAtIndex:i]];
    }
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
        [timer setFireDate:[NSDate distantFuture]];
            state=NO;
        firstImage.image=[self getBackgroundImage];
        secondImage.image=[self getBackgroundImage];
        [self animation:firstImage];
        [self animation:secondImage];
        firstImage=nil;
        secondImage=nil;
        isFirst=YES;
        isSecond=YES;
        firstLastTime=3;
        secondLastTime=3;
        //[(UIButton*)sender setTitle:@"pause" forState:default];
       }
    else
       {
           [timer setFireDate:[NSDate date]];
            state=YES;
         
       //[(UIButton*)sender setTitle:@"play" forState:select];
       }
}
@end
