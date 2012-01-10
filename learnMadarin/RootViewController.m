//
//  RootViewController.m
//  learnMadarin
//
//  Created by Yuanfeng on 12-01-09.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"

@implementation RootViewController

- (void)parseTxtFile
{
    NSString *info = [NSString stringWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"resourceList" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
    NSArray *lines = [info componentsSeparatedByString:@"\n"];
    for (NSString *oneLine in lines) {
        if (![[oneLine substringToIndex:1] isEqualToString:@"#"]) {
            NSArray *subComponents = [oneLine componentsSeparatedByString:@","];
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[subComponents objectAtIndex:0], @"imgName", [subComponents objectAtIndex:1], @"chinese", nil];
            [_dictionary addObject:dict];
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _clickedBtnsArray  = [[NSMutableArray alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;
    
    _dictionary = [[NSMutableArray alloc] init];
    [self parseTxtFile];
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

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 44)] autorelease];
//    view.backgroundColor = [UIColor redColor];
    if (!_progressView) {
            _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    }
    _progressView.frame = CGRectMake(0, 0, view.frame.size.width-44, 20);
    _progressView.center = view.center;
    _progressView.progress = 0.5f;
    [view addSubview:_progressView];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"wallCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }

    // Configure the cell.
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    int startingPosX = 90;
    for (int i = 0; i<4; i++) {
        UIView *view = [[[UIView alloc] initWithFrame:CGRectMake(startingPosX+i*150, (CELL_HEIGHT-120)/2, 120, 120)] autorelease];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(10, 10, 100, 100);
        btn.layer.cornerRadius  = 10.0f;
//        btn.backgroundColor = [UIColor redColor];
        int n = rand()%2;
        if (n==0) {
            [btn setBackgroundImage:[UIImage imageNamed:@"kitten"] forState:UIControlStateNormal];
        } else
        {
            btn.layer.borderColor = [[UIColor blackColor] CGColor];
            btn.layer.borderWidth = 3.0f;
            UILabel *label = [[UILabel alloc] initWithFrame:btn.bounds];
            label.text = @"猫";
            label.textColor = [UIColor blackColor];
            label.textAlignment = UITextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:34];
            label.tag = 333;
            [btn addSubview:label];
        }
        
        [btn addTarget:self action:@selector(oneTitleClicked:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        [cell addSubview:view];
    }
    
    return cell;
}

- (void)oneTitleClicked:(UIButton*)btn
{
    btn.layer.borderColor = [[UIColor blackColor] CGColor];
    btn.layer.borderWidth = 3.0f;
    [_clickedBtnsArray addObject:btn];
    if ([_clickedBtnsArray count] == 2) {
        for (UIButton *btn in _clickedBtnsArray) {
            [UIView beginAnimations:nil context:NULL];
            [btn setBackgroundImage:nil forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor blueColor];
            [[btn viewWithTag:333] removeFromSuperview];
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:btn cache:YES];
            [UIView setAnimationDuration:0.5f];
            [UIView commitAnimations];
        }
        [_clickedBtnsArray removeAllObjects];
        _progressView.progress+=0.1f;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
	*/
}

- (void)dealloc
{
    [_progressView release];
    [_clickedBtnsArray release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

@end
