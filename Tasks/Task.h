//
//  Task.h
//  Tasks
//
//  Copyright (c) 2013 Cultured Code. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TaskList;

@interface Task : NSObject

@property(nonatomic,copy)               NSString       *title;
@property(nonatomic,copy)               NSDate         *modifiedDate;
@property(nonatomic,getter=isCompleted) BOOL            completed;

- (Task *)initWithTitle:(NSString *)name;

-(NSString *)modifiedString;
- (void)toggleCompleted;

// SubTasks
- (BOOL)hasSubTasks;
- (TaskList *)subTasks;
- (void)addSubTasks:(TaskList *)aTaskList;

@end




