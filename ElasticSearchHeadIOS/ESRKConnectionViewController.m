//
//  ESRKViewController.m
//  ElasticSearchHeadIOS
//
//  Created by Paul Smith on 3/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ESRKConnectionViewController.h"
#import "ESRKServerViewController.h"

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
    
    NSString *baseUrl = [NSString stringWithFormat:@"http%@://%@:%@/",sslSuffix, [self.host text], [self.port text]];
    
    RKClient *client = [RKClient clientWithBaseURLString:baseUrl];
    
    [RKClient setSharedClient:client];
    
}

- (IBAction)textFieldEndOnExit:(id)sender {
    
    
}
@end
