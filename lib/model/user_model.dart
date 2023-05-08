class UserModel {
  String name;
  String email;
  String createdAt;
  String phoneNumber;
  String uid;
  String money;
  String password;
  String createdAtMonth;
  String createdAtYear;

  UserModel({
    required this.name,
    required this.email,
    required this.createdAt,
    required this.phoneNumber,
    required this.uid,
    required this.money,
    required this.password,
    required this.createdAtMonth,
    required this.createdAtYear,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      uid: map['uid'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      createdAt: map['createdAt (Day Number)'] ?? '',
      money: map['money'] ?? '',
      password: map['password'] ?? '',
      createdAtMonth: map['createdAt (Month Number)'] ?? '',
      createdAtYear: map['createdAt (Year Number)'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "uid": uid,
      "phoneNumber": phoneNumber,
      "createdAt (Day Number)": createdAt,
      "money": money,
      "password": password,
      "createdAt (Month Number)": createdAtMonth,
      "createdAt (Year Number)": createdAtYear,
    };
  }
}
