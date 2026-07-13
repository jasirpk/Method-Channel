import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {

    private let CHANNEL = "samples.flutter.dev/battery"

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        return super.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
    }

    // NOTE: parameter type is `FlutterImplicitEngineBridge`, not `FlutterEngine`
    func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
        // Register plugins via the bridge's plugin registry
        GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)

        // Create method channels via the bridge's applicationRegistrar messenger
        let batteryChannel = FlutterMethodChannel(
            name: CHANNEL,
            binaryMessenger: engineBridge.applicationRegistrar.messenger()
        )

        batteryChannel.setMethodCallHandler { [weak self] call, result in
            guard call.method == "getBatteryLevel" else {
                result(FlutterMethodNotImplemented)
                return
            }
            self?.receiveBatteryLevel(result: result)
        }
    }

    private func receiveBatteryLevel(result: FlutterResult) {
        let device = UIDevice.current
        device.isBatteryMonitoringEnabled = true

        if device.batteryState == .unknown {
            result(
                FlutterError(
                    code: "UNAVAILABLE",
                    message: "Battery level not available",
                    details: nil
                )
            )
        } else {
            result(Int(device.batteryLevel * 100))
        }
    }
}