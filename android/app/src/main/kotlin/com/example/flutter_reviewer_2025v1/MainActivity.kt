package com.example.flutter_reviewer_2025v1

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build
import android.os.Build.VERSION_CODES
import java.util.Locale
import androidx.annotation.NonNull

import android.content.BroadcastReceiver
import android.os.Bundle
import android.os.PowerManager
import io.flutter.plugin.common.EventChannel


class MainActivity : FlutterActivity() {
//    private val CHANNEL = "com.aws.arkray"
//
//    private var dozeReceiver: BroadcastReceiver? = null
//    private var eventSink: EventChannel.EventSink? = null
//
//    private lateinit var channel: MethodChannel
//
//    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
//        super.configureFlutterEngine(flutterEngine)
//        EventChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setStreamHandler(
//            object : EventChannel.StreamHandler {
//                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
//                    eventSink = events
//
//                    // Emit initial Doze status so Flutter doesn't get null!
//                    val pm = getSystemService(POWER_SERVICE) as PowerManager
//                    events?.success(pm.isDeviceIdleMode)
//
//                    val filter = IntentFilter(PowerManager.ACTION_DEVICE_IDLE_MODE_CHANGED)
//                    dozeReceiver = object : BroadcastReceiver() {
//                        override fun onReceive(context: Context?, intent: Intent?) {
//                            val pm = getSystemService(POWER_SERVICE) as PowerManager
//                            eventSink?.success(pm.isDeviceIdleMode)
//                        }
//                    }
//                    registerReceiver(dozeReceiver, filter)
//                }
//
//                override fun onCancel(arguments: Any?) {
//                    dozeReceiver?.let { unregisterReceiver(it) }
//                    dozeReceiver = null
//                    eventSink = null
//                }
//            }
//        )
//
//        // channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
////        channel.setMethodCallHandler { call, result ->
////            when (call.method) {
////                "getBatteryLevel" -> {
////                    val batteryLevel = getBatteryLevel()
////                    println("Azman cm $batteryLevel")
////                    if (batteryLevel != -1) {
////                        result.success(batteryLevel)
////                    } else {
////                        result.error("UNAVAILABLE", "Battery level not available.", null)
////                    }
////                }
////                "getRandomNumber" -> result.success((1..100).random())
////                "getDeviceName" -> result.success(getDeviceName())
////                "callMe" -> {
////                    result.success( callMe())
////                }
////                else -> result.notImplemented()
////            }
////        }
//    }
//
//    private fun getBatteryLevel(): Int {
//        return if (Build.VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
//            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
//            batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
//        } else {
//            val intent = ContextWrapper(applicationContext).registerReceiver(
//                null, IntentFilter(Intent.ACTION_BATTERY_CHANGED)
//            )
//            val level = intent?.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) ?: -1
//            val scale = intent?.getIntExtra(BatteryManager.EXTRA_SCALE, -1) ?: -1
//            if (level != -1 && scale != -1) {
//                level * 100 / scale
//            } else {
//                -1
//            }
//        }
//    }
//
//    private fun getDeviceName(): String {
//        val manufacturer = Build.MANUFACTURER.uppercase(Locale.ROOT)
//        val model = Build.MODEL
//        return if (model.startsWith(manufacturer)) {
//            model
//        } else {
//            "$manufacturer $model"
//        }
//    }
//
//    // If you want to expose this callable from somewhere
//    private fun callMe() : String {
//        notifyFlutter(message = "Hello from Kotlin! New")
//        return "Hello from Kotlin!"
//    }
//
//    private fun notifyFlutter(message : String ) {
//        val args = mapOf("value" to message)
//        channel.invokeMethod("fromNative", args, object : MethodChannel.Result {
//            override fun success(result: Any?) {
//                println("Received from Dart: $result")
//            }
//            override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {}
//            override fun notImplemented() {}
//        })
//    }
}