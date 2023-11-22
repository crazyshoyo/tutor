import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tutor_lms/constants/constants.dart';
import 'package:tutor_lms/core/error/failures.dart';
import 'package:tutor_lms/data.datasource/Repository_imp/course_repository_imp.dart';
import 'package:tutor_lms/data.datasource/Repository_imp/membership_repository_imp.dart';
import 'package:tutor_lms/data.datasource/remote/models/request/enroll_course_request.dart';
import 'package:tutor_lms/data.datasource/remote/models/response/singleCourseResponse.dart';
import 'package:tutor_lms/widgets/tutor_lms_toast.dart';

class CourseController extends GetxController {
  bool loading = false;
  final CourseRepositoryImpl repositoryImpl = CourseRepositoryImpl();
  final MemberRepositoryImpl memberRepositoryImpl = MemberRepositoryImpl();
  Course? course;
  String? videoUrl;
  DateTime? date ;
  String? formatDate;
  bool buttonLoading = false;

  onCourse(BuildContext context,String slug) async {
    loading = true;
    var data = await repositoryImpl.singleCourse(slug);
    data.fold((l) {
      if (l is ServerFailure) {
        loading = false;
        ToastUtils.showCustomToast(context, l.message ?? '', false);
      }
    }, (r) {
    course = r.course;
    videoUrl = r.course?.videos?[0].video;
    print("===================================================================$videoUrl");
    date =  DateTime.parse(r.course?.createdAt.toString() ?? '');
    formatDate = "${date?.year}-${date?.month.toString().padLeft(2, '0')}-${date?.day.toString().padLeft(2, '0')}";
    loading = false;
    update([ControllerBuilders.courseController]);
    });
    update([ControllerBuilders.courseController]);
  }

  onEnroll(BuildContext context,int courseId) async {
    buttonLoading = true;
    update([ControllerBuilders.courseController]);
    var req = EnrollRequest(courseId: courseId);
    var data = await memberRepositoryImpl.enroll(req);
    data.fold((l) {
      if (l is ServerFailure) {
        buttonLoading = false;
        update([ControllerBuilders.courseController]);
        ToastUtils.showCustomToast(context, l.message ?? '', false);
      }
    }, (r) {
      ToastUtils.showCustomToast(context, r.message ?? '', true);
      buttonLoading = false;
      update([ControllerBuilders.courseController]);
    });
    update([ControllerBuilders.courseController]);
  }

  onShareButton(String title) async {
    await Share.share(
        'Share to your friends\n\n https://tutorslms.com//$title');
    update([ControllerBuilders.courseController]);
  }
}