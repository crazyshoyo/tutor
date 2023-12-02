import 'dart:convert';
String createPaymentRequestToJson(CreatePaymentRequest data) => json.encode(data.toJson());

class CreatePaymentRequest {
  int id;


  CreatePaymentRequest({
    required this.id,
  });

  Map<String, dynamic> toJson() => {
    "package_id": id,

  };
}
