import 'dart:async';

import 'package:bootpay_flutter/src/pay_param.dart';
import 'package:bootpay_flutter/src/pay_result.dart';
import 'package:flutter/services.dart';

class BootpayFlutter {
	static const MethodChannel _channel = const MethodChannel('jaceshim/bootpay_flutter');
	
	static Future<PayResult> pay(PayParam payParam) async {
		final Map<dynamic, dynamic> result = await _channel.invokeMethod(
			"doPay",
			payParam.toJson(),
		);
		
		if (result != null) {
			return PayResult(
				action: result["action"],
				receiptId: result["receipt_id"],
				amount: result["amount"],
				cardNo: result["card_no"],
				cardCode: result["card_code"],
				cardName: result["card_name"],
				cardQuota: result["card_quota"],
				//        params: result["params"],
				itemName: result["item_name"],
				orderId: result["order_id"],
				url: result["url"],
				price: result["price"],
				taxFee: result["tax_free"],
				paymentName: result["payment_name"],
				pgName: result["pg_name"],
				pg: result["pg"],
				method: result["method"],
				methodName: result["method_name"],
				paymentGroup: result["payment_group"],
				paymentGroupName: result["payment_group_name"],
				requestedAt: result["requested_at"],
			);
		}
		
		throw Exception("bootpay result null : ${payParam.toString()}");
	}
}
