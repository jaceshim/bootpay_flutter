import 'dart:async';

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
    String paymentResult;
    final UserInfo userInfo = UserInfo(username: "홍길동", email: "test@test.com");
    final PayParam payParam = PayParam(
        price: "1000",
        applicationId: "5ca5851db6d49c51471909c5", // your_bootpay_id
        name: "bootpay_flutter_테스트_결제",
        userInfo: userInfo,
        orderId: "BootpayTest000001");

    try {
      final PayResult result = await BootpayFlutter.pay(payParam);
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
