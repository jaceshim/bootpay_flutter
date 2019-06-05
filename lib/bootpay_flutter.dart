import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

/// Bootpay payment modules for Flutter
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

/// 결제요청 파라미터
class PayParam {
  /// 실 결제 금액
  String price;

  /// SDK용 Application ID (Android, iOS 각각 관리되는 값)
  String applicationId;

  /// 결제창에 보여질 이름
  String name;

  /// PG 명
  String pg;

  /// 결제수단, 입력하지 않으면 결제수단 선택부터 화면이 시작합니다.
  String method;

  /// 부트페이 정보 동의 창 보이기 여부
  bool showAgreeWindow;

  /// 결제 아이템 목록
  List<Item> items;

  /// 사용자(구매자) 정보
  UserInfo userInfo;

  /// 고유 주문번호로, 생성하신 값을 보내주셔야 합니다.
  String orderId;

  /// pg결제후 콜백받을 변수 map
  Map<String, String> params;

  /// 가상계좌 입금기간 제한 ( yyyy-mm-dd 포멧으로 입력해주세요. 가상계좌만 적용됩니다. )
  String accountExpireAt;

  Extra extra;

  PayParam(
      {@required this.price,
      @required this.applicationId,
      @required this.name,
      this.pg = "",
      this.method = "",
      this.showAgreeWindow = false,
      this.items = const [],
      @required this.userInfo,
      @required this.orderId,
      this.params,
      this.accountExpireAt,
      this.extra});

  PayParam.fromJson(Map<String, dynamic> json)
      : this.price = json["price"],
        this.applicationId = json["applicationId"],
        this.name = json["name"],
        this.pg = json["pg"],
        this.method = json["method"],
        this.showAgreeWindow = json["showAgreeWindow"],
        this.items = (json["items"] as List).map((i) => Item.fromJson(i)).toList(),
        this.userInfo = UserInfo.fromJson(json["userInfo"]),
        this.orderId = json["orderId"],
        this.params = jsonDecode(json["params"]),
        this.accountExpireAt = json["accountExpireAt"],
        this.extra = Extra.fromJson(json["extra"]);

  Map<String, dynamic> toJson() => {
        "price": this.price,
        "applicationId": this.applicationId,
        "name": this.name,
        "pg": this.pg,
        "method": this.method,
        "showAgreeWindow": this.showAgreeWindow,
        "items": this.items.map((i) => i.toJson()).toList(),
        "userInfo": this.userInfo?.toJson(),
        "orderId": this.orderId,
        "params": jsonEncode(this.params),
        "accountExpireAt": this.accountExpireAt,
        "extra": this.extra?.toJson(),
      };

  /// PG enum값을 String으로 변환하여 얻는ㅂ다.
  static String getPG(PG pg) {
    return pg.toString().split(".").last;
  }

  @override
  String toString() {
    return 'PayParam{price: $price, applicationId: $applicationId, name: $name, pg: $pg, method: $method, showAgreeWindow: $showAgreeWindow, items: $items, userInfo: $userInfo, orderId: $orderId, params: $params, accountExpireAt: $accountExpireAt, extra: $extra}';
  }
}

/// 결제요청 결과
class PayResult {
  String status;
  String action;
  String receiptId;
  num amount;
  String cardNo;
  String cardCode;
  String cardName;
  String cardQuota;
  Map<String, Object> params;
  String itemName;
  String orderId;
  String url;
  num price;
  num taxFee;
  String paymentName;
  String pgName;
  String pg;
  String method;
  String methodName;
  String paymentGroup;
  String paymentGroupName;
  String requestedAt;

  PayResult({
    this.action,
    this.receiptId,
    this.amount,
    this.cardNo,
    this.cardCode,
    this.cardName,
    this.cardQuota,
    this.params,
    this.itemName,
    this.orderId,
    this.url,
    this.price,
    this.taxFee,
    this.paymentName,
    this.pgName,
    this.pg,
    this.method,
    this.methodName,
    this.paymentGroup,
    this.paymentGroupName,
    this.requestedAt,
  });

