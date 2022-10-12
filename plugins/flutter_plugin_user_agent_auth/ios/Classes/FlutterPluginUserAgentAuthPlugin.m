#import "FlutterPluginUserAgentAuthPlugin.h"
#import <AdSupport/AdSupport.h>

@implementation FlutterPluginUserAgentAuthPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"flutter_plugin_user_agent_auth"
                                     binaryMessenger:[registrar messenger]];
    FlutterPluginUserAgentAuthPlugin* instance = [[FlutterPluginUserAgentAuthPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"getDeviceInfo" isEqualToString:call.method]) {
        UIDevice* device = [UIDevice currentDevice];
        UIWebView *uiWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
        NSString *oldUA = [uiWebView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
        
        NSString *udid =@"";
        NSString *hs_agent=@"";
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
        NSMutableDictionary *infoDict = [NSMutableDictionary dictionaryWithContentsOfFile:bundlePath];
        if ([infoDict.allKeys containsObject:@"UDID"]) {
            udid = infoDict[@"UDID"];
        }
        if ([infoDict.allKeys containsObject:@"HuoAgentGame"]) {
            hs_agent = infoDict[@"HuoAgentGame"];
        }
        
        
        NSDictionary *dict = @{
            @"device_id" : [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString],
            @"idfv" : [[[UIDevice currentDevice] identifierForVendor] UUIDString],
            @"os" : @"ios",
            @"brand" : @"apple",
            @"userua":oldUA,
            @"systemName" : [device systemName],
            @"os_version" : [device systemVersion],
            @"model" : [device model],
            @"udid" : udid,
            @"hs_agent" : hs_agent,
            @"localizedModel" : [device localizedModel],
            @"identifierForVendor" : [[device identifierForVendor] UUIDString],
			@"mac" : udid,
        };
        NSString *jsonString = [self convertToJsonData:dict];
        result(jsonString);
    } if ([@"getAppInstall" isEqualToString:call.method]) {
        NSString *uri = [call.arguments[@"uri"] stringValue];
        BOOL appInstall = [self getAppInstall:uri];
        NSDictionary *dic = @{
            @"result":@(appInstall),
        };
        result(dic);
    } else if ([@"finishApp" isEqualToString:call.method]) {
        NSDictionary *dict = @{@"code":@"200"};
        result(dict);
    } else {
        result(FlutterMethodNotImplemented);
    }
}

-(NSString *)convertToJsonData:(NSDictionary *)dict
{
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}

-(BOOL)getAppInstall:(NSString*)URLScheme{
    NSURL* url;
    if ([URLScheme containsString:@"://"]) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",URLScheme]];
    } else {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@://",URLScheme]];
    }
    if ([[UIApplication sharedApplication] canOpenURL:url]){
        return YES;
    } else {
        return NO;
    }
}

@end
