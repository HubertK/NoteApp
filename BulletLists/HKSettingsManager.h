//
//  HKSettingsManager.h
//  BulletLists
//
//  Created by Kunnemeyer, Hubert on 3/22/14.
//  Copyright (c) 2014 Hubert Kunnemeyer. All rights reserved.
//

#import <Foundation/Foundation.h>


NSString * const userDefaultsSettingsKey;


@class Owner;

@interface HKSettingsManager : NSObject

- (instancetype)initSettingsForOwner:(Owner *)owner;

@end
