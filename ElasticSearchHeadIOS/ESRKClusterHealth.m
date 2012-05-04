//
//  ESRKClusterHealth.m
//  ElasticSearchRestkitTestHarness1
//
//  Created by Paul Smith on 25/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ESRKClusterHealth.h"

@implementation ESRKClusterHealth 

@synthesize clusterName;
@synthesize status;


- (id) init
{
    self = [super init];
    if(self){
        self.clusterName= @"Unknown Cluster Name";
        self.status = @"Unknown Status";
    }
    return self;
    
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"clusterName=%@, status=%@", clusterName, status, nil];
}

@end
