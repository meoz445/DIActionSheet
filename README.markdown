# DIActionSheet

Create an UIActionSheet without implementing the delegate, let blocks do its magic!

## Usage

    NSString *URLString = @"http://apple.com";

    // Create the sheet with a title format:
    DIActionSheet *sheet = [DIActionSheet actionSheetWithTitleFormat:@"Open: %@", URLString];
	
    // Add buttons with action using blocks:
    [sheet addButtonWithTitle:@"Open URL" type:DIActionSheetButtonTypeNormal action:^() {
      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLString]];
    }];
	
    [sheet addButtonWithTitle:@"Cancel" type:DIActionSheetButtonTypeCancel action:^() {
		  // Add something here if you like to have a custom cancel-action, for example:
			// [tableView deselectRowAtIndexPath:indexPath animated:YES];
		}];

    // Show from the tab bar:
    [sheet showFromTabBar:self.tabBarController.tabBar];
