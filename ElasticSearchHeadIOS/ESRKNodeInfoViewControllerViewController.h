//
//  ESRKNodeInfoViewControllerViewController.h
//  ElasticSearchHeadIOS
//
//  Created by Paul Smith on 6/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESRKNode.h"
#import "ESRKNodeProcessInfo.h"

@interface ESRKNodeInfoViewControllerViewController : UITableViewController{
    ESRKNode *node;
}

@property ESRKNode *node;


@end
