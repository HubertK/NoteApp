//
//  HKSettingsManager.h
//  BulletLists
//
//  Created by Kunnemeyer, Hubert on 3/22/14.
//  Copyright (c) 2014 Hubert Kunnemeyer. All rights reserved.
//

#import <Foundation/Foundation.h>


NSString * const userDefaultsSettingsKey;
NSString * const bulletListKey;


@class Owner;

@interface HKSettingsManager : NSObject

@property (strong, nonatomic) Owner *owner;

- (instancetype)initSettingsForOwner:(Owner *)owner;
+ (instancetype)settingsManagerForOwner:(Owner *)owner;

- (NSArray *)bullets;
- (NSArray *)defaultBullets;
- (void)setNewBulletList:(NSArray *)newBulletList;
@end
