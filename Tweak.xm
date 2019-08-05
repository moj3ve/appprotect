// (c) Castyte 2019
// Licensed Mozilla Public License Version 2.0
// Full license available in LICENSE file

#import <LocalAuthentication/LocalAuthentication.h>

LAPolicy policy = LAPolicyDeviceOwnerAuthentication; 
NSString *reason = @"AppProtect";
NSDictionary* settings;

%hook SBApplication

-(BOOL)icon:(id)arg1 launchFromLocation:(long long)arg2 context:(id)arg3 activationSettings:(id)arg4 actions:(id)arg5{
    NSString *icon = [NSString stringWithFormat:@"%@",arg1];
    NSString *ubid = [icon componentsSeparatedByString:@"bundleID: "][1];
    NSString *key = [ubid substringToIndex:[ubid length] - 1];
    if(![[settings valueForKey:key] boolValue]){
        return %orig;
    }
	LAContext *context = [[LAContext alloc] init];  
    NSError *error = nil; 
    if ([context canEvaluatePolicy:policy error:&error]) {  
        [context evaluatePolicy:policy
                localizedReason:reason
                        reply:^(BOOL success, NSError *error) {
                            if (success) {                                 
                                    dispatch_sync(dispatch_get_main_queue(), ^{
                                            %orig;
                                    });
                            }
        }];
    }
    return YES;
}

%end

%hook SFSearchResult

-(NSString *)applicationBundleIdentifier{
    if([settings valueForKey:@"spotlightEnabled"]!=nil && ![[settings valueForKey:@"spotlightEnabled"] boolValue]) return %orig;
    NSString *key = %orig;
    if([[settings valueForKey:key] boolValue]){
        return nil;
    }
    return %orig;
}

%end


%ctor{
    settings = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.castyte.appprotect.plist"];
}