package com.oxchat.chatcore

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.util.Log
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.PluginRegistry.ActivityResultListener


/** ChatcorePlugin */
class ChatcorePlugin: FlutterPlugin, MethodCallHandler, ActivityAware, ActivityResultListener {
  companion object {
    private const val OX_CORE_CHANNEL = "com.oxchat.chatcore"
  }

  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private lateinit var mContext: Context
  private lateinit var mActivity: Activity
  private lateinit var mMethodChannelResult: Result
  private var mSignatureRequestCode = 101

  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    mContext = binding.applicationContext
    channel = MethodChannel(binding.binaryMessenger, OX_CORE_CHANNEL)
    channel.setMethodCallHandler(this)
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    mActivity = binding.activity
    binding.addActivityResultListener(this)
  }

  override fun onDetachedFromActivityForConfigChanges() {}
  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {}
  override fun onDetachedFromActivity() {}

  override fun onMethodCall(call: MethodCall, result: Result) {
    mMethodChannelResult = result
    var paramsMap: HashMap<*, *>? = null
    if (call.arguments != null && call.arguments is HashMap<*, *>) {
      paramsMap = call.arguments as HashMap<*, *>
    }
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else if (call.method == "nostrsigner") {
      if (paramsMap == null){
        return;
      }
      var extendParse: String? = paramsMap["extendParse"] as? String
      val intent = Intent(
        Intent.ACTION_VIEW, Uri.parse(
          "nostrsigner:$extendParse"
        )
      )
      intent.`package` = "com.greenart7c3.nostrsigner"
      var type: String? = paramsMap["type"] as? String ?: "get_public_key"
      intent.putExtra("type", type)

      paramsMap["id"]?.let { id ->
        if (id is String) intent.putExtra("id", id)
      }
      paramsMap["current_user"]?.let { currentUser ->
        if (currentUser is String) intent.putExtra("current_user", currentUser)
      }
      paramsMap["pubKey"]?.let { pubKey ->
        if (pubKey is String) intent.putExtra("pubKey", pubKey)
      }
      intent.addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP or Intent.FLAG_ACTIVITY_CLEAR_TOP)
      if (paramsMap.containsKey("requestCode")) {
        mSignatureRequestCode = paramsMap["requestCode"] as Int
      }
      mActivity.startActivityForResult(intent, mSignatureRequestCode)
    } else {
      result.notImplemented()
    }
  }

  override fun onActivityResult(requestCode: Int, resultCode: Int, result: Intent?): Boolean {
    Log.e("Michael", "---mSignatureRequestCode ="+mSignatureRequestCode);
    Log.e("Michael", "---resultCode ="+resultCode);
    Log.e("Michael", "---result ="+result);
    if (mSignatureRequestCode == requestCode) {
      if (resultCode == Activity.RESULT_OK && result != null) {
        val dataMap: MutableMap<String, String?> = HashMap()
        if (result.hasExtra("signature")) {
          val signature = result.getStringExtra("signature")
          dataMap["signature"] = signature
        }
        if (result.hasExtra("id")) {
          val id = result.getStringExtra("id")
          dataMap["id"] = id
        }
        if (result.hasExtra("event")) {
          val event = result.getStringExtra("event")
          dataMap["event"] = event
        }
        if (mMethodChannelResult != null) {
          mMethodChannelResult.success(dataMap)
        }
      } else {
        if (mMethodChannelResult != null) {
          mMethodChannelResult.success(null)
        }
      }
    }
    return false
  }
}
