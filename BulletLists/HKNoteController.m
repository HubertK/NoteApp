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
#import "HKTextStoage.h"

@interface HKNoteController ()<UITextViewDelegate,HKTextViewDelegate,NSLayoutManagerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *menuButton;
@property (strong, nonatomic) IBOutlet HKTextView *textView;
@property (strong, nonatomic) HKTextStoage *textStorage;

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

- (void)viewDidLoad{
    [super viewDidLoad];
    NSDictionary* attrs = @{NSFontAttributeName:
                                [UIFont systemFontOfSize:16]};
    NSAttributedString* attrString = [[NSAttributedString alloc]
                                      initWithString:self.note.text
                                      attributes:attrs];
    _textStorage = [HKTextStoage new];
    [_textStorage appendAttributedString:attrString];
    
    CGFloat topOffset = self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
    CGRect textViewRect = CGRectMake(0, topOffset, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-topOffset);
    
    
    // 2. Create the layout manager
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    layoutManager.delegate = self;
    // 3. Create a text container
    CGSize containerSize = CGSizeMake(textViewRect.size.width,  CGFLOAT_MAX);
    NSTextContainer *container = [[NSTextContainer alloc] initWithSize:containerSize];
    container.widthTracksTextView = YES;
    [layoutManager addTextContainer:container];
    [_textStorage addLayoutManager:layoutManager];
    
    // 4. Create a UITextView
    _textView = [[HKTextView alloc] initWithFrame:textViewRect
                                    textContainer:container];
    _textView.delegate = self;
    self.textView.customDelegate = self;
    [self.view addSubview:_textView];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self saveNote];
}
#pragma -mark
#pragma mark HKTextView (didPressTab:)
#pragma -mark
- (void)textView:(HKTextView *)textView didPressTab:(id)sender{
    [textView insertText:@"\t•"];
    [self.textStorage addBulletPointStyle];
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




//- (CGFloat)layoutManager:(NSLayoutManager *)layoutManager paragraphSpacingAfterGlyphAtIndex:(NSUInteger)glyphIndex withProposedLineFragmentRect:(CGRect)rect{
//     NSLog(@"layoutspacingfrag");
//    return 0;
//}
//- (CGFloat)layoutManager:(NSLayoutManager *)layoutManager paragraphSpacingBeforeGlyphAtIndex:(NSUInteger)glyphIndex withProposedLineFragmentRect:(CGRect)rect{
//     NSLog(@"pars spacing before");
//    return 2;
//    
//}
//- (CGFloat)layoutManager:(NSLayoutManager *)layoutManager lineSpacingAfterGlyphAtIndex:(NSUInteger)glyphIndex withProposedLineFragmentRect:(CGRect)rect{
//    return 0;
//}






@end
