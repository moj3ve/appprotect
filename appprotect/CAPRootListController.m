// (c) Castyte 2019
// Licensed Mozilla Public License Version 2.0
// Full license available in LICENSE file

#include "CAPRootListController.h"
#include "spawn.h"
#include "signal.h"
#import <LocalAuthentication/LocalAuthentication.h>

@implementation CAPRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}

-(void)respring{
	NSString *reason = @"Apply AppProtect changes";
	LAPolicy policy = LAPolicyDeviceOwnerAuthentication; 
	LAContext *context = [[LAContext alloc] init];  
    NSError *error = nil; 
    if ([context canEvaluatePolicy:policy error:&error]) {  
        [context evaluatePolicy:policy
                localizedReason:reason
                        reply:^(BOOL success, NSError *error) {
                            if (success) {                                 
                                    dispatch_sync(dispatch_get_main_queue(), ^{
                                        pid_t respringID;
										char *argv[] = {"/usr/bin/killall", "backboardd", NULL};
										posix_spawn(&respringID, argv[0], NULL, NULL, argv, NULL);
										waitpid(respringID, NULL, WEXITED);
                                    });
                            }
        }];
    }
}


-(void)twitter{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/castyte"]];
}

@end