//
//  List.h
//  BulletLists
//
//  Created by Hubert Kunnemeyer on 3/1/14.
//  Copyright (c) 2014 Hubert Kunnemeyer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Note : NSManagedObject

@property (nonatomic, retain) NSDate * creationDate;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * lastModified;
@property (nonatomic, retain) NSData * content;
@property (nonatomic, retain) NSNumber * isEncrypted;

@end
