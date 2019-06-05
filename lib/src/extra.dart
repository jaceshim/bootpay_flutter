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
