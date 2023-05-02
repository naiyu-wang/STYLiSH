import UIKit
import Flutter
import TPDirect
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController

//        testBatteryChannelFunction(controller)

        getPurchaseResult(controller)

        GeneratedPluginRegistrant.register(with: self)

        TPDSetup.setWithAppId(Int32(TapPayInfo.appId), withAppKey: TapPayInfo.appKey, with: TPDServerType.sandBox)

         if let path = Bundle.main.path(forResource: "Key", ofType: "plist") {
             let plist = NSDictionary(contentsOfFile: path)
             let key: String = plist?["google_map_key"] as? String ?? "unknown"
             GMSServices.provideAPIKey(key)
         }

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func getPurchaseResult(_ controller: FlutterViewController) {
        let purchaseChannel = FlutterMethodChannel(name: "stylish.flutter/productDetailPage",
                                                  binaryMessenger: controller.binaryMessenger)
        purchaseChannel.setMethodCallHandler({
          [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
          // This method is invoked on the UI thread.
          guard call.method == "getPurchaseResult" else {
            result(FlutterMethodNotImplemented)
            return
          }
            self?.openPurchasePage(result: result)
        })
    }

    private func openPurchasePage(result: FlutterResult) {
        // TODO
    }

    // MARK: - Test

    private func testBatteryChannelFunction(_ controller: FlutterViewController) {
        let batteryChannel = FlutterMethodChannel(name: "stylish.flutter/homePage",
                                                  binaryMessenger: controller.binaryMessenger)
        batteryChannel.setMethodCallHandler({
          [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
          // This method is invoked on the UI thread.
          guard call.method == "getBatteryLevel" else {
            result(FlutterMethodNotImplemented)
            return
          }
          self?.receiveBatteryLevel(result: result)
        })
    }

    private func receiveBatteryLevel(result: FlutterResult) {
        let device = UIDevice.current
        device.isBatteryMonitoringEnabled = true
        if device.batteryState == UIDevice.BatteryState.unknown {
            result(FlutterError(code: "UNAVAILABLE",
                                message: "Battery level not available.",
                                details: nil))
        } else {
            result(Int(device.batteryLevel * 100))
        }
    }
}
