import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tutor_lms/data.datasource/remote/services/apis.dart';
import 'package:tutor_lms/presentation/Auth/login/login.dart';
import 'package:tutor_lms/presentation/dashboard/dashboard.dart';
import 'package:tutor_lms/presentation/onboardingScreen/onboradingScreen.dart';
import 'package:tutor_lms/presentation/tutor_lm_scaffold.dart';
import 'package:tutor_lms/widgets/tutor_lms_container.dart';
import '../../constants/constants.dart';
import '../../constants/images.dart';
import '../../data.datasource/local/local_storage.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _loadWidget();
    super.initState();
  }

  _loadWidget() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration,(){
      LocalStorage.getBool(GetXStorageConstants.onBoarding) == true ? Navigator.push(context, MaterialPageRoute(builder: (context)=>const Login())) :
      Navigator.push(context, MaterialPageRoute(builder: (context)=> OnBoardingScreen()));
    });
  }

  checkLogin() async {
    final client = Dio();
    try{
      final res = await client.get(Apis.userProfile,options: Options(headers:{"Authorization":"Bearer ${LocalStorage.getAuthToken()}"},));
      print(res.data);
      if(res.statusCode == 401) {
      }
    }  catch (e) {
      if (e is DioError && e.response?.statusCode == 401) {
        if (e.response?.data["message"] == 'Unauthenticated') {
          print(e.response?.data["message"]);
          LocalStorage.writeBool(GetXStorageConstants.userLogin, true);
        }}}}

  @override
  Widget build(BuildContext context) {
    return const TutorLmsScaffold(
      body: TutorLmsConatiner(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(Images.splash),
          )
        ),
      ),
    );
  }
}

