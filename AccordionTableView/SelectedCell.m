//
//  SelectedCell.m
//  AccordionTableView
//
//  Created by Yuichi Fujiki on 1/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SelectedCell.h"

@implementation SelectedCell

@synthesize containerView = _containerView;
@synthesize label1 = _label1;
@synthesize label2 = _label2;
@synthesize label3 = _label3;
@synthesize label4 = _label4;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder 
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        self.contentView.backgroundColor = [UIColor lightGrayColor];   
        self.containerView.backgroundColor = [UIColor whiteColor];        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    if(selected)
    {
        self.contentView.backgroundColor = [UIColor lightGrayColor];
    }
    else
    {
        self.contentView.backgroundColor = [UIColor cyanColor];
    }
}

@end
