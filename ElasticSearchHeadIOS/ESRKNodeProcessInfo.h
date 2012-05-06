//
//  ESRKNodeProcessInfo.h
//  ElasticSearchHeadIOS
//
//  Created by Paul Smith on 6/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ESRKNodeProcessInfo : NSObject{
    NSString *processId;
    NSString *maxFileDescriptors;
    NSString *refreshInterval;
}

@property (strong, nonatomic) NSString *processId;
@property (strong, nonatomic) NSString *maxFileDescriptors;
@property (strong, nonatomic) NSString *refreshInterval;

@end
