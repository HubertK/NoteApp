//
//  HKTConceptsController.m
//  BulletLists
//
//  Created by Hubert Kunnemeyer on 4/2/14.
//  Copyright (c) 2014 Hubert Kunnemeyer. All rights reserved.
//

#import "HKTConceptsController.h"

@interface HKTConceptsController ()

@end

@implementation HKTConceptsController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}


#pragma mark- View lfecycle
- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark- Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
