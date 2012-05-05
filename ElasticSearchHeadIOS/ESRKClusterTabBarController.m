//
//  ESRKClusterTabBarController.m
//  ElasticSearchHeadIOS
//
//  Created by Paul Smith on 5/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ESRKClusterTabBarController.h"
#import "RestKit/RestKit.h"

@interface ESRKClusterTabBarController ()

@end

@implementation ESRKClusterTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)shutdownCluster:(id)sender {
    
    UIActionSheet *shutdownSheet = [[UIActionSheet alloc] 
                                    initWithTitle:@"Shutdown Cluster" 
                                    delegate:self 
                                    cancelButtonTitle:@"Woh, hang on... no!" 
                                    destructiveButtonTitle:@"Nuke The Site from Orbit..."
                                    otherButtonTitles:nil];
    
    
    [shutdownSheet showFromTabBar:self.tabBar];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(actionSheet.destructiveButtonIndex == buttonIndex){
        NSLog(@"Wanted to shutdown the cluster");
        [self shutdown];
    } else {
        NSLog(@"Shutdown aborted");
    }
    
}

- (void) shutdown
{
    [[RKObjectManager sharedManager].client 
            post:@"_shutdown" 
            params:nil 
            delegate:nil];
}
@end
