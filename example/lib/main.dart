import 'dart:async';
import 'dart:io';

import 'package:bootpay_flutter/bootpay_flutter.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _paymentResult = '';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String bootpayApplicationId;
    if (Platform.isAndroid) {
      bootpayApplicationId = "59a4d326396fa607cbe75de5"; // 안드로이드용 bootpay applicationId
    } else {
      bootpayApplicationId = "59a4d328396fa607b9e75de6"; // ios용 bootpay applicationId
    }

    String paymentResult;
    final UserInfo userInfo = UserInfo(username: "홍길동", email: "test@test.com");
    final PayParam payParam = PayParam(
        price: "1000",
        applicationId: bootpayApplicationId, // your_bootpay_id (Android or iOS)
        name: "bootpay_flutter_테스트_결제",
        userInfo: userInfo,
        orderId: "BootpayTest000001");

    try {
      final PayResult result = await BootpayFlutter.pay(payParam);
      if (result.action == "BootpayDone") {
        // 결제성공
        print("결제 성공");
      } else if (result.action == "BootpayCancel") {
        // 사용자가 결제완료전에 결제를 중지한 상태.
        print("사용자 결제 취소");
      } else if (result.action == "BootpayError") {
        // 결제에러
        print("결제 에러");
      }
      paymentResult = result.toString();
    } on Exception {
      paymentResult = 'Payment Failed.';
    }

    setState(() {
      _paymentResult = paymentResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Bootpay flutter example app'),
        ),
        body: Center(
          child: Text('Payment Result : $_paymentResult'),
        ),
      ),
    );
  }
}
