//
//  GameViewController.m
//  matchGame
//
//  Created by singsong on 13-11-30.
//  Copyright (c) 2013年 singsong. All rights reserved.
//

#import "GameViewController.h"

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
        tempArray=[[NSMutableArray alloc]initWithObjects:@"1",@"1",@"2",@"2",@"3",@"3",@"4",@"4",@"5",@"5",@"6",@"6", nil ];
        imagesArray=[[NSMutableArray alloc] init];
        int temp;
        for (int i=0; i<12; i++) {
            temp=arc4random()%tempArray.count;
            [imagesArray addObject:[tempArray objectAtIndex:i]];
            [tempArray removeObjectAtIndex:i];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    imagesOriginArray=[[NSMutableArray alloc] initWithObjects:image1,image2,image3,image4,image5,image6,image7,image8,image9,image10,image11,image12, nil];
}
//获取背景图片
-(UIImage*)getBackgroundImage
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"background" ofType:@"png"];
    return [UIImage imageWithContentsOfFile:path];
}
//所有图片翻转为背面
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)start:(id)sender {
}
@end
