//
//  DIActionSheet.m
//  DIActionSheet
//
//  Created by Simon Blommegård on 2010-09-05.
//  Copyright 2010 Doubleint. All rights reserved.
//

#import "DIActionSheet.h"

@implementation DIActionSheet

@synthesize actionSheet, sendActionAfterDismiss;

- (id)initWithTitleFormat:(NSString *)format args:(va_list)args {
	self = [super init];
	NSString *title = format ? [[[NSString alloc] initWithFormat:format arguments:args] autorelease] : nil;
	actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
	actions = [[NSMutableArray alloc] init];
	return self;
}

- (void)dealloc {
	[actionSheet release];
	[actions release];
	[super dealloc];
}

+ (id)actionSheetWithTitleFormat:(NSString *)title, ... {
	va_list list;
	va_start(list, title);
	DIActionSheet *actionSheet = [[[self alloc] initWithTitleFormat:title args:list] autorelease];
	va_end(list);
	
	return actionSheet;
}

- (id)initWithTitleFormat:(NSString *)title, ... {
	va_list list;
	va_start(list, title);
	self = [self initWithTitleFormat:title args:list];
	va_end(list);
	
	return self;
}

- (void)addButtonWithTitle:(NSString*)title type:(DIActionSheetButtonType)type action:(void(^)())action {
	if(!action) action = ^{};
	[actionSheet addButtonWithTitle:title];
	[actions addObject:[[action copy] autorelease]];
	
	switch (type) {
		case DIActionSheetButtonTypeNormal:
			break;
		case DIActionSheetButtonTypeCancel:
			[actionSheet setCancelButtonIndex:([actions count] - 1)];
			break;
		case DIActionSheetButtonTypeDestructive:
			[actionSheet setDestructiveButtonIndex:([actions count] - 1)];
			break;
	}
}

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated {
	[actionSheet dismissWithClickedButtonIndex:buttonIndex animated:animated];
}

- (void)showFromBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated {
	[actionSheet showFromBarButtonItem:item animated:animated];
	[self retain];
}

- (void)showFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated {
	[actionSheet showFromRect:rect inView:view animated:animated];
	[self retain];
}
- (void)showFromTabBar:(UITabBar *)view {
	[actionSheet showFromTabBar:view];
	[self retain];
}
- (void)showFromToolbar:(UIToolbar *)view {
	[actionSheet showFromToolbar:view];
	[self retain];
}
- (void)showInView:(UIView *)view {
	[actionSheet showInView:view];
	[self retain];
}

#pragma mark -
#pragma mark UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (!sendActionAfterDismiss) {
		void(^handler)() = [actions objectAtIndex:buttonIndex];
		handler();
	}
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
	if (sendActionAfterDismiss) {
		void(^handler)() = [actions objectAtIndex:buttonIndex];
		handler();
	}
	[self release];
}

@end
