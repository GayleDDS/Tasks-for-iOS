//
//  TaskList.m
//  Tasks
//
//  Created by Gayle Dunham on 6/22/13.
//  Copyright (c) 2013 Cultured Code. All rights reserved.
//

#import "TaskList.h"
#import "Task.h"

@interface TaskList ()

@property(nonatomic,retain)  NSMutableArray* tasks;

@end

@implementation TaskList

#pragma mark - NSObject Life Cycle

-(void)dealloc
{
    self.tasks = nil;
    
    [super dealloc];
}

#pragma mark - Overridden Getters and Setters

- (NSMutableArray *)tasks
{
    if (! _tasks) {
        _tasks = [[NSMutableArray alloc] init];
    }
    
    return _tasks;
}

#pragma mark - Public Methods

- (BOOL)hasTasks
{
    return [self.tasks count] ? YES : NO;
}

- (NSInteger)count
{
    return [self.tasks count];
}

- (Task *)objectAtIndex:(NSInteger)index
{
    return [self.tasks objectAtIndex:index];
}

- (NSInteger)indexOfObject:(Task *)aTask
{
    return [self.tasks indexOfObject:aTask];
}

- (NSArray *)allTasks
{
    return [[self.tasks copy] autorelease];
}

- (void)addTaskList:(TaskList *)aTaskList
{
    [self.tasks addObjectsFromArray:aTaskList.tasks];
}

- (void)addTask:(Task *)aTask
{
    [self.tasks addObject:aTask];
}


- (void)removeTask:(Task *)aTask
{
    [self.tasks removeObject:aTask];
}

- (void)moveTaskAtIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex
{
    Task *task = [[self.tasks objectAtIndex:fromIndex] retain];
    [self.tasks removeObjectAtIndex:fromIndex];
    [self.tasks insertObject:task atIndex:toIndex];
    [task release];
}

- (void)markAllTasksComplete
{
    for (Task *task in self.tasks) {
        if (! task.isCompleted) {
            task.completed = YES;
        }
    }
}

- (void)sort
{    
    [self.tasks sortUsingComparator:^(id task1, id task2) {
        
        return [[task1 title] compare:[task2 title] options:NSCaseInsensitiveSearch];
    }];
}

@end
