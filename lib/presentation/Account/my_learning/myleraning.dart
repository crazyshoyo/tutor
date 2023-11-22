import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tutor_lms/constants/constants.dart';
import 'package:tutor_lms/data.datasource/local/local_storage.dart';
import 'package:tutor_lms/presentation/Account/my_learning/learning_controller.dart';
import 'package:tutor_lms/presentation/tutor_lm_scaffold.dart';
import 'package:tutor_lms/widgets/common_appbar.dart';
import '../../../constants/appcolor.dart';
import '../../../constants/apptextstyle.dart';
import '../../../constants/fontsize.dart';
import '../../../data.datasource/remote/models/response/learning_model.dart';
import '../../../data.datasource/remote/services/apis.dart';
import '../../../widgets/spacing.dart';
import '../../../widgets/tb_cached_image.dart';
import '../../../widgets/tutor_lms_container.dart';
import '../../../widgets/tutor_text.dart';
import '../../Course/Course.dart';
import '../../dashboard/dashboard.dart';
class MyLearning extends StatefulWidget {
  const MyLearning({super.key});

  @override
  State<MyLearning> createState() => _MyLearningState();
}

class _MyLearningState extends State<MyLearning> {

 final LearningController learningController = Get.put(LearningController());

  @override
  void initState() {
    learningController.onLearning(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: learningController,
      id: ControllerBuilders.learningController,
      builder: (controller) {
        return   SafeArea(
          child: TutorLmsScaffold(
            appBar: PreferredSize(preferredSize: Size.fromHeight(Dimensions.h_60), child:
            TutorLmsAppbar(title: 'My Learnings',onTap: ()=> Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context)=> DashBoard(index: 3))),color: Theme.of(context).scaffoldBackgroundColor,)),
              body: Column(
                children: [
                  VerticalSpacing(height: Dimensions.h_10),
                  SizedBox(
                      height: Dimensions.h_230,
                      child: controller.loading ?  Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: Dimensions.h_80),
                          child: const CupertinoActivityIndicator(
                            radius: 15,
                          ),
                        ),
                      ) : (controller.list?.isNotEmpty ?? false) ? ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.list?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              LocalStorage.writeBool(GetXStorageConstants.searchFromHome, true);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (c) => CourseTutor(
                                          slug: controller.list?[index].course?.slug ?? '')));
                            } ,
                            child: TutorLmsConatiner(
                              width: Dimensions.w_185,
                              padding: EdgeInsets.only(top: Dimensions.h_10,bottom: Dimensions.h_10,left: Dimensions.w_12,right: Dimensions.w_12),
                              margin: EdgeInsets.only(
                                right: Dimensions.w_10,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context).cardColor),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: Dimensions.h_120,
                                    width: Dimensions.w_160,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: TlCachedNetworkImage(
                                        imageUrl:
                                        controller.list?[index].course?.image ?? '',
                                      ),
                                    ),
                                  ),
                                  VerticalSpacing(height: Dimensions.h_13),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      TutorLmsTextWidget(
                                          textAlign: TextAlign.start,
                                          title: controller.list?[index].course?.title ?? '',
                                          style: AppTextStyle.normalTextStyle(
                                              FontSize.sp_10,
                                              AppColor.appColor)),
                                    ],
                                  ),
                                  VerticalSpacing(height: Dimensions.h_5),
                                  Flexible(
                                    child: TutorLmsTextWidget(
                                        textOverflow: TextOverflow.visible,
                                        textAlign: TextAlign.start,
                                        title: controller.list?[index].course?.shortDesc ?? '',
                                        style: AppTextStyle.normalTextStyle(FontSize.sp_12, Theme.of(context).highlightColor)),
                                  ),
                                  VerticalSpacing(height: Dimensions.h_5),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      TutorLmsTextWidget(
                                          textAlign: TextAlign.start,
                                          title:
                                          '${controller.list?[index].course?.videos?.length} lesson',
                                          style: AppTextStyle.normalTextStyle(
                                              FontSize.sp_10,
                                              Theme.of(context).shadowColor)),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: Dimensions.w_10),
                                        child: GestureDetector(
                                          onTap: () {},
                                          child: TutorLmsConatiner(
                                            width: Dimensions.w_20,
                                            height: Dimensions.h_20,
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .shadowColor,
                                                shape: BoxShape.circle),
                                            child: Icon(
                                              Icons.arrow_forward,
                                              color: Theme.of(context)
                                                  .highlightColor,
                                              size: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                          :  Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: Dimensions.h_150),
                          child: Text("No items available",style: AppTextStyle.themeBoldNormalTextStyle(
                              fontSize: FontSize.sp_16,color: Theme.of(context).highlightColor
                          ),),
                        ),
                      )
                  ),
                ],
              )
          ),
        );
      },

    );
  }

}
