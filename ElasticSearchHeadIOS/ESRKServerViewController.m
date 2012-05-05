//
//  ESRKServerViewController.m
//  ElasticSearchHeadIOS
//
//  Created by Paul Smith on 3/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ESRKServerViewController.h"
#import "ESRKClusterHealth.h"
#import "ESRKNode.h"
#import "ESRKClusterState.h"

@interface ESRKServerViewController () {
    ESRKClusterState *clusterState;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property ESRKClusterState *clusterState;

@end

@implementation ESRKServerViewController

@synthesize tableView;
@synthesize clusterState;



- (void) setUpRestKit
{
    NSLog(@"Connecting to %@", [[RKClient sharedClient] baseURL]);
    
    RKObjectMapping *nodeMapping = [RKObjectMapping mappingForClass:[ESRKNode class]];
    nodeMapping.forceCollectionMapping=YES;
    
    [nodeMapping mapKeyOfNestedDictionaryToAttribute:@"nodeId"];
    
    [nodeMapping mapKeyPath:@"(nodeId).name" toAttribute:@"nodeName"];
    [nodeMapping mapKeyPath:@"(nodeId).transport_address" toAttribute:@"transportAddress"];
    
    RKObjectMapping *clusterStateMapping = [RKObjectMapping mappingForClass:[ESRKClusterState class]];
    [clusterStateMapping mapKeyPath:@"cluster_name" toAttribute:@"clusterName"];
    [clusterStateMapping mapKeyPath:@"master_node" toAttribute:@"masterNode"];
    
    [clusterStateMapping mapKeyPath:@"nodes" toRelationship:@"nodes" withMapping:nodeMapping];
    
    NSURL *baseURL = [RKClient sharedClient].baseURL;
    RKObjectManager *manager =  [RKObjectManager objectManagerWithBaseURL:baseURL] ;
    
    manager.client.cachePolicy = RKRequestCachePolicyNone; 
//    manager.client.authenticationType = RKRequestAuthenticationTypeNone;
    
    // this deprecation is due to the use of blocks for async callback
    //[manager loadObjectsAtResourcePath:@"/_cluster/health" objectMapping:objectMapping delegate:self];
    /*[manager loadObjectsAtResourcePath:@"/_cluster/state" objectMapping:clusterStateMapping delegate:self];*/
    
    NSString *clusterStateResourcePath = @"/_cluster/state";
    
    [manager.mappingProvider setMapping:clusterStateMapping forKeyPath:@""];
    
    [manager loadObjectsAtResourcePath:clusterStateResourcePath usingBlock:^(RKObjectLoader* loader) {
        loader.objectMapping = [[RKObjectManager sharedManager].mappingProvider objectMappingForClass:[ESRKClusterState class]];
        loader.method = RKRequestMethodGET;
    }];
    
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects {
    //ESRKClusterHealth *newClusterHealth = [objects objectAtIndex:0];
    //NSLog(@"Loaded Cluster Health -> ClusterName: %@, Status: %@", newClusterHealth.clusterName, newClusterHealth.status);
    //self.clusterHealth = newClusterHealth;
    
    self.clusterState = [objects objectAtIndex:0];
    
    [self.tableView reloadData];

    
}

- (void)objectLoader:(RKObjectLoader *)loader willMapData:(inout id *)mappableData

{
    NSLog(@" willMapData");
}

- (void)objectLoaderDidFinishLoading:(RKObjectLoader *)objectLoader
{
    NSLog(@"did finish loading");
    
}
- (void)objectLoaderDidLoadUnexpectedResponse:(RKObjectLoader *)objectLoader
{
    NSLog(@"Unexpected response");
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {
    NSLog(@"Encountered an error: %@", error);
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [self setUpRestKit];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setUpRestKit];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setTableView:nil];
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
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.clusterState.nodes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    NSString *cellText;
    
    ESRKNode *node = [self.clusterState.nodes objectAtIndex:indexPath.row];
    
    UILabel *titleLabel = [cell textLabel];
    UILabel *detailTextLable = [cell detailTextLabel];
                                
    [titleLabel setText:node.nodeName];
    [detailTextLable setText:node.transportAddress];
    
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

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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
