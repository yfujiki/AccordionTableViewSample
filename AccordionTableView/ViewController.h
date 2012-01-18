//
//  ViewController.h
//  AccordionTableView
//
//  Created by Yuichi Fujiki on 1/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) int selectedIndex;
@property (nonatomic, retain) NSMutableArray * data;

@end
