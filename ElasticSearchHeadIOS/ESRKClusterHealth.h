//
//  ESRKClusterHealth.h
//  ElasticSearchRestkitTestHarness1
//
//  Created by Paul Smith on 25/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ESRKClusterHealth : NSObject{
    /*    curl -XGET http://localhost:9200/_cluster/health?pretty=true
     {
     "cluster_name" : "paul",
     "status" : "yellow",
     "timed_out" : false,
     "number_of_nodes" : 1,
     "number_of_data_nodes" : 1,
     "active_primary_shards" : 5,
     "active_shards" : 5,
     "relocating_shards" : 0,
     "initializing_shards" : 0,
     "unassigned_shards" : 5 */
    
    NSString *clusterName;
    NSString *status;
}

@property (nonatomic, strong) NSString *clusterName;
@property (nonatomic, strong) NSString *status;
@end
