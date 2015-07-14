//
//  FISLocationsTableViewController.m
//  locationTrivia-tableviews
//
//  Created by Joe Burgess on 6/20/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//
#import "FISLocation.h"
#import "FISLocationsTableViewController.h"
#import "FISTriviaTableViewController.h"

@interface FISLocationsTableViewController ()

@end

@implementation FISLocationsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.store getAllLocationsWithCompletion:^(BOOL retrieved) {
        if (retrieved)
            NSLog(@"Finished");
        [self.tableView reloadData];
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.accessibilityIdentifier=@"Locations Table";
    self.view.accessibilityLabel=@"Locations Table";
    self.store = [FISLocationsDataStore sharedLocationsDataStore];
    
    self.tableView.allowsMultipleSelectionDuringEditing = NO;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.store.locations count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rightCell" forIndexPath:indexPath];

    FISLocation *location = self.store.locations[indexPath.row];

    cell.textLabel.text = location.name;

    cell.detailTextLabel.text = [location numberOfTriva];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        FISLocation *locationToDelete = self.store.locations[indexPath.row];
        
        [self.store deleteLocationWithID:locationToDelete.locationID withCompletion:^(BOOL deleted) {
            if (deleted)
            [self.store.locations removeObjectAtIndex:indexPath.row];
            NSLog(@"Successfully deleted");
            [self.tableView reloadData];
        }];
    }
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"newLocation"]){
        

    } else if ([segue.identifier isEqualToString:@"trivia"]){
        NSIndexPath *ip = [self.tableView indexPathForSelectedRow];
        FISLocation *location = self.store.locations[ip.row];
        FISTriviaTableViewController *triviaVC = segue.destinationViewController;
        triviaVC.location = location;
    }
   

}

@end
