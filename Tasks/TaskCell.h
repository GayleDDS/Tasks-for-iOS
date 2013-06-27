//
//  TaskCell.h
//  Tasks
//
//  Copyright (c) 2013 Cultured Code. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Task.h"

@interface TaskCell : UITableViewCell

@property(nonatomic,getter=isCompleted) BOOL completed;

- (void)toggleCompleted;

@end
