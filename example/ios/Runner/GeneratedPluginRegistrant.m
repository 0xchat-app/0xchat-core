//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<cryptography_flutter/CryptographyFlutterPlugin.h>)
#import <cryptography_flutter/CryptographyFlutterPlugin.h>
#else
@import cryptography_flutter;
#endif

#if __has_include(<sqflite_sqlcipher/SqfliteSqlCipherPlugin.h>)
#import <sqflite_sqlcipher/SqfliteSqlCipherPlugin.h>
#else
@import sqflite_sqlcipher;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [CryptographyFlutterPlugin registerWithRegistrar:[registry registrarForPlugin:@"CryptographyFlutterPlugin"]];
  [SqfliteSqlCipherPlugin registerWithRegistrar:[registry registrarForPlugin:@"SqfliteSqlCipherPlugin"]];
}

@end
