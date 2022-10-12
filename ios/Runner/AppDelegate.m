#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#include "FlutterDownloaderPlugin.h"
#import "FlutterDownloadSignPlugin.h"
@implementation AppDelegate

void registerPlugins(NSObject<FlutterPluginRegistry>* registry) {
  if (![registry hasPlugin:@"FlutterDownloaderPlugin"]) {
     [FlutterDownloaderPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterDownloaderPlugin"]];
  }
}




- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  [FlutterDownloaderPlugin setPluginRegistrantCallback:registerPlugins];
  [FlutterDownloadSignPlugin registerWithRegistrar:[self registrarForPlugin:@"FlutterDownloadSignPlugin"]];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)applicationDidEnterBackground:(UIApplication *)application{
    [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
}
@end
