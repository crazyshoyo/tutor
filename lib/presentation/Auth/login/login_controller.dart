
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_lms/approutes.dart';
import 'package:tutor_lms/data.datasource/local/local_storage.dart';
import '../../../constants/constants.dart';
import '../../../core/error/failures.dart';
import '../../../data.datasource/Repository_imp/auth_repository_imp.dart';
import '../../../data.datasource/remote/models/request/login_request.dart';
import '../../../widgets/tutor_lms_toast.dart';

class LoginController extends GetxController {
  final emailNodeFocus = FocusNode();
  final passwordNodeFocus = FocusNode();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool closeEye = true;
  bool isPhone = false;
  bool isEmail = true;
  bool isLoading = false;
  AuthRepositoryImpl repositoryImpl = AuthRepositoryImpl();
  String? token;

  changeEye() {
    closeEye = !closeEye;
    update([ControllerBuilders.loginPageController]);
  }
  emailButton (BuildContext context) {
    isEmail = true;
    isPhone = false;
    update([ControllerBuilders.loginPageController]);
  }
  phoneButton(BuildContext context) {
    isEmail = false;
    isPhone = true;
    update([ControllerBuilders.loginPageController]);
  }

  login(BuildContext context,String token) async {
    isLoading = true;
    update([ControllerBuilders.loginPageController]);
    var request = LoginRequest(
      email: emailTextController.text,
      password: passwordTextController.text,
      token: token

    );
    var data = await repositoryImpl.login(request);
    data.fold((l) {
      if (l is ServerFailure) {
        ToastUtils.showCustomToast(context, l.message ?? '', false);
        isLoading = false;
        update([ControllerBuilders.loginPageController]);

      }
    }, (r) {
      isLoading = false;
      ToastUtils.showCustomToast(context, r.message ?? '', true);
      LocalStorage.setAuthToken(r.elarnivUsersToken);
      LocalStorage.writeBool(GetXStorageConstants.isLogin, true);
      LocalStorage.writeBool(GetXStorageConstants.userLogin, false);
      update([ControllerBuilders.loginPageController]);
      emailTextController.clear();
      passwordTextController.clear();
      Get.toNamed(AppRoutes.dashBoard);
    }
    );
    update([ControllerBuilders.loginPageController]);
  }

}


