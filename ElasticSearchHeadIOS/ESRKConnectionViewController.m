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
#import "ESRKNodeProcessInfo.h"

@interface ESRKConnectionViewController ()
@property (weak, nonatomic) IBOutlet UITextField *host;
@property (weak, nonatomic) IBOutlet UITextField *port;
@property (weak, nonatomic) IBOutlet UISwitch *useSSL;
@property (weak, nonatomic) IBOutlet UISwitch *traceDebugging;

@end

@implementation ESRKConnectionViewController
@synthesize hostName;
@synthesize host;
@synthesize port;
@synthesize useSSL;
@synthesize traceDebugging;

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
    [self setTraceDebugging:nil];
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
    
    if([self.traceDebugging isOn]){
        RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
    }
    
    NSLog(@"Connecting to %@", baseURL);

#pragma mark ESRKNodeProcessInfo mapping
    
    RKObjectMapping *nodeProcessInfoMapping =[RKObjectMapping mappingForClass:[ESRKNodeProcessInfo class]];
    [nodeProcessInfoMapping mapKeyPath:@"refresh_interval" toAttribute:@"refreshInterval"];
    [nodeProcessInfoMapping mapKeyPath:@"id" toAttribute:@"processId"];
    [nodeProcessInfoMapping mapKeyPath:@"max_file_descriptors" toAttribute:@"maxFileDescriptors"];

    
#pragma mark ESRKNode Mapping
    RKObjectMapping *nodeMapping = [RKObjectMapping mappingForClass:[ESRKNode class]];
    nodeMapping.forceCollectionMapping=YES;
    
    [nodeMapping mapKeyOfNestedDictionaryToAttribute:@"nodeId"];
    
    [nodeMapping mapKeyPath:@"(nodeId).name" toAttribute:@"nodeName"];
    [nodeMapping mapKeyPath:@"(nodeId).transport_address" toAttribute:@"transportAddress"];
    [nodeMapping mapKeyPath:@"(nodeId).process" toRelationship:@"processInfo" withMapping:nodeProcessInfoMapping];
    
#pragma mark ESRKClusterState mapping
    RKObjectMapping *clusterStateMapping = [RKObjectMapping mappingForClass:[ESRKClusterState class]];
    [clusterStateMapping mapKeyPath:@"cluster_name" toAttribute:@"clusterName"];
    [clusterStateMapping mapKeyPath:@"master_node" toAttribute:@"masterNode"];
    
    [clusterStateMapping mapKeyPath:@"nodes" toRelationship:@"nodes" withMapping:nodeMapping];
    
#pragma mark ESRKClusterHealth mapping
    RKObjectMapping *clusterHealthMapping = [RKObjectMapping mappingForClass:[ESRKClusterHealth class]];
     [clusterHealthMapping mapKeyPath:@"cluster_name" toAttribute:@"clusterName"];
     [clusterHealthMapping mapKeyPath:@"status" toAttribute:@"status"];
     
    
    
    RKObjectManager *manager =  [RKObjectManager objectManagerWithBaseURL:[NSURL URLWithString:baseURL]] ;
    
    manager.client.cachePolicy = RKRequestCachePolicyNone; 
    
    // we register this mapping against the object, but can't put it against a key path
    [manager.mappingProvider addObjectMapping:clusterStateMapping];
    [manager.mappingProvider addObjectMapping:clusterHealthMapping];
    [manager.mappingProvider addObjectMapping:nodeProcessInfoMapping];
    
}

- (IBAction)textFieldEndOnExit:(id)sender {
    
    
}
@end
