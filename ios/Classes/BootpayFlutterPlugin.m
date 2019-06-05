#import "BootpayFlutterPlugin.h"
#import <bootpay_flutter/bootpay_flutter-Swift.h>

@implementation BootpayFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftBootpayFlutterPlugin registerWithRegistrar:registrar];
}
@end
