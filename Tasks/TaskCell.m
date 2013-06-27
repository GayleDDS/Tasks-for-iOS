//
//  TaskCell.m
//  Tasks
//
//  Copyright (c) 2013 Cultured Code. All rights reserved.
//

#import "TaskCell.h"

#define CHECKMARKVIEW 100

@implementation TaskCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    self.textLabel.font = [UIFont fontWithName:@"AmericanTypewriter" size:16];
    [self setTextColorAndImage];

    return self;
}

- (void)setTextColorAndImage
{
    if (self.isCompleted) {
        self.textLabel.textColor = [UIColor lightGrayColor];
        self.imageView.image = [UIImage imageNamed:@"Checkbox-Checked.png"];
    } else {
        self.textLabel.textColor = [UIColor blackColor];
        self.imageView.image = [UIImage imageNamed:@"Checkbox-Empty.png"];
    }
}

#pragma mark - Overridden Getters and Setters

- (void)setCompleted:(BOOL)completed
{
    _completed = completed;
    [self setTextColorAndImage];
}

#pragma mark - Public Methods

- (void)toggleCompleted
{
    _completed = !_completed;
    [self setTextColorAndImage];
}

@end