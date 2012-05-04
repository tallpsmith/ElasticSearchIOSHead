//
//  ESRKClusterState.h
//  ElasticSearchRestkitTestHarness1
//
//  Created by Paul Smith on 28/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ESRKClusterState : NSObject{
    NSString *clusterName;
    NSString *masterNode;
    NSMutableArray *nodes;
}

@property (strong, nonatomic) NSString *clusterName;
@property (strong, nonatomic) NSString *masterNode;
@property (strong, nonatomic) NSMutableArray *nodes;




@end
