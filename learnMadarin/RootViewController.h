//
//  RootViewController.h
//  learnMadarin
//
//  Created by Yuanfeng on 12-01-09.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define CELL_HEIGHT 126

@interface RootViewController : UITableViewController {
    NSMutableArray *_clickedBtnsArray;
    
    UIProgressView *_progressView;
    
    NSMutableArray *_dictionary;
}


@end
