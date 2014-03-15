//
//  HKTextView.m
//  BulletLists
//
//  Created by Hubert Kunnemeyer on 3/8/14.
//  Copyright (c) 2014 Hubert Kunnemeyer. All rights reserved.
//

#import "HKTextView.h"
@import QuartzCore;

@interface HKTextView ()
@property (strong, nonatomic) UIView *accesoryView;
@property (strong, nonatomic) UIButton *tabButton;
@end

@implementation HKTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp{
    NSNotificationCenter *noteCenter = [NSNotificationCenter defaultCenter];
    
    // These may need to be change to Will instead of Did show notifications or both may be needed for fine tuning animations and appearences
    [noteCenter addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [noteCenter addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];

}
- (UIView *)inputAccessoryView {
    if (!self.accesoryView) {
        CGRect accessFrame = CGRectMake(0, 0, CGRectGetWidth(self.superview.frame), 38.0);
        self.accesoryView = [[UIView alloc] initWithFrame:accessFrame];
        self.accesoryView.backgroundColor = [UIColor colorWithWhite:0.865 alpha:1.000];
        self.tabButton = [UIButton buttonWithType:UIButtonTypeSystem];
        self.tabButton.frame = CGRectMake(10, 6, 50, 34);
        [self.tabButton setTitle: @"tab" forState:UIControlStateNormal];
        [self.tabButton addTarget:self action:@selector(insertTab:) forControlEvents:UIControlEventTouchUpInside];
        
        // customze button
        [self.tabButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.tabButton setBackgroundColor:[UIColor whiteColor]];
        // layer customization
//        tabButton.layer.borderColor = [UIColor colorWithWhite:0.341 alpha:1.000].CGColor;
//        tabButton.layer.borderWidth = 1.0f;
        self.tabButton.layer.cornerRadius = 5.0f;
        
        [self.accesoryView addSubview:self.tabButton];
    }
    return self.accesoryView;
}
- (void)insertTab:(id)sender{
    if ([self.customDelegate respondsToSelector:@selector(textView:didPressTab:)]) {
        [self.customDelegate textView:self didPressTab:sender];
    }
}


#pragma -mark
#pragma mark Keyboard notification callbacks
#pragma -mark

- (void)keyboardDidShow:(NSNotification *)notification{
    [self layoutSubviews];
}
- (void)keyboardDidHide:(NSNotification *)notification{
    [self layoutSubviews];
}












@end
