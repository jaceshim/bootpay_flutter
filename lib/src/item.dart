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
