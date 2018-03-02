#import "FirebaseCrashlyticsPlugin.h"

#import <Cordova/CDVAvailability.h>

@implementation FirebaseCrashlyticsPlugin

- (void)pluginInitialize {
    if(![FIRApp defaultApp]) {
        [FIRApp configure];
    }
}

- (void)crash:(CDVInvokedUrlCommand *)command {
    [[Crashlytics sharedInstance] crash];
}

- (void)logPriority:(CDVInvokedUrlCommand *)command {
    NSString *message = [command argumentAtIndex:2];
    CLSLog(@"%@", message);
}

- (void)logException:(CDVInvokedUrlCommand *)command {
    NSString *message = [command argumentAtIndex:0];

    NSDictionary *userInfo = @{
                               NSLocalizedDescriptionKey: NSLocalizedString(@"Unexpected excerption", nil),
                               NSLocalizedFailureReasonErrorKey: NSLocalizedString(message, nil),
                               NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(@"", nil)};

    NSError *error = [NSError errorWithDomain:@"" code:-1 userInfo:userInfo];
    [CrashlyticsKit recordError:error];
    [[Crashlytics sharedInstance] recordCustomExceptionName:@"HandledException" reason:message frameArray:@[]];
}

- (void)log:(CDVInvokedUrlCommand *)command {
    NSString *message = [command argumentAtIndex:0];
    CLSLog(@"%@", message);
}

- (void)setString:(CDVInvokedUrlCommand *)command {
    NSString *key = [command argumentAtIndex:0];
    NSString *value = [command argumentAtIndex:1];

    [CrashlyticsKit setObjectValue:value forKey:key];
}

- (void)setInt:(CDVInvokedUrlCommand *)command {
    NSString *key = [command argumentAtIndex:0];
    NSNumber *value = [command argumentAtIndex:1];

    [CrashlyticsKit setIntValue:[value integerValue] forKey:key];
}

- (void)setBool:(CDVInvokedUrlCommand *)command {
    NSString *key = [command argumentAtIndex:0];
    NSNumber *value = [command argumentAtIndex:1];

    [CrashlyticsKit setIntValue:[value boolValue] forKey:key];
}

- (void)setDouble:(CDVInvokedUrlCommand *)command {
    NSString *key = [command argumentAtIndex:0];
    NSNumber *value = [command argumentAtIndex:1];

    [CrashlyticsKit setIntValue:[value doubleValue] forKey:key];
}

- (void)setFloat:(CDVInvokedUrlCommand *)command {
    NSString *key = [command argumentAtIndex:0];
    NSNumber *value = [command argumentAtIndex:1];

    [CrashlyticsKit setIntValue:[value floatValue] forKey:key];
}

@end
