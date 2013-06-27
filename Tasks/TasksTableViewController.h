//
//  TasksTableViewController.h
//  Tasks
//
//  Copyright (c) 2013 Cultured Code. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TaskList;

@interface TasksTableViewController : UITableViewController

- (id)initWithTaskList:(TaskList *)tasks;

@end
