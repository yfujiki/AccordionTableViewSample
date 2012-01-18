//
//  SelectedCell.h
//  AccordionTableView
//
//  Created by Yuichi Fujiki on 1/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectedCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UIView * containerView;

@property (nonatomic, retain) IBOutlet UILabel * label1;
@property (nonatomic, retain) IBOutlet UILabel * label2;
@property (nonatomic, retain) IBOutlet UILabel * label3;
@property (nonatomic, retain) IBOutlet UILabel * label4;

@end
