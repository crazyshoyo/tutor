import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_lms/presentation/tutor_lm_scaffold.dart';
import 'package:tutor_lms/widgets/tutor_lms_container.dart';
import 'package:tutor_lms/widgets/tutor_lms_toast.dart';
import 'package:tutor_lms/widgets/tutor_text.dart';
import 'package:tutor_lms/widgets/tutor_textfield.dart';
import '../../../approutes.dart';
import '../../../constants/appcolor.dart';
import '../../../constants/apptextstyle.dart';
import '../../../constants/constants.dart';
import '../../../constants/fontsize.dart';
import '../../../widgets/spacing.dart';
import '../../../widgets/tutorlms_textbutton.dart';
import '../../validate/validators.dart';
import 'forget_controller.dart';


class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final ForgotController forgotController = Get.put(ForgotController());
  @override
  Widget build(BuildContext context) {
    return  GetBuilder<ForgotController>(
      id: ControllerBuilders.forgotController,
      init: forgotController,
      builder: (controller) {
        return TutorLmsConatiner(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor
          ),
          child: SafeArea(
            child: TutorLmsScaffold(
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TutorLmsConatiner(
                        decoration: BoxDecoration(
                      ),
                      child: Padding(
                          padding:
                          EdgeInsets.only(
                              left: Dimensions.h_15, right: Dimensions.h_15,top: Dimensions.h_70),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: TutorLmsTextWidget(title: 'Forgot Password', style: AppTextStyle.themeBoldTextStyle(
                                    fontSize: FontSize.sp_24,
                                    color: Theme.of(context).highlightColor
                                )),
                              ),
                              VerticalSpacing(height: Dimensions.h_10),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: TutorLmsTextWidget(title: 'Send forgot password link to email address.', style: AppTextStyle.normalTextStyle(
                                    FontSize.sp_16,
                                    Theme.of(context).shadowColor
                                )),
                              ),
                              VerticalSpacing(height: Dimensions.h_40),

                              TutorLmsTextWidget(title: 'Email', style: AppTextStyle.normalTextStyle(FontSize.sp_16, Theme.of(context).shadowColor)),
                              VerticalSpacing(height: Dimensions.h_10),
                              TutorLmsTextField(
                                title: 'Email',
                                hintText: 'Email',
                                validator: Validator.emailValidate,
                                controller: controller.emailTextController),
                              VerticalSpacing(height: Dimensions.h_30),
                              TutorLmsTextButton(
                                loading: controller.loading,
                                labelName: "Send Link",
                                style: AppTextStyle.buttonTextStyle(
                                    color: AppColor.white),
                                onTap: () {
                                  controller.forgotByEmail(context);
                                },
                                margin: EdgeInsets.zero,
                                color: AppColor.appColor,
                              ),
                              VerticalSpacing(height: Dimensions.h_22),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TutorLmsTextButton(
                                    borderRadius: BorderRadius.circular(30),
                                    color: AppColor.transparent,
                                    style: AppTextStyle.themeBoldNormalTextStyle(
                                        fontSize: FontSize.sp_18,
                                        color: AppColor.white
                                    ),
                                    labelName: 'Do you remember password?',onTap: (){
                                    Get.toNamed(AppRoutes.loginScreen);
                                  },),
                                  TutorLmsTextButton(
                                    borderRadius: BorderRadius.circular(30),
                                    color: AppColor.transparent,
                                    style: AppTextStyle.themeBoldNormalTextStyle(
                                        fontSize: FontSize.sp_18,
                                        color: AppColor.appColor
                                    ),
                                    labelName: ' Log In ',onTap: (){
                                    Get.toNamed(AppRoutes.loginScreen);
                                  },),

                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        );
      }
    );
  }
}
