import 'dart:convert';

import 'package:bootpay_flutter/src/extra.dart';
import 'package:bootpay_flutter/src/item.dart';
import 'package:bootpay_flutter/src/user_info.dart';
import 'package:meta/meta.dart';

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
