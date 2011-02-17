//
//  DIActionSheet.h
//  DIActionSheet
//
//  Created by Simon Blommegård on 2010-09-05.
//  Copyright 2010 Doubleint. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
	DIActionSheetButtonTypeNormal,
	DIActionSheetButtonTypeCancel,
	DIActionSheetButtonTypeDestructive,
} DIActionSheetButtonType;

@interface DIActionSheet : NSObject <UIActionSheetDelegate> {
	UIActionSheet *actionSheet;
	
	BOOL sendActionAfterDismiss;
	
	NSMutableArray *actions;
}

@property(readonly) UIActionSheet *actionSheet;
@property() BOOL sendActionAfterDismiss;

#pragma mark -

+ (id)actionSheetWithTitleFormat:(NSString *)title, ...;

#pragma mark -

- (id)initWithTitleFormat:(NSString *)title, ...;

#pragma mark -

- (void)addButtonWithTitle:(NSString*)title type:(DIActionSheetButtonType)type action:(void(^)())action;

#pragma mark -

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated;

#pragma mark -

- (void)showFromBarButtonItem:(UIBarButtonItem *)item animated:(BOOL)animated;
- (void)showFromRect:(CGRect)rect inView:(UIView *)view animated:(BOOL)animated;
- (void)showFromTabBar:(UITabBar *)view;
- (void)showFromToolbar:(UIToolbar *)view;
- (void)showInView:(UIView *)view;

@end
