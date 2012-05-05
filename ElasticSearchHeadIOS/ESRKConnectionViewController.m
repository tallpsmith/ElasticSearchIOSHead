//
//  ESRKViewController.m
//  ElasticSearchHeadIOS
//
//  Created by Paul Smith on 3/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ESRKConnectionViewController.h"
#import "ESRKServerViewController.h"
#import "ESRKNode.h"
#import "ESRKClusterState.h"
#import "ESRKClusterHealth.h"

@interface ESRKConnectionViewController ()
@property (weak, nonatomic) IBOutlet UITextField *host;
@property (weak, nonatomic) IBOutlet UITextField *port;
@property (weak, nonatomic) IBOutlet UISwitch *useSSL;

@end

@implementation ESRKConnectionViewController
@synthesize hostName;
@synthesize host;
@synthesize port;
@synthesize useSSL;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

}

- (void)viewDidUnload
{
    [self setHost:nil];
    [self setPort:nil];
    [self setUseSSL:nil];
    [self setHostName:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
 
    BOOL shouldUseSSL = [self.useSSL isOn];
    
    NSString *sslSuffix = shouldUseSSL?@"s":@"";
    
    NSString *baseURL = [NSString stringWithFormat:@"http%@://%@:%@/",sslSuffix, [self.host text], [self.port text]];
    
    
    NSLog(@"Connecting to %@", baseURL);
    
    RKObjectMapping *nodeMapping = [RKObjectMapping mappingForClass:[ESRKNode class]];
    nodeMapping.forceCollectionMapping=YES;
    
    [nodeMapping mapKeyOfNestedDictionaryToAttribute:@"nodeId"];
    
    [nodeMapping mapKeyPath:@"(nodeId).name" toAttribute:@"nodeName"];
    [nodeMapping mapKeyPath:@"(nodeId).transport_address" toAttribute:@"transportAddress"];
    
    RKObjectMapping *clusterStateMapping = [RKObjectMapping mappingForClass:[ESRKClusterState class]];
    [clusterStateMapping mapKeyPath:@"cluster_name" toAttribute:@"clusterName"];
    [clusterStateMapping mapKeyPath:@"master_node" toAttribute:@"masterNode"];
    
    [clusterStateMapping mapKeyPath:@"nodes" toRelationship:@"nodes" withMapping:nodeMapping];
    
    RKObjectMapping *clusterHealthMapping = [RKObjectMapping mappingForClass:[ESRKClusterHealth class]];
     [clusterHealthMapping mapKeyPath:@"cluster_name" toAttribute:@"clusterName"];
     [clusterHealthMapping mapKeyPath:@"status" toAttribute:@"status"];
     
    
    
    RKObjectManager *manager =  [RKObjectManager objectManagerWithBaseURL:[NSURL URLWithString:baseURL]] ;
    
    manager.client.cachePolicy = RKRequestCachePolicyNone; 
    
    // we register this mapping against the object, but can't put it against a key path
    [manager.mappingProvider addObjectMapping:clusterStateMapping];
    [manager.mappingProvider addObjectMapping:clusterHealthMapping];
    
}

- (IBAction)textFieldEndOnExit:(id)sender {
    
    
}
@end
