/// 결제요청 결과
class PayResult {
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
