import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:tutor_lms/constants/constants.dart';
import 'package:tutor_lms/core/error/failures.dart';
import 'package:tutor_lms/data.datasource/Repository_imp/membership_repository_imp.dart';
import 'package:tutor_lms/data.datasource/remote/models/request/create_payment.dart';
import 'package:tutor_lms/data.datasource/remote/models/request/stripe_request.dart';
import 'package:tutor_lms/data.datasource/remote/models/response/membershipPlans_response.dart';
import 'package:tutor_lms/widgets/tutor_lms_toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class MemberShipController extends GetxController {
  bool loading = false;
  bool buttonLoading = false;
  bool active = false;
  Plans? plans;
  bool month = true;
  bool annual = false;
  String? name;
  String? description;
  String? type;
  String? price;
  String? planId;
  String? clientSecret;

  Map<String, dynamic>? paymentIntent;


  bool month1 = true;
  bool annual1 = false;
  String? name1;
  String? description1;
  String? type1;
  String? price1;

  final MemberRepositoryImpl repositoryImpl = MemberRepositoryImpl();


  onMonth() {
    month = true;
    annual = false;
    update([ControllerBuilders.memberShipController]);
  }

  onAnnual(String id) {
    planId = id;
    annual = true;
    month = false;
    update([ControllerBuilders.memberShipController]);
  }


  onMonthGold(String id) {
    planId = id;
    month1 = true;
    annual1 = false;
    update([ControllerBuilders.memberShipController]);
  }


  onAnnualGold(String id) {
    planId = id;
    annual1 = true;
    month1 = false;
    update([ControllerBuilders.memberShipController]);
  }

  urlLaunch(String data) async {
    final url = Uri.parse(data);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.platformDefault);
    } else {
      throw 'Could not launch $url';
    }
  }

  onPayment(BuildContext context) async {
    buttonLoading = true;
    update([ControllerBuilders.memberShipController]);
    var request = StripeRequest(
        packageId: planId ?? ''
    );
    var data = await repositoryImpl.create(request);
    data.fold((l) {
      if (l is ServerFailure) {
        ToastUtils.showCustomToast(context, l.message ?? '', false);
        buttonLoading = false;
        update([ControllerBuilders.memberShipController]);
      }
    }, (r) {
      if (r.type == "redirect") {
        urlLaunch(r.url ?? '');
      }
      buttonLoading = false;
      update([ControllerBuilders.memberShipController]);
    }
    );
    update([ControllerBuilders.memberShipController]);
  }




  onMemberShip(BuildContext context) async {
    var data = await repositoryImpl.memberShip();
    data.fold((l) {
      if (l is ServerFailure) {
        ToastUtils.showCustomToast(context, l.message ?? '', false);
      }
    }, (r) {
      plans = r.plans;
      price = r.plans?.platinum?[0].price ?? '';
      price1 = r.plans?.gold?[0].price ?? '';
      update([ControllerBuilders.memberShipController]);
    });
  }

  Future<void> initPaymentSheet(BuildContext context) async {
    try {
      var response = await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: clientSecret,
          ));
      log(response.toString());
      _displayPaymentSheet();
    } catch (e) {
      print("yaha pr ------" + e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      rethrow;
    }
  }

  createPayment(String planid) async {
    buttonLoading = true;
    update([ControllerBuilders.memberShipController]);
    var request = CreatePaymentRequest(
        id: planid ?? ''
    );
    var data = await repositoryImpl.createPayment(request);
    data.fold((l) {
      if (l is ServerFailure) {
        buttonLoading = false;
        update([ControllerBuilders.memberShipController]);
      }
    }, (r) {
      if (r.message == "successfully create Payment Intent") {
        clientSecret = r.data?.clientSecret ?? '';
        update([ControllerBuilders.memberShipController]);
      }
      buttonLoading = false;
      update([ControllerBuilders.memberShipController]);
    }
    );
    update([ControllerBuilders.memberShipController]);
  }

  Future<void> _displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        log(value.toString());
        Get.snackbar("Payment", "Payment successful",
            snackPosition: SnackPosition.BOTTOM);
      }).onError((error, stackTrace) {
        Get.snackbar("Payment", '"Payment flow has been cancelled"',
            snackPosition: SnackPosition.BOTTOM);
      });
    } on StripeException {
      Get.snackbar("Payment", "Payment flow has been cancelled",
          snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar("Error", "$e", snackPosition: SnackPosition.BOTTOM);
    }
  }


  Future<void> makePayment(BuildContext context) async {
    try {
      paymentIntent = await createPaymentIntent('100', 'INR');
      await Stripe.instance
          .initPaymentSheet(

          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent![
              'client_secret'], //Gotten from payment intent
              style: ThemeMode.light,
              merchantDisplayName: 'Ikay'))
          .then((value) {});

      displayPaymentSheet(context);
    } catch (err) {
      throw Exception(err);
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer sk_test_51OBDcLSAUT6qynwN1gh0133uThYx0Ky6LcyvnYL9Uoe8R9r61hb21rzckMFBWWhCUtDOzEMcK44x2Xg1IhLtEXxQ000s1ppQhH',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  displayPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
            context: context,
            builder: (_) =>
                AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 100.0,
                      ),
                      SizedBox(height: 10.0),
                      Text("Payment Successful!"),
                    ],
                  ),
                ));

        paymentIntent = null;
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                Text("Payment Failed"),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      print('$e');
    }
  }
}


class Plan {
  final String name;
  final int totalCourses;
  final double price;
  final String description;
  final String currency;
  final String type;

  Plan({
    required this.name,
    required this.totalCourses,
    required this.price,
    required this.description,
    required this.currency,
    required this.type,
  });
}