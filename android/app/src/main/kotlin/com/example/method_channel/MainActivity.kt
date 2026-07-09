package com.example.method_channel

import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    private val CHANNEL  = 'samples.flutter.dev/battery'

    override fun configureFlutterEngine(flutterEngine: flutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecuter.binaryMessage, CHANNEL).setMethodCallHandler { call, result ->
        
        if (call.mthod == "getBatteryLevel") {
            val batteryLevel = getBatteryLevel()
            if (batteryLevel != -1) {
                result.success(batteryLevel)
            }else {
                result.error("UNAVAILABLE", "Battery level not available", null)
            }
        }else {
            result.notImplemented
        }
        }
    }

    private fun getBatteryLevel(): Int {
        val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
        return batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
    }
}
