import 'dart:convert';
import 'package:chatcore/chat-core.dart';
import 'circle_api.dart';

/// S3 configuration utility class
class S3ConfigUtils {
  S3ConfigUtils._();

  /// Save S3 configuration to CircleDBISAR
  /// 
  /// [circleId] Circle ID
  /// [s3Config] S3 configuration to save
  /// Returns true if successful, false otherwise
  static Future<bool> saveS3ConfigToCircleDB({
    required String circleId,
    required S3Config s3Config,
  }) async {
    try {
      // Convert S3Config to JSON string
      final s3ConfigJson = jsonEncode(s3Config.toJson());

      // Update circle with S3 config
      final updated = await Account.sharedInstance.updatecircle(
        circleId: circleId,
        s3ConfigJson: s3ConfigJson,
      );

      if (updated != null) {
        LogUtils.v(() => 'S3 config saved to circle $circleId');
        return true;
      }

      return false;
    } catch (e) {
      LogUtils.e(() => 'Failed to save S3 config to circle DB: $e');
      return false;
    }
  }

  /// Load S3 configuration from CircleDBISAR
  /// 
  /// [circleId] Circle ID
  /// Returns S3Config if found, null otherwise
  static Future<S3Config?> loadS3ConfigFromCircleDB(String circleId) async {
    try {
      final circle = await Account.sharedInstance.getCircleById(circleId);
      if (circle == null || circle.s3ConfigJson == null || circle.s3ConfigJson!.isEmpty) {
        return null;
      }

      final jsonMap = jsonDecode(circle.s3ConfigJson!) as Map<String, dynamic>;
      return S3Config.fromJson(jsonMap);
    } catch (e) {
      LogUtils.e(() => 'Failed to load S3 config from circle DB: $e');
      return null;
    }
  }

  /// Get S3 file server URL from S3Config
  /// 
  /// [s3Config] S3 configuration
  /// Returns the URL to use for S3/MinIO access
  static String getS3FileServerUrl(S3Config s3Config) {
    // If endpoint_url is provided, use it; otherwise use AWS S3 global endpoint.
    // Region will be passed separately to the Minio client.
    if (s3Config.endpointUrl != null && s3Config.endpointUrl!.isNotEmpty) {
      return s3Config.endpointUrl!;
    } else {
      // Use global S3 endpoint; region is provided via separate parameter.
      return 'https://s3.amazonaws.com';
    }
  }
}

