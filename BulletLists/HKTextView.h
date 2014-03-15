//
//  HKTextView.h
//  BulletLists
//
//  Created by Hubert Kunnemeyer on 3/8/14.
//  Copyright (c) 2014 Hubert Kunnemeyer. All rights reserved.
//
@class HKTextView;
@protocol HKTextViewDelegate <NSObject>
- (void)textView:(HKTextView *)textView didPressTab:(id)sender;
@end

#import <UIKit/UIKit.h>

@interface HKTextView : UITextView
@property (nonatomic, weak) id<HKTextViewDelegate> customDelegate;
@end
