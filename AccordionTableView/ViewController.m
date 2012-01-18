//
//  ViewController.m
//  AccordionTableView
//
//  Created by Yuichi Fujiki on 1/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "SelectedCell.h"
#import "RegularCell.h"

#define kNumberOfData 10

@implementation ViewController

@synthesize selectedIndex = _selectedIndex;
@synthesize data = _data;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    self.selectedIndex = -1;
    
    self.data = [[NSMutableArray alloc] initWithCapacity:kNumberOfData];
    for(int i=0; i<kNumberOfData; i++)
    {
        NSArray * innerData = [NSArray arrayWithObjects:
                               [NSString stringWithFormat:@"Data1 of %d", i],
                               [NSString stringWithFormat:@"Data2 of %d", i],
                               [NSString stringWithFormat:@"Data3 of %d", i],
                               [NSString stringWithFormat:@"Data4 of %d", i],
                               nil];
        [self.data addObject:innerData];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

#pragma mark - UITableViewDataSource

-(int) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.data count] + 1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == self.selectedIndex)
        return 300 + 44;
    else
        return 44;
}

#pragma mark - UITableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = nil;
    switch (indexPath.row) {
        case 0:
        {   
            cell = [tableView dequeueReusableCellWithIdentifier:@"Header"];
        }
            break;
        default:
        {
            NSArray * innerData = [self.data objectAtIndex:indexPath.row - 1];
            if(indexPath.row == self.selectedIndex)
            {
                SelectedCell * tmpCell = (SelectedCell *)[tableView dequeueReusableCellWithIdentifier:@"Selected"];
                [tmpCell.label1 setText:[NSString stringWithFormat:@"%@", [innerData objectAtIndex:0]]];
                [tmpCell.label2 setText:[NSString stringWithFormat:@"%@", [innerData objectAtIndex:1]]];
                [tmpCell.label3 setText:[NSString stringWithFormat:@"%@", [innerData objectAtIndex:2]]];
                [tmpCell.label4 setText:[NSString stringWithFormat:@"%@", [innerData objectAtIndex:3]]];                
                cell = tmpCell;
            }
            else
            {
                RegularCell * tmpCell = (RegularCell *)[tableView dequeueReusableCellWithIdentifier:@"Regular"];
                [tmpCell.label1 setText:[NSString stringWithFormat:@"%@", [innerData objectAtIndex:0]]];
                [tmpCell.label2 setText:[NSString stringWithFormat:@"%@", [innerData objectAtIndex:1]]];
                [tmpCell.label3 setText:[NSString stringWithFormat:@"%@", [innerData objectAtIndex:2]]];
                [tmpCell.label4 setText:[NSString stringWithFormat:@"%@", [innerData objectAtIndex:3]]];                
                cell = tmpCell;
            }
        }
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0)
        return;
    
    if(indexPath.row != self.selectedIndex && self.selectedIndex > 0)
    {
        // Selected different row while there is another selected row
        
        int oldIndex = self.selectedIndex;
        self.selectedIndex = indexPath.row;
        
        NSArray * innerData = [self.data objectAtIndex:oldIndex - 1];
        
        [self.data removeObjectAtIndex:oldIndex - 1];
        
        NSIndexPath * deselectedIndexPath = [NSIndexPath indexPathForRow:oldIndex inSection:0];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:deselectedIndexPath] withRowAnimation:UITableViewRowAnimationNone];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.0 * NSEC_PER_SEC), 
                       dispatch_get_main_queue(),
                       ^{
                           [self.data insertObject:innerData atIndex:deselectedIndexPath.row - 1];
                           [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:deselectedIndexPath] withRowAnimation:UITableViewRowAnimationTop];
                           [tableView reloadData];       
                           
                           NSArray * innerData = [self.data objectAtIndex:indexPath.row - 1];    
                           [self.data removeObjectAtIndex:indexPath.row - 1];
                           [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];        
                           dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC),
                                          dispatch_get_main_queue(),
                                          ^{
                                              [self.data insertObject:innerData atIndex:indexPath.row - 1];
                                              [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
                                              [tableView reloadData];                               
                                          });
                       });        
    }
    else
    {        
        if(indexPath.row == self.selectedIndex) // selected active row -> close
            self.selectedIndex = -1;
        else                                    // selected inactive row -> open
            self.selectedIndex = indexPath.row;
        
        NSArray * innerData = [self.data objectAtIndex:indexPath.row - 1];    
        [self.data removeObjectAtIndex:indexPath.row - 1];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.2 * NSEC_PER_SEC),
                       dispatch_get_main_queue(),
                       ^{
                           [self.data insertObject:innerData atIndex:indexPath.row - 1];
                           [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
                           [tableView reloadData];                               
                       });
    }    
}

@end
