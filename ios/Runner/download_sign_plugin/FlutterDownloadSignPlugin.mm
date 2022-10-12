#import "FlutterDownloadSignPlugin.h"
#import "IpaSign.h"
@implementation FlutterDownloadSignPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_download_sign_plugin"
            binaryMessenger:[registrar messenger]];
  FlutterDownloadSignPlugin* instance = [[FlutterDownloadSignPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  }else if ([@"ipaSign" isEqualToString:call.method]) {
      NSString *command=call.arguments[@"command"];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"%@", command);
        BOOL isOk = [IpaSign startSignWithCmd:command];
        dispatch_async(dispatch_get_main_queue(), ^{
            if(isOk){
                result(@(2));
            }else{
                result(@(0));
            }
        });
    });
  }else {
    result(FlutterMethodNotImplemented);
  }
    
}

@end
