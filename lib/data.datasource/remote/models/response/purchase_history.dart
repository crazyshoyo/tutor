// To parse this JSON data, do
//
//     final purchaseHistoryFromJson = purchaseHistoryFromJsonFromJson(jsonString);

import 'dart:convert';

PurchaseHistoryFromJson purchaseHistoryFromJsonFromJson(String str) => PurchaseHistoryFromJson.fromJson(json.decode(str));

String purchaseHistoryFromJsonToJson(PurchaseHistoryFromJson data) => json.encode(data.toJson());

class PurchaseHistoryFromJson {
  List<Enrolment> enrolments;

  PurchaseHistoryFromJson({
     required this.enrolments,
  });

  factory PurchaseHistoryFromJson.fromJson(Map<String, dynamic> json) => PurchaseHistoryFromJson(
    enrolments: List<Enrolment>.from(json["enrolments"].map((x) => Enrolment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "enrolments": List<dynamic>.from(enrolments.map((x) => x.toJson())),
  };
}

class Enrolment {
  int id;
  int userId;
  int packageId;
  String boughtPrice;
  String? paymentMethod;
  int status;
  dynamic stPayStatus;
  dynamic reason;
  DateTime expiredAt;
  DateTime createdAt;
  DateTime updatedAt;
  Package package;

  Enrolment({
    required this.id,
    required this.userId,
    required this.packageId,
    required this.boughtPrice,
    required this.paymentMethod,
    required this.status,
    required this.stPayStatus,
    required this.reason,
    required this.expiredAt,
    required this.createdAt,
    required this.updatedAt,
    required this.package,
  });

  factory Enrolment.fromJson(Map<String, dynamic> json) => Enrolment(
    id: json["id"],
    userId: json["user_id"],
    packageId: json["package_id"],
    boughtPrice: json["bought_price"],
    paymentMethod: json["payment_method"],
    status: json["status"],
    stPayStatus: json["st_pay_status"],
    reason: json["reason"],
    expiredAt: DateTime.parse(json["expired_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    package: Package.fromJson(json["package"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "package_id": packageId,
    "bought_price": boughtPrice,
    "payment_method": paymentMethod,
    "status": status,
    "st_pay_status": stPayStatus,
    "reason": reason,
    "expired_at": expiredAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "package": package.toJson(),
  };
}

class Package {
  String name;
  String price;
  String description;

  Package({
    required this.name,
    required this.price,
    required this.description,
  });

  factory Package.fromJson(Map<String, dynamic> json) => Package(
    name: json["name"],
    price: json["price"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "price": price,
    "description": description,
  };
}