  @override
  String toString() {
    return 'PayResult{action: $action, receiptId: $receiptId, amount: $amount, cardNo: $cardNo, cardCode: $cardCode, cardName: $cardName, cardQuota: $cardQuota, params: $params, itemName: $itemName, orderId: $orderId, url: $url, price: $price, taxFee: $taxFee, paymentName: $paymentName, pgName: $pgName, pg: $pg, method: $method, methodName: $methodName, paymentGroup: $paymentGroup, paymentGroupName: $paymentGroupName, requestedAt: $requestedAt}';
  }
}

/// 사용자(구매자) 정보
class UserInfo {
  /// 사용자 이름
  String username;

  /// 사용자 이메일
  String email;

  /// 사용자 주소
  String addr;

  /// 사용자 휴대폰 번호
  String phone;

  UserInfo({@required this.username, @required this.email, this.addr, this.phone});

  UserInfo.fromJson(Map<String, dynamic> json)
      : this.username = json["username"],
        this.email = json["email"],
        this.addr = json["addr"],
        this.phone = json["phone"];

  Map<String, dynamic> toJson() => {
        "username": this.username,
        "email": this.email,
        "addr": this.addr,
        "phone": this.phone,
      };

  @override
  String toString() {
    return 'UserInfo{username: $username, email: $email, addr: $addr, phone: $phone}';
  }
}

/// 결제 아이템
class Item {
  /// 상품명
  String itemName;

  /// 수량
  int qty;

  /// 해당 상품을 구분짓는 primary key
  String unique;

  /// 상품 단가
  int price;

  /// 대표 상품의 카테고리 상, 50글자 이내
  String cat1;

  /// 대표 상품의 카테고리 중, 50글자 이내
  String cat2;

  /// 대표상품의 카테고리 하, 50글자 이내
  String cat3;

  Item({this.itemName, this.qty, this.unique, this.price, this.cat1, this.cat2, this.cat3});

  Item.fromJson(Map<String, dynamic> json)
      : this.itemName = json["itemName"],
        this.qty = json["qty"],
        this.unique = json["unique"],
        this.price = json["price"],
        this.cat1 = json["cat1"],
        this.cat2 = json["cat2"],
        this.cat3 = json["cat3"];

  Map<String, dynamic> toJson() => {
        "itemName": this.itemName,
        "qty": this.qty,
        "unique": this.unique,
        "price": this.price,
        "cat1": this.cat1,
        "cat2": this.cat2,
        "cat3": this.cat3,
      };

  @override
  String toString() {
    return 'Item{itemName: $itemName, qty: $qty, unique: $unique, price: $price, cat1: $cat1, cat2: $cat2, cat3: $cat3}';
  }
}

class Extra {
  /// 정기 결제 시작일 - 시작일을 지정하지 않으면 그 날 당일로부터 결제가 가능한 Billing key 지급
  String startAt;

  /// 정기결제 만료일 -  기간 없음 - 무제한
  String endAt;

  /// 가상계좌 사용시 사용, 가상계좌 결과창을 볼지(1), 말지(0), 미설정시 봄(1)
  int vbankResult;

  /// 결제금액이 5만원 이상시 할부개월 허용범위를 설정할 수 있음, [0(일시불), 2개월, 3개월] 허용, 미설정시 12개월까지 허용
  String quota;

  Extra({this.startAt, this.endAt, this.vbankResult, this.quota});

  Extra.fromJson(Map<String, dynamic> json)
      : this.startAt = json["startAt"],
        this.endAt = json["endAt"],
        this.vbankResult = json["vbankResult"],
        this.quota = json["quota"];

  Map<String, dynamic> toJson() => {
        "startAt": this.startAt,
        "endAt": this.endAt,
        "vbankResult": this.vbankResult,
        "quota": this.quota,
      };

  @override
  String toString() {
    return 'Extra{startAt: $startAt, endAt: $endAt, vbankResult: $vbankResult, quota: $quota}';
  }
}

/// 결제사 PG
enum PG {
  KCP,
  DANAL,
  INICIS,
  NICEPAY,
  LGUP,
  PAYAPP,
  KAKAO,
  PAYCO,
  KICC,
  EASYPAY,
  JTNET,
  TPAY,
  MOBILIANS,
  PAYLETTER,
  BOOTPAY,
}

/// 결제취소 파라미터
class CancelParam {}

/// 결제취소 결과
class CancelResult {}
