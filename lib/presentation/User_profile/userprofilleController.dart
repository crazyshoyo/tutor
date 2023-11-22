import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_lms/data.datasource/remote/models/response/UserUpdate.dart';
import '../../constants/constants.dart';
import '../../core/error/failures.dart';
import '../../data.datasource/Repository_imp/auth_repository_imp.dart';
import '../../data.datasource/remote/models/request/userprofile_request.dart';
import '../../widgets/tutor_lms_toast.dart';

class UserprofileController extends GetxController {
  bool isLoading = false;
  TextEditingController  gender=TextEditingController();
  TextEditingController firstNameController=TextEditingController();
  TextEditingController lastNameController=TextEditingController();
  TextEditingController websiteUrlController=TextEditingController();
  TextEditingController facebookController=TextEditingController();
  TextEditingController youtubeController=TextEditingController();
  TextEditingController linkedinController=TextEditingController();
  TextEditingController twitterController=TextEditingController();
  TextEditingController bioController=TextEditingController();
  UserDetails? user;
  final AuthRepositoryImpl repositoryImpl = AuthRepositoryImpl();
  GlobalKey<FormState> firstNameKey = GlobalKey<FormState>();



  onProfile(BuildContext context) async {
    isLoading = true;
    var data = await repositoryImpl.user();
    data.fold((l) {
      if (l is ServerFailure) {
        isLoading = false;
        ToastUtils.showCustomToast(context, l.message ?? '', false);
      }
    }, (r) {
      user = r.user;
      isLoading = false;
      update([ControllerBuilders.userProfileController]);
    });
    update([ControllerBuilders.userProfileController]);
  }

  onProfileButton(BuildContext context) async {
        isLoading = true;
        update([ControllerBuilders.userProfileController]);
        var request = ProfileRequest(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          website: websiteUrlController.text,
          facebook: facebookController.text,
          youtube: youtubeController.text,
          linkedin: linkedinController.text,
          bio: bioController.text,
          twitter: twitterController.text,
          gender: gender.toString(),
        );
        var data = await repositoryImpl.userProfile(request);
        data.fold((l) {
          if (l is ServerFailure) {
            ToastUtils.showCustomToast(context, l.message ?? '', false);
            isLoading = false;
          }
        }, (r) {
              isLoading = false;
              ToastUtils.showCustomToast(context, r.message ?? '', true);
              update([ControllerBuilders.userProfileController]);
        }
        );
        update([ControllerBuilders.changePasswordController]);
      }

    }

