//
//  RankViewController.h
//  matchGame
//
//  Created by singsong on 13-12-1.
//  Copyright (c) 2013年 singsong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RankViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>  {
    NSDictionary *saveDictionary;
    NSArray *keysArray;
    NSMutableArray *valuesArray;
   
}
@property (strong,nonatomic) UITableView *myTableView;
- (IBAction)replay:(id)sender;
- (IBAction)exit:(id)sender;
@end
