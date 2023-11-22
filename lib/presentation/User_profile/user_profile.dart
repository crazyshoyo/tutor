import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tutor_lms/presentation/Homepage/home_controller.dart';
import 'package:tutor_lms/presentation/User_profile/userprofilleController.dart';
import 'package:tutor_lms/presentation/dashboard/dashboard.dart';
import 'package:tutor_lms/presentation/tutor_lm_scaffold.dart';
import 'package:tutor_lms/widgets/tutor_lms_container.dart';
import 'package:tutor_lms/widgets/tutor_text.dart';
import 'package:tutor_lms/widgets/tutor_textfield.dart';
import '../../constants/apptextstyle.dart';
import '../../constants/constants.dart';
import '../../constants/fontsize.dart';
import '../../constants/images.dart';
import '../../widgets/spacing.dart';
import '../../widgets/tutorlms_textbutton.dart';
import '../validate/validators.dart';


class Profile extends StatefulWidget {
  const Profile({super.key});
  @override
  State<Profile> createState() => _ProfileState();
}
class _ProfileState extends State<Profile> {
  final  _picker = ImagePicker();
  File? frontImage;

  Future<void> openFrontImagePicker() async {
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      frontImage = File(pickedImage.path);
    }
  }
  final UserprofileController userprofileController = Get.put(UserprofileController());

  @override
  void initState() {
  getDetails();
    super.initState();
  }

  getDetails() async {
    await userprofileController.onProfile(context);
    userprofileController.firstNameController.text = userprofileController.user?.firstName ?? '';
    userprofileController.lastNameController.text = userprofileController.user?.lastName ?? '';
    userprofileController.gender.text = userprofileController.user?.gender ?? '';
    userprofileController.websiteUrlController.text = userprofileController.user?.website ?? '';
    userprofileController.twitterController.text = userprofileController.user?.twitter ?? '';
    userprofileController.facebookController.text = userprofileController.user?.facebook ?? '';
    userprofileController.linkedinController.text = userprofileController.user?.linkedin ?? '';
    userprofileController.youtubeController.text = userprofileController.user?.youtube ?? '';
    userprofileController.bioController.text = userprofileController.user?.bio ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return TutorLmsConatiner(
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor
      ),
      child: GetBuilder(
        init: userprofileController,
        id: ControllerBuilders.userProfileController,
        builder: (controller) {
          return SafeArea(
            child: TutorLmsScaffold(
                isLoading: controller.isLoading,
                body: Form(
                  key: controller.firstNameKey,
                  child: Padding(
                    padding:  EdgeInsets.only(left: Dimensions.w_20,right: Dimensions.w_20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          VerticalSpacing(height: Dimensions.h_20),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DashBoard(index: 3)));
                                  },
                                  child: Icon(Icons.arrow_back,color: Theme.of(context).shadowColor,)),
                              HorizontalSpacing(width: Dimensions.w_30),
                              TutorLmsTextWidget(title: 'User Profile', style: AppTextStyle.normalTextStyle(FontSize.sp_22, Theme.of(context).highlightColor))
                            ],
                          ),
                          VerticalSpacing(height: Dimensions.h_20),
                          Center(
                            child: Stack(
                              children: [
                                frontImage !=null ?
                                CircleAvatar(
                                  radius: Dimensions.h_50,
                                  foregroundImage:  FileImage(frontImage ?? File('')),
                                )
                                :  CircleAvatar(
                                  radius: Dimensions.h_50,
                                 foregroundImage: const AssetImage(Images.avatar),
                                ),
                                Positioned(
                                  right: Dimensions.w_8,
                                    top: Dimensions.h_100,
                                    child: GestureDetector(
                                      onTap: (){
                                        openFrontImagePicker();
                                      },
                                        child: Image.asset(Images.camera))),
                              ],
                            )
                          ),
                          VerticalSpacing(height: Dimensions.h_20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TutorLmsTextWidget(title: ' First name', style:AppTextStyle.normalTextStyle(FontSize.sp_13, Theme.of(context).shadowColor)),
                              HorizontalSpacing(width: Dimensions.w_100),
                              TutorLmsTextWidget(title: 'Last name', style:AppTextStyle.normalTextStyle(FontSize.sp_13, Theme.of(context).shadowColor)),

                            ],
                          ),
                          VerticalSpacing(height: Dimensions.h_5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TutorLmsTextField(
                                  title: 'First Name',
                                  hintText: 'First Name',
                                  validator: Validator.nameValidate,
                                  controller: controller.firstNameController,
                                ),
                              ),
                              HorizontalSpacing(width: Dimensions.w_20),
                              Expanded(
                                child: TutorLmsTextField(
                                  title: 'Last Name',
                                  hintText: 'Last Name',
                                  validator: Validator.nameValidate,
                                  controller: controller.lastNameController,
                                ),
                              ),
                            ],
                          ),
                          VerticalSpacing(height: Dimensions.h_10),
                          TutorLmsTextWidget(title: 'Gender', style:AppTextStyle.normalTextStyle(FontSize.sp_13, Theme.of(context).shadowColor)),
                          VerticalSpacing(height: Dimensions.h_5),
                          TutorLmsTextField(
                            title: 'Select Gender',
                            hintText: 'Select Gender',
                            controller: controller.gender,
                          ),
                          VerticalSpacing(height: Dimensions.h_10),
                          TutorLmsTextWidget(title: 'Website Url', style:AppTextStyle.normalTextStyle(FontSize.sp_13, Theme.of(context).shadowColor)),
                          VerticalSpacing(height: Dimensions.h_5),
                          TutorLmsTextField(
                            title: 'Website Url',
                            hintText: 'Website Url',
                            controller: controller.websiteUrlController,
                          ),
                          VerticalSpacing(height: Dimensions.h_10),
                          TutorLmsTextWidget(title: 'Twitter', style:AppTextStyle.normalTextStyle(FontSize.sp_13, Theme.of(context).shadowColor)),
                          VerticalSpacing(height: Dimensions.h_5),
                          TutorLmsTextField(
                            title: 'Twitter Url',
                            hintText: 'Twitter Url',
                            controller: controller.twitterController,
                          ),
                          VerticalSpacing(height: Dimensions.h_10),
                          TutorLmsTextWidget(title: 'Facebook', style:AppTextStyle.normalTextStyle(FontSize.sp_13, Theme.of(context).shadowColor)),
                          VerticalSpacing(height: Dimensions.h_5),
                          TutorLmsTextField(
                            title: 'Facebook Url',
                            hintText: 'Facebook Url',
                            controller: controller.facebookController,
                          ),
                          VerticalSpacing(height: Dimensions.h_10),
                          TutorLmsTextWidget(title: 'Linkedin', style:AppTextStyle.normalTextStyle(FontSize.sp_13, Theme.of(context).shadowColor)),
                          VerticalSpacing(height: Dimensions.h_5),
                          TutorLmsTextField(
                            title: 'Linkedin Url',
                            hintText: 'Linkedin Url',
                            controller: controller.linkedinController,
                          ),
                          VerticalSpacing(height: Dimensions.h_10),
                          TutorLmsTextWidget(title: 'Youtube', style:AppTextStyle.normalTextStyle(FontSize.sp_13, Theme.of(context).shadowColor)),
                          VerticalSpacing(height: Dimensions.h_5),
                          TutorLmsTextField(
                            title: 'Youtube Url',
                            hintText: 'Youtube Url',
                            controller: controller.youtubeController,
                          ),
                          VerticalSpacing(height: Dimensions.h_10),
                          TutorLmsTextWidget(title: 'Biography', style:AppTextStyle.normalTextStyle(FontSize.sp_13, Theme.of(context).shadowColor)),
                          VerticalSpacing(height: Dimensions.h_5),
                          TutorLmsTextField(
                            title: ' Bio',
                            hintText: 'Bio',
                            controller: controller.bioController,
                          ),
                          VerticalSpacing(height: Dimensions.h_10),
                          TutorLmsTextButton(
                              labelName: 'Save',
                              margin: EdgeInsets.only(top: Dimensions.h_12),
                              onTap: (){
                                controller.onProfileButton(context);
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



