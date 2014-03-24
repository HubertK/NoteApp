//
//  HKSettingsManager.m
//  BulletLists
//
//  Created by Kunnemeyer, Hubert on 3/22/14.
//  Copyright (c) 2014 Hubert Kunnemeyer. All rights reserved.
//

NSString * const userDefaultsSettingsKey = @"com.hubertk.notesapp.%@";
NSString * const bulletListKey = @"UserBulletListKey";


#import "Owner.h"
#import "HKSettingsManager.h"

@interface HKSettingsManager ()
@property (strong, nonatomic) NSMutableDictionary *userDefaults;

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
- (NSArray *)defaultBullets{
    
    return @[@{@"\u2022":@"Plain bullet point"},
             @{@"\u2023":@"Triangular bullet"},
             @{@"\u2043":@"Hyphenated bullet"},
             @{@"\u25E6":@"White bullet"},
             @{@"\u2219":@"Bullet operator"},
             @{@"\u29BF":@"Circled bullet"},
             @{@"\u29BE":@"Circled-white bullet"},
             @{@"\u25A1":@"White square"},
             @{@"\u25A0":@"Black square "},
             @{@"\u25AB":@"Small white square"},
             @{@"\u25AA":@"Small black square"}];
}

- (instancetype)initSettingsForOwner:(Owner *)owner{
    self = [super init];
    if (self) {
        _owner = owner;
        NSString *key = [NSString stringWithFormat:userDefaultsSettingsKey,owner.userName];
        if (![[NSUserDefaults standardUserDefaults]objectForKey:key]) {
            [self setUpDefaultsDefaultsForKey:key];
        }else{
        _userDefaults = [[[NSUserDefaults standardUserDefaults]objectForKey:key]mutableCopy];
        }
    }
    return self;
}
+ (instancetype)settingsManagerForOwner:(Owner *)owner{
    return [[self alloc]initSettingsForOwner:owner];
}

- (NSArray *)bullets{
    return [self.userDefaults objectForKey:bulletListKey];
}

- (void)setNewBulletList:(NSArray *)newBulletList{
    [self.userDefaults setValue:newBulletList forKey:bulletListKey];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self save];
}
- (void)save{
    NSString *key = [NSString stringWithFormat:userDefaultsSettingsKey,self.owner.userName];
    [[NSUserDefaults standardUserDefaults]setObject:self.userDefaults forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
#pragma -mark
#pragma mark Defaults defaults
#pragma -mark
- (void)setUpDefaultsDefaultsForKey:(NSString *)key{
    self.userDefaults = [NSMutableDictionary dictionaryWithObjectsAndKeys:[self defaultBullets] ,bulletListKey, nil];
    // @{bulletListKey : [self defaultBullets]};
    [[NSUserDefaults standardUserDefaults]setObject:self.userDefaults forKey:key];
    [[NSUserDefaults standardUserDefaults]synchronize];
   
}






















@end
