#import "RunAccessFacialPlugin.h"
#if __has_include(<run_access_facial/run_access_facial-Swift.h>)
#import <run_access_facial/run_access_facial-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "run_access_facial-Swift.h"
#endif

@implementation RunAccessFacialPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftRunAccessFacialPlugin registerWithRegistrar:registrar];
}
@end
