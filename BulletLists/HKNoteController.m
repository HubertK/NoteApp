//
//  HKNoteController.m
//  BulletLists
//
//  Created by Hubert Kunnemeyer on 3/1/14.
//  Copyright (c) 2014 Hubert Kunnemeyer. All rights reserved.
//

#import "HKNoteController.h"
#import "HKTextView.h"

@interface HKNoteController ()<UITextViewDelegate,HKTextViewDelegate,NSLayoutManagerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (weak, nonatomic) IBOutlet HKTextView *textView;

@end

@implementation HKNoteController

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
    self.textView.delegate = self;
    self.textView.customDelegate = self;
    
}
#pragma -mark
#pragma mark HKTextView (didPressTab:)
#pragma -mark
- (void)textView:(HKTextView *)textView didPressTab:(id)sender{
    NSInteger rndIndx = arc4random() % ([[self possibleBullets]count] - 1) + 1; //create the random number.

    NSString *tabbedBullet = [NSString stringWithFormat:@"\t%@",[self possibleBullets][rndIndx]];
    [self.textView insertText:tabbedBullet];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)openSettingsMenu:(id)sender {
}
- (NSArray *)possibleBullets{
    return @[@"\u2022",
             @"\u2023",
             @"\u2043",
             @"\u25E6",
             @"\u2219",
             @"\u29BF",
             @"\u29BE",
             @"\u25A1",
             @"\u25A0",
             @"\u25AB",
             @"\u25AA"];
    /*
     • Plain bullet point  - U+2022
     ‣ Triangular bullet  - U+2023
     ⁃ Hyphenated bullet - U+2043
     ◦ White bullet - U+25E6
     ∙ bullet operator - U+2219
     ⦿ Circled bullet - U+29BF
     ⦾ Circled-white bullet - U+29BE
     □ White square - U+25A1
     ■ Black square - U+25A0
     ▫ Small white square - U+25AB
     ▪ Small black square U+25AA
*/
}
@end
