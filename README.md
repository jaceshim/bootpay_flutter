# bootpay_flutter

This plugin is payment modules of [Bootpay](https://www.bootpay.co.kr) for Flutter.

## Getting Started
Add the module to your project ``pubspec.yaml``:
```yaml
...
dependencies:
 ...
 bootpay_flutter: ^0.0.1
...
```
And install it using ``flutter packages get`` on your project folder. After that, just import the module and use it:

##Settings

### Android
No configuration required.

### iOS
**\<your project root\>/ios/Runner/Info.plist**

```xml
<key>NSAppTransportSecurity</key>
    <dict>
        <key>NSAllowsArbitraryLoads</key>
        <true/>
    </dict>
    <key>CFBundleURLTypes</key>
    <array>
        <dict>
            <key>CFBundleTypeRole</key>
            <string>Editor</string>
            <key>CFBundleURLName</key>
            <string>kr.co.bootpaySample</string> // 사용하고자 하시는 앱의 bundle url name
            <key>CFBundleURLSchemes</key>
            <array>
                <string>bootpaySample</string> // 사용하고자 하시는 앱의 bundle url scheme
            </array>
        </dict>
    </array>
```

Done!

```dart
import 'package:bootpay_flutter/bootpay_flutter.dart';

//...
String paymentResult;
final UserInfo userInfo = UserInfo(username: "홍길동", email: "test@test.com");
final PayParam payParam = PayParam(
    price: "1000",
    applicationId: "59a4d326396fa607cbe75de5", // your_bootpay_id (android or iOS)
    name: "bootpay_flutter_테스트_결제",
    userInfo: userInfo,
    orderId: "BootpayTest000001");

try {
  final PayResult result = await BootpayFlutter.pay(payParam);
  paymentResult = result.toString();
} on Exception {
  paymentResult = 'Payment Failed.';
}

```
Enjoy!

## Author
Developed by [Jace Shim (심천보)](https://www.facebook.com/jaceshim.kr)

## Contributing

Feel free to help!
