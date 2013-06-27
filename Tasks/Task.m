//
//  Task.m
//  Tasks
//
//  Copyright (c) 2013 Cultured Code. All rights reserved.
//

#import "Task.h"
#import "TaskList.h"

#define NOW [NSDate date]

@interface Task ()

@property(nonatomic,retain)  TaskList* children;
@property(nonatomic,assign)  id        parent;

@end

@implementation Task

#pragma mark - NSObject Life Cycle

- (Task *)initWithTitle:(NSString*)name
{
    self = [super init];
    
    if (self != nil) {
        self.title = name;
        self.modifiedDate = NOW;
    }
    
    return self;
}

-(void)dealloc
{
    self.title        = nil;
    self.modifiedDate = nil;
    self.children     = nil;
    self.parent       = nil;
    
    [super dealloc];
}

#pragma mark - Overridden Getters and Setters

- (void)setTitle:(NSString *)newTitle
{
    _title = [newTitle retain];
    self.modifiedDate = NOW;
}

- (void)setCompleted:(BOOL)completed
{
    _completed = completed;
    
    for (Task *aTask in [self.children allTasks]) {
        aTask.completed = completed;
    }
}

- (TaskList *)children
{
    if (!_children) {
        _children = [[TaskList alloc] init];
    }
    return _children;
}

#pragma mark - Public Methods

-(NSString *)modifiedString;
{
    NSString *dateString;
    
    if (self.modifiedDate) {
        dateString = [NSDateFormatter localizedStringFromDate:self.modifiedDate
                                                    dateStyle:NSDateFormatterFullStyle
                                                    timeStyle:NSDateFormatterFullStyle];
    } else {
        dateString = @"modified date not set.";
    }
    
    return dateString;
}

- (void)toggleCompleted;
{
    self.completed = ! self.completed;
}

#pragma mark - Public Methods managing SubTasks

- (BOOL)hasSubTasks
{
    return [self.children hasTasks];
}

- (TaskList *)subTasks
{
    return self.children;
}

- (void)addSubTasks:(TaskList*)aTaskList
{
    self.modifiedDate = NOW;
    for (Task *aTask in [aTaskList allTasks]) {
        aTask.parent = self;
    }
    [self.children addTaskList:aTaskList];
}

@end







