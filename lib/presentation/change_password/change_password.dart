import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_lms/presentation/dashboard/dashboard.dart';
import 'package:tutor_lms/presentation/tutor_lm_scaffold.dart';
import 'package:tutor_lms/widgets/common_appbar.dart';
import 'package:tutor_lms/widgets/tutor_lms_container.dart';
import 'package:tutor_lms/widgets/tutor_text.dart';
import 'package:tutor_lms/widgets/tutor_textfield.dart';
import '../../constants/apptextstyle.dart';
import '../../constants/constants.dart';
import '../../constants/fontsize.dart';
import '../../widgets/spacing.dart';
import '../../widgets/tutorlms_textbutton.dart';
import '../Account/Account.dart';
import '../validate/validators.dart';
import 'change_password_controller.dart';


class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}
class _ChangePasswordState extends State<ChangePassword> {
 final ChangePasswordController changePasswordController = Get.put(ChangePasswordController());
  @override
  Widget build(BuildContext context) {
    return TutorLmsConatiner(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor
      ),
      child: GetBuilder(
        init: changePasswordController,
        id: ControllerBuilders.changePasswordController,
        builder: (controller) {
          return SafeArea(
            child: TutorLmsScaffold(
              isLoading: controller.isLoading,
                body: Form(
                  key: controller.changePasswordKey,
                  child: Padding(
                    padding:  EdgeInsets.only(left: Dimensions.w_20,right: Dimensions.w_20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          VerticalSpacing(height: Dimensions.h_20),
                          ListTile(
                            onTap: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DashBoard(index: 3)));
                            },
                            leading: Icon(Icons.arrow_back,color: Theme.of(context).shadowColor,),
                            title: TutorLmsTextWidget(title: 'Change Password', style: AppTextStyle.normalTextStyle(FontSize.sp_18, Theme.of(context).highlightColor)),
                          ),
                          VerticalSpacing(height: Dimensions.h_30),
                          Padding(
                            padding:  EdgeInsets.only(left: Dimensions.w_8,bottom: Dimensions.h_5),
                            child: TutorLmsTextWidget(title: 'Old Password ', style: AppTextStyle.normalTextStyle(FontSize.sp_15,Theme.of(context).highlightColor)),
                          ),
                          TutorLmsTextField(hintText: 'Enter Old Password', title: 'Old Password', controller: controller.oldPasswordController,validator: Validator.passwordOldValidate),
                          // VerticalSpacing(height: Dimensions.h_20),
                          Padding(
                            padding:  EdgeInsets.only(left: Dimensions.w_8,bottom: Dimensions.h_5),
                            child: TutorLmsTextWidget(title: 'New Password ', style: AppTextStyle.normalTextStyle(FontSize.sp_15,Theme.of(context).highlightColor)),
                          ),
                          TutorLmsTextField(hintText: 'Enter New Password ', title: 'Enter New Password', controller: controller.newPasswordController,validator: Validator.passwordNewValidate,),
                          // VerticalSpacing(height: Dimensions.h_20),
                          Padding(
                            padding:  EdgeInsets.only(left: Dimensions.w_8,bottom: Dimensions.h_5),
                            child: TutorLmsTextWidget(title: 'Confirm Password ', style: AppTextStyle.normalTextStyle(FontSize.sp_15,Theme.of(context).highlightColor)),
                          ),
                          TutorLmsTextField(hintText: 'Enter Confirm password', title: 'Enter Confirm password', controller: controller.confirmPasswordController,validator: Validator.passwordConfirmValidate,),
                          VerticalSpacing(height: Dimensions.h_1),
                          TutorLmsTextButton(
                            labelName: 'Change Password',
                            margin: EdgeInsets.only(top: Dimensions.h_12),
                           onTap: (){
                             controller.onResetButton(context);
                             // Get.snackbar('Change Password Successfully', '');
                           } )
                        ],
                      ),
                    ),
                  ),
                )
            ),
          );
        },
      ),
    );
  }
}
