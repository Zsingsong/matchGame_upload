//
//  RankViewController.m
//  matchGame
//
//  Created by singsong on 13-12-1.
//  Copyright (c) 2013年 singsong. All rights reserved.
//

#import "RankViewController.h"

@interface RankViewController ()

@end

@implementation RankViewController
@synthesize myTableView,dataList;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        saveDictionary=[[NSDictionary alloc] init];
        // Custom initialization
            }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSArray *list = [NSArray arrayWithObjects:@"武汉",@"上海",@"北京",@"深圳",@"广州",@"重庆",@"香港",@"台海",@"天津", nil];
    self.dataList = list;

    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"rankList" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    keysArray=[[data allKeys] sortedArrayUsingComparator:^(id obj1, id obj2){
        if ([obj1 integerValue] > [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        
        if ([obj1 integerValue] < [obj2 integerValue]) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    saveDictionary=[NSDictionary dictionaryWithDictionary:data];
    for (int i=0; i<keysArray.count; i++) {
        NSLog(@"%@", [keysArray objectAtIndex:i]);
    }
    NSLog(@"%@", data);//直接打印数据。
    
    
    
    //table
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(24, 76, 272, 343) style:UITableViewStylePlain];
    // 设置tableView的数据源
    tableView.dataSource = self;
    // 设置tableView的委托
    tableView.delegate = self;
    // 设置tableView的背景图
    tableView.backgroundView=nil;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.opaque=NO;
    tableView.separatorStyle=NO;
    self.myTableView = tableView;
   [self.view addSubview:myTableView];
}

-(void)sortArray:(NSArray*)array
{
    NSMutableArray *temp=[[NSMutableArray alloc] init];
    for (NSString *key in array) {
       [temp addObject:[NSNumber numberWithInteger:[key integerValue]]];
    }
    [temp sortedArrayUsingSelector:@selector(compare:)];
    array=[NSArray arrayWithArray:temp];
    for (int i=0; i<array.count; i++) {
        NSLog(@"~~~~~~~%@", [array objectAtIndex:i]);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellWithIdentifier];
    }
    NSUInteger row = [indexPath row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor=[UIColor whiteColor];
    cell.textLabel.text = [keysArray objectAtIndex:row];
    cell.detailTextLabel.text =[saveDictionary objectForKey:[keysArray objectAtIndex:row]];
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  //  return dataList.count;
    return keysArray.count;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
