//
//  HKSettingTableViewController.m
//  BulletLists
//
//  Created by Hubert Kunnemeyer on 3/22/14.
//  Copyright (c) 2014 Hubert Kunnemeyer. All rights reserved.
//

#import "HKSettingTableViewController.h"
#import "HKSettingsManager.h"


@interface HKSettingTableViewController ()
@property (strong, nonatomic) NSMutableArray *userBullets;
@property (strong, nonatomic) HKSettingsManager *settings;
@end

@implementation HKSettingTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.rightBarButtonItem = self.editButtonItem;

}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.settings = [HKSettingsManager settingsManagerForOwner:self.owner];
    self.userBullets = [[self.settings bullets]mutableCopy];
   
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.userBullets count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"settingscell" forIndexPath:indexPath];
    
    // Configure the cell...
    NSDictionary *bulletList = self.userBullets[indexPath.row];
    cell.textLabel.text = [[bulletList allKeys]lastObject];
    cell.detailTextLabel.text = bulletList[cell.textLabel.text];
    return cell;
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath{
    NSDictionary *moveDictionary = self.userBullets[fromIndexPath.row];
    [self.userBullets removeObjectAtIndex:fromIndexPath.row];
    [self.userBullets insertObject:moveDictionary atIndex:toIndexPath.row];
    [self.settings setNewBulletList:self.userBullets];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
