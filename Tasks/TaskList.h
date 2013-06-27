//
//  TaskList.h
//  Tasks
//
//  Created by Gayle Dunham on 6/22/13.
//  Copyright (c) 2013 Cultured Code. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Task;

@interface TaskList : NSObject

- (BOOL)hasTasks;
- (NSInteger)count;
- (Task *)objectAtIndex:(NSInteger)index;
- (NSInteger)indexOfObject:(Task *)aTask;

- (NSArray *)allTasks;
- (void)addTaskList:(TaskList *)aTaskList;
- (void)addTask:(Task *)aTask;
- (void)removeTask:(Task *)aTask;
- (void)moveTaskAtIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;

- (void)markAllTasksComplete;
- (void)sort;

@end
