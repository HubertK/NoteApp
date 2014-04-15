//
//  HKTextStoage.h
//  BulletLists
//
//  Created by Hubert Kunnemeyer on 3/29/14.
//  Copyright (c) 2014 Hubert Kunnemeyer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HKTextStoage : NSTextStorage

- (void)addBulletPointStyle;
- (NSDictionary *)defaultAttributes;
@end
