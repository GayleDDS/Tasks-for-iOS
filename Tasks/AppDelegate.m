//
//  AppDelegate.m
//  Tasks
//
//  Copyright (c) 2013 Cultured Code. All rights reserved.
//

#import "AppDelegate.h"
#import "TaskList.h"
#import "Task.h"
#import "TasksTableViewController.h"

NSString * const kTitle     = @"title";
NSString * const kCompleted = @"completed";
NSString * const kChildren  = @"children";


@implementation AppDelegate

- (void)dealloc
{
    self.navigationController     = nil;
    self.window                   = nil;
    
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];

    TasksTableViewController *tasksTableViewController = [[[TasksTableViewController alloc] initWithTaskList:[self _generateTaskList]] autorelease];
    
    self.navigationController = [[[UINavigationController alloc] initWithRootViewController:tasksTableViewController] autorelease];
    self.navigationController.toolbarHidden = NO;
    
    [self.window setRootViewController:self.navigationController];

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}


- (TaskList *)_generateTaskList
{
    NSArray *taskDescriptions =
    @[
      @{ kTitle     : @"Buy milk",
         kCompleted : @NO },

      @{ kTitle     : @"Pay rent",
         kCompleted : @NO },

      @{ kTitle     : @"Change tires",
         kCompleted : @NO },

      @{ kTitle     : @"Sleep",
         kCompleted : @NO,
         kChildren  :
             @[
                 @{ kTitle     : @"Find a bed",
                    kCompleted : @NO
                    },

                 @{ kTitle     : @"Lie down",
                    kCompleted : @NO
                    },

                 @{ kTitle     : @"Close eyes",
                    kCompleted : @NO
                    },

                 @{ kTitle     : @"Wait",
                    kCompleted : @NO
                    }
                 ] },

      @{ kTitle     : @"Dance",
         kCompleted : @NO },

      ];

    return [self _taskListFromDescriptions:taskDescriptions];
}

- (TaskList *)_taskListFromDescriptions:(NSArray *)taskDescriptions
{
    TaskList *tasks = [[TaskList alloc] init];

    for (NSDictionary *taskDescription in taskDescriptions) {

        NSString *title = [taskDescription objectForKey:kTitle];
        BOOL completed = [[taskDescription objectForKey:kCompleted] boolValue];
        NSArray *subTaskDescriptions = [taskDescription objectForKey:kChildren];

        Task *task = [[[Task alloc] initWithTitle:title] autorelease];
        task.completed = completed;
        
        if (subTaskDescriptions.count) {
            TaskList * subTasks = [self _taskListFromDescriptions:subTaskDescriptions];
            [task addSubTasks:subTasks];
        }

        [tasks addTask:task];
    }
    
    return [tasks autorelease];
}


@end
