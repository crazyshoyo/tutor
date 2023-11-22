import 'dart:convert';
String createPaymentRequestToJson(CreatePaymentRequest data) => json.encode(data.toJson());

class CreatePaymentRequest {
  String id;


  CreatePaymentRequest({
    required this.id,
  });

  Map<String, dynamic> toJson() => {
    "package_id": id,

  };
}
