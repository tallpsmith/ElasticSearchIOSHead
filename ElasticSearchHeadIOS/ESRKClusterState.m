//
//  ESRKClusterState.m
//  ElasticSearchRestkitTestHarness1
//
//  Created by Paul Smith on 28/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ESRKClusterState.h"

@implementation ESRKClusterState


@synthesize clusterName;
@synthesize masterNode;
@synthesize nodes;

- (NSString *)description
{
    return [NSString stringWithFormat:@"{clusterName=%@, masterNode=%@, nodes=%@}", clusterName, masterNode, nodes, nil];
}

@end
