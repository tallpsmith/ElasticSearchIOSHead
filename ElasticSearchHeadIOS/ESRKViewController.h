//
//  ESRKViewController.h
//  ElasticSearchHeadIOS
//
//  Created by Paul Smith on 3/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESRKViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *hostName;
- (IBAction)textFieldEndOnExit:(id)sender;

@end
