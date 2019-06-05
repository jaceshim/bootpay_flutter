import Flutter
import UIKit
import SwiftyBootpay

public class SwiftBootpayFlutterPlugin: NSObject, FlutterPlugin {

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "jaceshim/bootpay_flutter", binaryMessenger: registrar.messenger())
        let instance = SwiftBootpayFlutterPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let rootViewController = UIApplication.shared.keyWindow?.rootViewController
        let payParam: Dictionary<String, Any> = call.arguments as! Dictionary<String, Any>
        // bootpay api key
        let bootpayApplicationId = payParam["applicationId"] as! String
        BootpayAnalytics.sharedInstance.appLaunch(application_id: bootpayApplicationId)

        if ("doPay" == call.method) {
            let bootpayViewController = BootpayViewController()
            bootpayViewController.payParam = payParam;
            bootpayViewController.flutterResult = result
            rootViewController?.present(bootpayViewController, animated: true, completion: nil)
        } else {
            result(FlutterMethodNotImplemented)
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        BootpayAnalytics.sharedInstance.sessionActive(active: false)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        BootpayAnalytics.sharedInstance.sessionActive(active: true)
    }
}
