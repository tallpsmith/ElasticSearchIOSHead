//
//  ESRKViewController.m
//  ElasticSearchHeadIOS
//
//  Created by Paul Smith on 3/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ESRKViewController.h"

@interface ESRKViewController ()
@property (weak, nonatomic) IBOutlet UITextField *host;
@property (weak, nonatomic) IBOutlet UITextField *port;
@property (weak, nonatomic) IBOutlet UISwitch *useSSL;

@end

@implementation ESRKViewController
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
    
    NSLog(@"Connecting to %@:%@ using SSL %d", [self.host text], [self.port text], shouldUseSSL);
}

- (IBAction)textFieldEndOnExit:(id)sender {
    
    
}
@end
