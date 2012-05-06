//
//  ESRKNodeInfoViewControllerViewController.m
//  ElasticSearchHeadIOS
//
//  Created by Paul Smith on 6/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ESRKNodeInfoViewControllerViewController.h"

@interface ESRKNodeInfoViewControllerViewController () {
    NSDictionary *nodeProperties;
    NSDictionary *processProperties;
}
@property NSDictionary *nodeProperties;
@property NSDictionary *processProperties;

@end

@implementation ESRKNodeInfoViewControllerViewController

@synthesize node;


@synthesize nodeProperties;
@synthesize processProperties;

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



    self.nodeProperties = [node dictionaryWithValuesForKeys:[NSArray arrayWithObjects:@"nodeId", @"nodeName", nil]];
    
    self.processProperties = [node.processInfo dictionaryWithValuesForKeys:[NSArray arrayWithObjects:@"processId", @"refreshInterval", @"maxFileDescriptors", nil]];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view 
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
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
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section==0){
        return @"Node Info";
    } else if (section==1){
        return @"Process Info";
    } else {
        return nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        return nodeProperties.count;
    } else if(section == 1){
        return processProperties.count;
    }else {
        return 0;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSDictionary *dictionary;
    
    if(indexPath.section == 0){
        dictionary = nodeProperties;
    } else if(indexPath.section==1){
        dictionary = processProperties;
        
    }
    
    cell.textLabel.text = [dictionary.allKeys objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [dictionary.allValues objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self performSegueWithIdentifier:@"nodeInfoSegue" sender:self];
}

@end
