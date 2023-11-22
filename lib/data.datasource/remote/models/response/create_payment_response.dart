import 'dart:convert';

CreatePaymentResponse createPaymentResponseFromJson(String str) => CreatePaymentResponse.fromJson(json.decode(str));

class CreatePaymentResponse {
  final String? message;
  final Data? data;

  CreatePaymentResponse({
    this.message,
    this.data,
  });

  factory CreatePaymentResponse.fromJson(Map<String, dynamic> json) => CreatePaymentResponse(
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

}

class Data {
  final String? clientSecret;

  Data({
    this.clientSecret,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    clientSecret: json["clientSecret"],
  );

}
