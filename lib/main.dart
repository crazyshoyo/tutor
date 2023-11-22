import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tutor_lms/presentation/getx/appPages.dart';
import 'approutes.dart';
import 'constants/Theme.dart';
import 'data.datasource/local/local_storage.dart';
import 'data.datasource/remote/services/dio/dio.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  Stripe.publishableKey = "pk_test_51OBDcLSAUT6qynwNFWC1HjCuPUXU00WqPFBPryt4f6PnU2H7KXxBIPQ57duLulqQ7g7go4ACNghGyww1PztQsfwX00JZ72Mp2u";
  await Stripe.instance.applySettings();
  HttpOverrides.global = MyHttpOverrides();
  await GetStorage.init();
  await ScreenUtil.ensureScreenSize();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme().lightTheme,
          darkTheme: AppTheme().darkTheme,
          themeMode: LocalStorage().getTheme(),
          title: "Tutor Lms",
          initialRoute:  AppRoutes.splashScreen,
          getPages: AppPages.list,
        );
      },
    );
  }
}
