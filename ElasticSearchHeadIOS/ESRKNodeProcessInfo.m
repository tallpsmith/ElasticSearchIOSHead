//
//  ESRKNodeProcessInfo.m
//  ElasticSearchHeadIOS
//
//  Created by Paul Smith on 6/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ESRKNodeProcessInfo.h"

@implementation ESRKNodeProcessInfo 

@synthesize processId;
@synthesize maxFileDescriptors;
@synthesize refreshInterval;

- (NSString *)description
{
    return [NSString stringWithFormat:@"{processId=%@, maxFileDescriptors=%@, refreshInterval=%@}", processId, maxFileDescriptors, refreshInterval ,nil];
}
@end

/*
       "process" : {
        "refresh_interval" : 1000,
        "id" : 33316,
        "max_file_descriptors" : 10240
      }
 */
