//
//  Owner.m
//  BulletLists
//
//  Created by Hubert Kunnemeyer on 3/1/14.
//  Copyright (c) 2014 Hubert Kunnemeyer. All rights reserved.
//

#import "Owner.h"
#import "HKSettingsManager.h"

@implementation Owner

@dynamic userName;
@dynamic firstName;
@dynamic lastName;
@dynamic email;

- (void)setUserName:(NSString *)userName{
    [self willChangeValueForKey:@"userName"];
    [self updateSettingsKey:userName];
    [self didChangeValueForKey:@"userName"];
}


// update the settings key if username changes
- (void)updateSettingsKey:(NSString *)username{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *oldKey = [NSString stringWithFormat:userDefaultsSettingsKey,self.userName];// old username
    if ([userDefaults objectForKey:oldKey]) {
        NSDictionary *settings = [userDefaults objectForKey:oldKey];
        NSString *newKey =[NSString stringWithFormat:userDefaultsSettingsKey,username];//new username
        [userDefaults setObject:settings forKey:newKey];
        [userDefaults setObject:nil forKey:oldKey];
        [userDefaults synchronize];
    }
}
@end
