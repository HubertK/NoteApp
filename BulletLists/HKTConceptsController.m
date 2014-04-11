//
//  HKTConceptsController.m
//  BulletLists
//
//  Created by Hubert Kunnemeyer on 4/2/14.
//  Copyright (c) 2014 Hubert Kunnemeyer. All rights reserved.
//
typedef NS_ENUM(NSInteger, pargraphStyle){
    kPargraphStyleTabInterval,
    kPargraphStyleHeadIndent,
    kPargraphStyleLocation    
};
#import "HKTConceptsController.h"

@interface HKTConceptsController ()
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) NSMutableArray *values;

- (IBAction)sliderValueChanged:(id)sender;
- (IBAction)segmentChanged:(id)sender;
@end

@implementation HKTConceptsController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}


#pragma mark- View lfecycle
- (void)viewDidLoad{
    [super viewDidLoad];
    self.values = [NSMutableArray arrayWithObjects:@(0),@(0),@(0), nil];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark- Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


- (IBAction)sliderValueChanged:(id)sender {

    
    NSNumber *val = [NSNumber numberWithFloat:self.slider.value];
    self.values[self.segmentControl.selectedSegmentIndex] = val;
     self.valueLabel.text = [NSString stringWithFormat:@"%@",self.values[self.segmentControl.selectedSegmentIndex]];
    // Now set the attribute
    NSAttributedString *attrString = [[NSAttributedString alloc]initWithString:self.textView.text attributes:[self attributes]];
    self.textView.attributedText = attrString;
    
}

- (IBAction)segmentChanged:(id)sender {
    self.valueLabel.text = [NSString stringWithFormat:@"%@",self.values[self.segmentControl.selectedSegmentIndex]];

    [self.slider setValue:[self.values[self.segmentControl.selectedSegmentIndex]floatValue] animated:YES];
}

- (NSDictionary *)attributes{
    CGFloat loc = [self.values[kPargraphStyleLocation]floatValue];
    CGFloat head = [self.values[kPargraphStyleHeadIndent]floatValue];
    CGFloat tabInt = [self.values[kPargraphStyleTabInterval]floatValue];
    NSTextTab *tab = [[NSTextTab alloc]initWithTextAlignment:NSTextAlignmentLeft location:loc options:0];
    NSArray *tabstops = @[tab];
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc]init];
    [paragraph setTabStops:tabstops];
    [paragraph setFirstLineHeadIndent:head];
    [paragraph setDefaultTabInterval:tabInt];
    
    return @{NSParagraphStyleAttributeName: paragraph};
}






@end
