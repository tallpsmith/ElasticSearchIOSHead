//
//  ESRKNode.h
//  ElasticSearchRestkitTestHarness1
//
//  Created by Paul Smith on 28/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ESRKNode : NSObject {
    NSString *nodeId;
    NSString *nodeName;
    NSString *transportAddress;
}

@property (strong, nonatomic) NSString *nodeId;
@property (strong, nonatomic) NSString *nodeName;
@property (strong, nonatomic) NSString *transportAddress;

@end
