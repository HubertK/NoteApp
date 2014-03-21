//
//  HKNoteManager.m
//  BulletLists
//
//  Created by Hubert Kunnemeyer on 3/1/14.
//  Copyright (c) 2014 Hubert Kunnemeyer. All rights reserved.
//

#import "HKNoteManager.h"

#import "Note.h"

@implementation HKNoteManager

+ (instancetype)sharedNoteManager{
    static dispatch_once_t once;
    static id sharedNoteManager;
    
    dispatch_once(&once, ^
                  {   // initializing once
                      sharedNoteManager = [self new];
                  });
    
    return sharedNoteManager;
}

+ (void)setUpWithContext:(NSManagedObjectContext *)ctx{
    if (ctx) {
        [[HKNoteManager sharedNoteManager] setManagedObjectContext:ctx];
        // Register for save notifications so we can set the modification date
        [[NSNotificationCenter defaultCenter]addObserver:[HKNoteManager sharedNoteManager] selector:@selector(managedObjectContextSaveNotification:) name:NSManagedObjectContextWillSaveNotification object:ctx];
    }else{
        //TODO: Move this to a seperate class. Create an Error class for handling all errors throughout the app
        NSString *expName = @"ManageedObjectContext Exception";
        NSString *expReason = @"managedObjectContext is nil.\nCannot continue without a valid managedObjectContext";
        NSException *noContextExc = [NSException exceptionWithName:expName reason:expReason userInfo:nil];
        [noContextExc raise];
    }
}
+ (BOOL)addNewList:(Note *)list{
    BOOL ok = NO;
    // add saving code here
    return ok;
}

+ (BOOL)deleteList:(Note *)list{
    BOOL ok  = NO;
    //add deletion code here
    return ok;
}


#pragma -mark
#pragma mark ManagedObjectContext Notifications
#pragma -mark

- (void)managedObjectContextSaveNotification:(NSNotification *)notification{

    NSManagedObjectContext *context = [notification object];
    NSDate *modDate = [NSDate date];
    // Filter the objects to only incluse List* objects
    NSPredicate *listsOnlyFilter = [NSPredicate predicateWithBlock:^BOOL(NSManagedObject *object, NSDictionary *bindings) {
        return [object isKindOfClass:[Note class]];
    }];
    
    // inserted
    NSSet *insertedLists = [[context insertedObjects] filteredSetUsingPredicate:listsOnlyFilter];
    for (NSManagedObject *obj in insertedLists) {
        // inserted get a creation date also
            Note *list = (Note *)obj;
            list.creationDate = modDate;
            list.lastModified = modDate;
    }
    
    //updated
    NSSet *updatedLsts = [[context updatedObjects] filteredSetUsingPredicate:listsOnlyFilter];
    for (NSManagedObject *obj in updatedLsts) {
            Note *list = (Note *)obj;
            list.lastModified = modDate;
    }
}







@end
