//
//  HKSettingsManager.m
//  BulletLists
//
//  Created by Kunnemeyer, Hubert on 3/22/14.
//  Copyright (c) 2014 Hubert Kunnemeyer. All rights reserved.
//

NSString * const userDefaultsSettingsKey = @"com.hubertk.notesapp.%@";


#import "Owner.h"
#import "HKSettingsManager.h"

@interface HKSettingsManager ()
@property (strong, nonatomic) NSDictionary *userDefaults;
@end

@implementation HKSettingsManager
/*
    • Numbered list support - (nested numbered lists?)
 
    • Nested bullet list suport
    • These should be choosen by the user.
        • Default bullet type
        • Bullet type to use for each tier in nested bullet lists
 
 
 Array of bullet types

 [@"\u2022",
 @"\u2023",
 @"\u2043",
 @"\u25E6",
 @"\u2219",
 @"\u29BF",
 @"\u29BE",
 @"\u25A1",
 @"\u25A0",
 @"\u25AB",
 @"\u25AA"];
 
 • Plain bullet point  - U+2022
 ‣ Triangular bullet  - U+2023
 ⁃ Hyphenated bullet - U+2043
 ◦ White bullet - U+25E6
 ∙ bullet operator - U+2219
 ⦿ Circled bullet - U+29BF
 ⦾ Circled-white bullet - U+29BE
 □ White square - U+25A1
 ■ Black square - U+25A0
 ▫ Small white square - U+25AB
 ▪ Small black square U+25AA
 
 
 */

- (instancetype)initSettingsForOwner:(Owner *)owner{
    self = [super init];
    if (self) {
        NSString *key = [NSString stringWithFormat:@"com.hubertk.notesapp.userKey.%@%",owner.userName];
        _userDefaults = [[NSUserDefaults standardUserDefaults]objectForKey:key];
    }
    return self;
}































@end
