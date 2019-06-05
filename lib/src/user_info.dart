import 'package:meta/meta.dart';

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
