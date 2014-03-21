//
//  HKTSimpleControllerViewController.m
//  BulletLists
//
//  Created by Hubert Kunnemeyer on 3/15/14.
//  Copyright (c) 2014 Hubert Kunnemeyer. All rights reserved.
//

typedef NS_ENUM(NSInteger, AnimationType){
    AnimationTypeText,
    AnimationTypeFont,
    AnimationTypeColor
};

@import CoreText;

#import "HKTSimpleControllerViewController.h"
#import "NSString+Ipsum.h"

@interface HKTSimpleControllerViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *animationTypeControl;
@property (strong, nonatomic) CATextLayer *textLayer;
@property (nonatomic, assign) AnimationType animationType;
@end

@implementation HKTSimpleControllerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.textLayer = [CATextLayer layer];
    [self.textLayer setString:@"Foo"];
    [self.textLayer setForegroundColor:[UIColor redColor].CGColor];
    [self.textLayer setFontSize:50];
    [self.textLayer setFrame:CGRectMake(100, 150, 100, 60)];
    [[self.view layer] addSublayer:self.textLayer];

}

- (IBAction)didChangeAnimationType:(id)sender {
    // cast really not needed
    self.animationType = (AnimationType)self.animationTypeControl.selectedSegmentIndex;
    [self performAnimation:self.animationType];
}

- (void)performAnimation:(AnimationType)typeOfAnimation{
    if (typeOfAnimation == AnimationTypeText) {
        [self animateString];
    }
}
- (void)animateString{
    CGFloat animationDuration = 5.0;
    CABasicAnimation *colorAnimation = [CABasicAnimation
                                        animationWithKeyPath:@"foregroundColor"];
    colorAnimation.duration = animationDuration;
    colorAnimation.fillMode = kCAFillModeForwards;
    colorAnimation.removedOnCompletion = NO;
    colorAnimation.fromValue = (id)[UIColor redColor].CGColor;
    colorAnimation.toValue = (id)[UIColor blueColor].CGColor;
    colorAnimation.timingFunction = [CAMediaTimingFunction
                                     functionWithName:kCAMediaTimingFunctionLinear];
    [self.textLayer addAnimation:colorAnimation
                     forKey:@"colorAnimation"];
    [self.textLayer setNeedsLayout];

   
}
- (void)animationFont{
    
}
- (void)animateColor{
    
}










@end
