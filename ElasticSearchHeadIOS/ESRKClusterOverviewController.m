//
//  ESRKClusterOverviewController.m
//  ElasticSearchHeadIOS
//
//  Created by Paul Smith on 5/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ESRKClusterOverviewController.h"
#import "ESRKClusterHealth.h"


@interface ESRKClusterOverviewController (){
    ESRKClusterHealth *clusterHealth;
    NSDictionary *clusterHealthProperties;
}
        
@property (strong, nonatomic) ESRKClusterHealth *clusterHealth;
@property (strong, nonatomic) NSDictionary *clusterHealthProperties;

@end


@implementation ESRKClusterOverviewController
@synthesize tableView;

@synthesize clusterHealth;
@synthesize clusterHealthProperties;

- (void) retrieveClusterHealth
{
    RKObjectManager *manager = [RKObjectManager sharedManager];
    
    // retrieve the already registered Cluster State mapping and register it for the root key path of this URL
    RKObjectMapping *clusterHealthMapping = [manager.mappingProvider objectMappingForClass:[ESRKClusterHealth class]];
    [manager.mappingProvider setObjectMapping:clusterHealthMapping forKeyPath:@""];
    [manager loadObjectsAtResourcePath:@"/_cluster/health" delegate:self];
    
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects {
    self.clusterHealth = [objects objectAtIndex:0];
    
    self.clusterHealthProperties = [self.clusterHealth dictionaryWithValuesForKeys:[NSArray arrayWithObjects:@"clusterName", @"status", nil]];
    
    [self.tableView reloadData];
    
    
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {
    NSLog(@"Encountered an error: %@", error);
}


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
    
    [self retrieveClusterHealth];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.clusterHealthProperties.count;
}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [theTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSString *rowKeyValue = [self.clusterHealthProperties.allKeys objectAtIndex:indexPath.row];
    NSString *rowValue = [self.clusterHealthProperties.allValues objectAtIndex:indexPath.row];
    
    // Configure the cell...
    cell.textLabel.text = rowKeyValue;
    cell.detailTextLabel.text = rowValue;
    
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
