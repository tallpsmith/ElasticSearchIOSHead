//
//  StatusToColourTransformer.m
//  ElasticSearchRestkitTestHarness1
//
//  Created by Paul Smith on 28/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StatusToColourTransformer.h"

@implementation StatusToColourTransformer: NSValueTransformer

- (Class) transformedValueClass
{
    return [NSColor class];
}

- (id)transformedValue:(id)value
{
    NSString *statusName = value;
    
    if([statusName isEqualToString:@"green"]){
        return [NSColor greenColor];
    }else if([statusName isEqualToString:@"yellow"]){
        return [NSColor yellowColor];
    }if([statusName isEqualToString:@"red"]){
        return [NSColor redColor];
    }
    else {
        return nil;
    }
}

@end
