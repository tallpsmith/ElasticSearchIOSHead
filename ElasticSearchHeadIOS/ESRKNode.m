//
//  ESRKNode.m
//  ElasticSearchRestkitTestHarness1
//
//  Created by Paul Smith on 28/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ESRKNode.h"

@implementation ESRKNode

@synthesize nodeId;
@synthesize nodeName;
@synthesize transportAddress;

- (NSString *)description
{
    return [NSString stringWithFormat:@"{nodeId=%@, nodeName=%@, transportAddress=%@}", nodeId, nodeName, transportAddress, nil];
}

@end
