//
//  ActionRequestHandler.m
//  blocker
//
//  Created by Brian Kennish on 8/19/15.
//  Copyright © 2015 Rocketship. All rights reserved.
//

#import "ActionRequestHandler.h"
#import "Constants.h"

#define RULESET_COMPILE_COUNT_KEY @"RulesetCompileCount"
#define BLOCKER_RULESET_FILENAME @"blockerList"
#define NOOP_RULESET_FILENAME @"noopList"
#define RULESET_FILE_EXTENSION @"json"

@interface ActionRequestHandler ()

@property (nonatomic) NSUserDefaults *preferences;

@end

@implementation ActionRequestHandler

- (NSUserDefaults *)preferences {
    if (!_preferences) {
        _preferences = [[NSUserDefaults alloc] initWithSuiteName:APP_GROUP_ID];
        NSURL *preferencesFileURL = [[NSBundle mainBundle] URLForResource:DEFAULT_PREFERENCES_FILENAME
                                                            withExtension:PREFERENCES_FILE_EXTENSION];
        
        [_preferences registerDefaults:[NSDictionary dictionaryWithContentsOfURL:preferencesFileURL]];
    }
    
    return _preferences;
}

- (void)beginRequestWithExtensionContext:(NSExtensionContext *)context {
    NSUserDefaults *preferences = self.preferences;
    if (![preferences boolForKey:BLOCKER_PERMISSION_KEY]) {
        [preferences setBool:YES forKey:BLOCKER_PERMISSION_KEY];
    }
    
  
    NSURL *blockerListURL;
    if ([preferences boolForKey:BLOCKING_STATUS_KEY]) {
        blockerListURL = [[NSBundle mainBundle] URLForResource:BLOCKER_RULESET_FILENAME withExtension:RULESET_FILE_EXTENSION];
    } else {
        blockerListURL = [[NSBundle mainBundle] URLForResource:NOOP_RULESET_FILENAME withExtension:RULESET_FILE_EXTENSION];
    }
    
    NSItemProvider *attachment = [[NSItemProvider alloc] initWithContentsOfURL:blockerListURL];
    
    NSExtensionItem *item = [[NSExtensionItem alloc] init];
    item.attachments = @[attachment];
    
    NSInteger rulesetCompileCount = [preferences integerForKey:RULESET_COMPILE_COUNT_KEY];
    [preferences setInteger:++rulesetCompileCount forKey:RULESET_COMPILE_COUNT_KEY];
    
    [context completeRequestReturningItems:@[item] completionHandler:nil];
}

@end
