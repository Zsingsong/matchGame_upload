//
//  OverViewController.h
//  matchGame
//
//  Created by singsong on 13-11-30.
//  Copyright (c) 2013年 singsong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OverViewController : UIViewController <UIAlertViewDelegate>
{
    int finalScore;
    NSDictionary *saveDictionary;
}
@property (weak, nonatomic) IBOutlet UITextField *time;
@property (weak, nonatomic) IBOutlet UITextField *score;
- (IBAction)upload:(id)sender;
- (IBAction)rank:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UITextField *comment;
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
@end
