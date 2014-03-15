//
//  HKNoteManager.h
//  BulletLists
//
//  Created by Hubert Kunnemeyer on 3/1/14.
//  Copyright (c) 2014 Hubert Kunnemeyer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HKNoteManager : NSObject
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

+ (instancetype)sharedNoteManager;

+ (void)setUpWithContext:(NSManagedObjectContext *)ctx;

@end
