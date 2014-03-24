//
//  HKNoteController.m
//  BulletLists
//
//  Created by Hubert Kunnemeyer on 3/1/14.
//  Copyright (c) 2014 Hubert Kunnemeyer. All rights reserved.
//

#import "HKNoteController.h"
#import "HKTextView.h"
#import "HKSettingTableViewController.h"

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
    self.textView.layoutManager.delegate = self;
    self.textView.customDelegate = self;
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.textView.text = self.note.text;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self saveNote];
}
#pragma -mark
#pragma mark HKTextView (didPressTab:)
#pragma -mark
- (void)textView:(HKTextView *)textView didPressTab:(id)sender{

    NSString *tabbedBullet = [NSString stringWithFormat:@"\t%@",[self bullet]];
    [self.textView insertText:tabbedBullet];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)openSettingsMenu:(id)sender {
    
}
- (void)enumerateGlyphs{
    
    NSRange textRange = NSMakeRange(0, self.textView.text.length);
    [self.textView.layoutManager enumerateLineFragmentsForGlyphRange:textRange usingBlock:^(CGRect rect, CGRect usedRect, NSTextContainer *textContainer, NSRange glyphRange, BOOL *stop) {
        NSString *line = [self.textView.text substringWithRange:glyphRange];
        NSLog(@"LINE:\n%@",line);
    }];
}
- (NSString *)bullet{
    return @"\u2022";
}
- (void)saveNote{
    NSManagedObjectContext *managedObjectContext = self.note.managedObjectContext;
    self.note.text = self.textView.text;
    NSError *noteSavingError = nil;
    BOOL saved = [managedObjectContext save:&noteSavingError];
    if (!saved && noteSavingError != nil) {
        NSLog(@"\n\nError saving Note usin Moc:%@\nERROR:%@\n\n",[managedObjectContext description],[noteSavingError localizedDescription]);
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"show settings"]) {
        Owner *owner = [NSEntityDescription insertNewObjectForEntityForName:@"Owner" inManagedObjectContext:self.note.managedObjectContext];
        owner.userName = @"Hubiedoo517";
        owner.firstName = @"Hubert";
        owner.lastName = @"Kunnemeyer";
        [segue.destinationViewController setOwner:owner];
    }
}


- (BOOL)isNewLine{
    return NO;
}
- (BOOL)isPartOfList{
    return NO;
}
- (BOOL)shouldIndentLineFragmentInRange:(NSRange)range{
    return NO;
}
- (NSInteger)indentationLevelForLineFragmentInRange:(NSRange)rangeOfLine{
    return 0;
}












@end
