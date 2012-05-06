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
@synthesize hostName;
@synthesize processInfo;

- (NSString *)description
{
    return [NSString stringWithFormat:@"{nodeId=%@, nodeName=%@, transportAddress=%@, processInfo=%@}", nodeId, nodeName, transportAddress, processInfo ,nil];
}

@end

/*
 curl -XGET "http://localhost:9200/_cluster/nodes/O35p6F2-RwiaYgSfdNIbXg?&os=1
&pretty=1&os=1&process=1&jvm=1&thread_pool=1&network=1&transport=1&http=1"
{
  "ok" : true,
  "cluster_name" : "paul",
  "nodes" : {
    "O35p6F2-RwiaYgSfdNIbXg" : {
      "name" : "Coachwhip",
      "transport_address" : "inet[/192.168.0.12:9300]",
      "hostname" : "psmiths-MacBook-Pro.local",
      "http_address" : "inet[/192.168.0.12:9200]",
      "os" : {
        "refresh_interval" : 1000,
        "cpu" : {
          "vendor" : "Intel",
          "model" : "MacBookPro6,1",
          "mhz" : 2660,
          "total_cores" : 4,
          "total_sockets" : 4,
          "cores_per_socket" : 16,
          "cache_size" : "256b",
          "cache_size_in_bytes" : 256
        },
        "mem" : {
          "total" : "8gb",
          "total_in_bytes" : 8589934592
        },
        "swap" : {
          "total" : "512mb",
          "total_in_bytes" : 536870912
        }
      },
      "process" : {
        "refresh_interval" : 1000,
        "id" : 33316,
        "max_file_descriptors" : 10240
      },
      "jvm" : {
        "pid" : 33316,
        "version" : "1.6.0_31",
        "vm_name" : "Java HotSpot(TM) 64-Bit Server VM",
        "vm_version" : "20.6-b01-415",
        "vm_vendor" : "Apple Inc.",
        "start_time" : 1336281436444,
        "mem" : {
          "heap_init" : "256mb",
          "heap_init_in_bytes" : 268435456,
          "heap_max" : "1015.6mb",
          "heap_max_in_bytes" : 1065025536,
          "non_heap_init" : "23.1mb",
          "non_heap_init_in_bytes" : 24317952,
          "non_heap_max" : "130mb",
          "non_heap_max_in_bytes" : 136314880
        }
      },
      "thread_pool" : {
        "generic" : {
          "type" : "cached",
          "keep_alive" : "30s"
        },
        "index" : {
          "type" : "cached",
          "keep_alive" : "5m"
        },
        "get" : {
          "type" : "cached",
          "keep_alive" : "5m"
        },
        "cache" : {
          "type" : "scaling",
          "min" : 1,
          "max" : 4,
          "keep_alive" : "5m"
        },
        "snapshot" : {
          "type" : "scaling",
          "min" : 1,
          "max" : 5,
          "keep_alive" : "5m"
        },
        "merge" : {
          "type" : "scaling",
          "min" : 1,
          "max" : 20,
          "keep_alive" : "5m"
        },
        "bulk" : {
          "type" : "cached",
          "keep_alive" : "5m"
        },
        "flush" : {
          "type" : "scaling",
          "min" : 1,
          "max" : 10,
          "keep_alive" : "5m"
        },
        "search" : {
          "type" : "cached",
          "keep_alive" : "5m"
        },
        "percolate" : {
          "type" : "cached",
          "keep_alive" : "5m"
        },
        "management" : {
          "type" : "scaling",
          "min" : 1,
          "max" : 5,
          "keep_alive" : "5m"
        },
        "refresh" : {
          "type" : "cached",
          "keep_alive" : "1m"
        }
      },
      "network" : {
        "refresh_interval" : 5000,
        "primary_interface" : {
          "address" : "192.168.0.12",
          "name" : "en1",
          "mac_address" : "58:B0:35:7C:1A:18"
        }
      },
      "transport" : {
        "bound_address" : "inet[/0.0.0.0:9300]",
        "publish_address" : "inet[/192.168.0.12:9300]"
      },
      "http" : {
        "bound_address" : "inet[/0.0.0.0:9200]",
        "publish_address" : "inet[/192.168.0.12:9200]"
      }
    }
  }
}
 */
