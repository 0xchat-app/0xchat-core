//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<connectivity_plus/ConnectivityPlusPlugin.h>)
#import <connectivity_plus/ConnectivityPlusPlugin.h>
#else
@import connectivity_plus;
#endif

#if __has_include(<nostr_core_dart/NostrCoreDartPlugin.h>)
#import <nostr_core_dart/NostrCoreDartPlugin.h>
#else
@import nostr_core_dart;
#endif

#if __has_include(<path_provider_foundation/PathProviderPlugin.h>)
#import <path_provider_foundation/PathProviderPlugin.h>
#else
@import path_provider_foundation;
#endif

#if __has_include(<sqflite_sqlcipher/SqfliteSqlCipherPlugin.h>)
#import <sqflite_sqlcipher/SqfliteSqlCipherPlugin.h>
#else
@import sqflite_sqlcipher;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [ConnectivityPlusPlugin registerWithRegistrar:[registry registrarForPlugin:@"ConnectivityPlusPlugin"]];
  [NostrCoreDartPlugin registerWithRegistrar:[registry registrarForPlugin:@"NostrCoreDartPlugin"]];
  [PathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"PathProviderPlugin"]];
  [SqfliteSqlCipherPlugin registerWithRegistrar:[registry registrarForPlugin:@"SqfliteSqlCipherPlugin"]];
}

@end
