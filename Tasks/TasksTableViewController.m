//
//  TasksTableViewController.m
//  Tasks
//
//  Copyright (c) 2013 Cultured Code. All rights reserved.
//

#import "TasksTableViewController.h"
#import "TaskList.h"
#import "Task.h"
#import "TaskCell.h"

@interface TasksTableViewController ()

@property (nonatomic, retain) TaskList *tasks;

@end

@implementation TasksTableViewController

- (id)initWithTaskList:(TaskList *)tasks
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self != nil) {
        self.title = @"Tasks";
        self.tasks = tasks;
        self.toolbarItems = @[
                              [[[UIBarButtonItem alloc] initWithTitle:@"complete all"
                                                                style:UIBarButtonItemStyleBordered
                                                               target:self
                                                               action:@selector(completeAll)] autorelease],

                              [[[UIBarButtonItem alloc] initWithTitle:@"sort by name"
                                                                style:UIBarButtonItemStyleBordered
                                                               target:self
                                                               action:@selector(sort)] autorelease]
                              ];

        [self.tableView registerClass:[TaskCell class] forCellReuseIdentifier:@"TaskCell"];

        self.navigationItem.rightBarButtonItem = self.editButtonItem;

        
    }
    return self;
}

- (void)dealloc
{
    self.tasks = nil;
    
    [super dealloc];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tasks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TaskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCell" forIndexPath:indexPath];

    Task *task = [self.tasks objectAtIndex:[indexPath row]];
    
    cell.textLabel.text = task.title;
    cell.completed      = task.completed;
    cell.accessoryType  = task.hasSubTasks ? UITableViewCellAccessoryDetailDisclosureButton :
                                             UITableViewCellAccessoryNone;

    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id cell = [tableView cellForRowAtIndexPath:indexPath];
    Task *task = [self.tasks objectAtIndex:[indexPath row]];

    [task toggleCompleted];
    [cell toggleCompleted];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    Task *task = [self.tasks objectAtIndex:[indexPath row]];

    TasksTableViewController *tvc = [[TasksTableViewController alloc] initWithTaskList:[task subTasks]];
    tvc.title = task.title;

    [self.navigationController pushViewController:tvc animated:YES];
    [tvc release];
}

- (void)completeAll
{
    [self.tasks markAllTasksComplete];
    
    [self.tableView reloadData];
}

- (void)sort
{
    NSArray *oldTaskList = [self.tasks allTasks];
    
    [self.tasks sort];
    
    [self.tableView beginUpdates];

    for (Task *aTask in [self.tasks allTasks]) {
        NSInteger *oldRow = [oldTaskList indexOfObject:aTask];
        NSInteger *newRow = [self.tasks  indexOfObject:aTask];
        
        NSIndexPath *oldPath = [NSIndexPath indexPathForRow:oldRow inSection:0];
        NSIndexPath *newPath = [NSIndexPath indexPathForRow:newRow inSection:0];

        [self.tableView moveRowAtIndexPath:oldPath toIndexPath:newPath];
    }

    [self.tableView endUpdates];
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    [self.tasks moveTaskAtIndex:fromIndexPath.row toIndex:toIndexPath.row];
}


@end
