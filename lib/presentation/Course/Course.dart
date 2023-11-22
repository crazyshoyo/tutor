import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_lms/constants/appcolor.dart';
import 'package:tutor_lms/constants/apptextstyle.dart';
import 'package:tutor_lms/constants/constants.dart';
import 'package:tutor_lms/constants/fontsize.dart';
import 'package:tutor_lms/presentation/Course/course_controller.dart';
import 'package:tutor_lms/presentation/dashboard/dashboard.dart';
import 'package:tutor_lms/widgets/common_appbar.dart';
import 'package:tutor_lms/widgets/player/pod_player.dart';
import 'package:tutor_lms/widgets/spacing.dart';
import 'package:tutor_lms/widgets/tb_cached_image.dart';
import 'package:tutor_lms/widgets/tutor_lms_container.dart';
import 'package:tutor_lms/widgets/tutor_text.dart';
import 'package:flutter_html/flutter_html.dart' as flutter_html;
import '../../constants/images.dart';
import '../../widgets/tutorlms_textbutton.dart';

class CourseTutor extends StatefulWidget {
  final String slug;
  const CourseTutor({super.key,required this.slug});
  @override
  State<CourseTutor> createState() => _CourseTutorState();
}

class _CourseTutorState extends State<CourseTutor> {
  final CourseController courseController = Get.put(CourseController());
  late PodPlayerController videoController;

  @override
  void initState() {
    get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: courseController,
      id: ControllerBuilders.courseController,
      builder: (controller) {
      return  WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          return false;
        },
        child: SafeArea(
          child: Scaffold(
            appBar: PreferredSize(preferredSize: Size.fromHeight(Dimensions.h_50), child:  TutorLmsAppbar(onTap: ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> DashBoard(index: 0))),color: Theme.of(context).cardColor,)),
            bottomNavigationBar: Padding(
              padding:  EdgeInsets.only(left: Dimensions.w_15,right: Dimensions.w_15),
              child: Container(
                color: Theme.of(context).cardColor,
                padding: EdgeInsets.only(top: Dimensions.h_10),
                child: TutorLmsTextButton(
                  loading: controller.buttonLoading,
                  labelName: "Enrol now",
                  style: AppTextStyle.buttonTextStyle(
                      color: AppColor.white),
                  onTap: () {
                    controller.onEnroll(context, controller.course?.id ?? 0);
                  },
                  margin: EdgeInsets.only(top: Dimensions.h_8,bottom: Dimensions.h_10,left: Dimensions.w_20,right: Dimensions.w_20),
                  color: AppColor.appColor,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PodVideoPlayer(controller: videoController),
                  VerticalSpacing(height: Dimensions.h_10),
                  Padding(
                    padding:  EdgeInsets.only(left: Dimensions.w_20,right: Dimensions.w_20),
                    child: TutorLmsTextWidget(
                      textOverflow: TextOverflow.visible,
                        title: controller.course?.title ?? '- - -', style: AppTextStyle.themeBoldTextStyle(fontSize: FontSize.sp_18, color: Theme.of(context).highlightColor)),
                  ),
                  VerticalSpacing(height: Dimensions.h_10),
                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.w_20,right: Dimensions.w_20),
                    child: TutorLmsTextWidget(
                        textOverflow: TextOverflow.visible,
                        title: controller.course?.shortDesc ?? '---', style: AppTextStyle.normalTextStyle(FontSize.sp_14, Theme.of(context).shadowColor)),
                  ),
                  VerticalSpacing(height: Dimensions.h_20),
                  Padding(
                    padding:  EdgeInsets.only(left: Dimensions.w_20,right: Dimensions.w_20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TutorLmsTextWidget(title: 'Category', style: AppTextStyle.themeBoldNormalTextStyle(fontSize: FontSize.sp_13, color: AppColor.appColor)),
                            TutorLmsTextWidget(title: controller.course?.category?.name ?? '---', style: AppTextStyle.themeBoldNormalTextStyle(fontSize: FontSize.sp_13,color: Theme.of(context).shadowColor))
                          ],
                        ),
                        HorizontalSpacing(width: Dimensions.w_50),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TutorLmsTextWidget(title: 'Last Updated', style: AppTextStyle.themeBoldNormalTextStyle(fontSize: FontSize.sp_13, color: AppColor.appColor)),
                            TutorLmsTextWidget(title: controller.formatDate.toString() ?? '', style: AppTextStyle.themeBoldNormalTextStyle(fontSize: FontSize.sp_13, color: Theme.of(context).shadowColor))
                          ],
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            controller.onShareButton(controller.course?.title ?? 'meow');
                          },
                          child: TutorLmsConatiner(
                            height: Dimensions.h_35,
                            width: Dimensions.w_35,
                            decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                shape: BoxShape.circle
                            ),
                            child:  Center(
                              child: Icon(Icons.share,size: 15,color: Theme.of(context).shadowColor),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  VerticalSpacing(height: Dimensions.h_10),
                  Divider(
                    color: Theme.of(context).shadowColor,
                    height: 20,
                    endIndent: 20,
                    indent: 20,
                    // indent: 3,
                  ),
                  VerticalSpacing(height: Dimensions.h_10),
                  Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: Theme(
                      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                      child:  ExpansionTile(
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        collapsedBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        iconColor:Theme.of(context).shadowColor,
                        collapsedIconColor: Theme.of(context).shadowColor,
                        textColor:Theme.of(context).shadowColor,
                        title: TutorLmsTextWidget(title: 'OverView', style: AppTextStyle.normalTextStyle(FontSize.sp_20, Theme.of(context).highlightColor)),
                        children:  [
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.course?.videos?.length ?? 0,
                              itemBuilder: (c,i) {
                                return Padding(
                                  padding:  EdgeInsets.only(left: Dimensions.w_20,right: Dimensions.w_20,top: Dimensions.h_15),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TutorLmsTextWidget(title: "${i+1}", style: AppTextStyle.themeBoldTextStyle(fontSize: FontSize.sp_20, color:Theme.of(context).shadowColor)),
                                      HorizontalSpacing(width: Dimensions.w_20),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                              width: Dimensions.w_230,
                                              child: TutorLmsTextWidget(maxLines: 3,textOverflow: TextOverflow.visible,title: controller.course?.videos?[i].title ?? '', style: AppTextStyle.normalTextStyle(FontSize.sp_16, Theme.of(context).highlightColor))),
                                          TutorLmsTextWidget(title: (controller.course?.videos?[i].videoLength.toString() !=null) ? (controller.course?.videos?[i].videoLength.toString() ?? '') : '0.00' , style: AppTextStyle.normalTextStyle(FontSize.sp_13,AppColor.appColor)),
                                        ],
                                      ),
                                      const Spacer(),
                                      TutorLmsConatiner(
                                        height: Dimensions.h_25,
                                        width: Dimensions.h_25,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(image: AssetImage(controller.course?.videos?[i].isPreview == true ? Images.play : Images.locked))
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
                  VerticalSpacing(height: Dimensions.h_10),
                  Padding(
                    padding:  EdgeInsets.only(left: Dimensions.w_20,right: Dimensions.w_20),
                    child:  flutter_html.Html(
                      data: controller.course?.overview ?? '',
                      style: {
                        '#': flutter_html.Style(
                          color:
                         Theme.of(context).shadowColor,
                        ),
                      },
                    ),
                  ),
                  VerticalSpacing(height: Dimensions.h_15),
                  Padding(
                    padding:  EdgeInsets.only(left:Dimensions.w_20),
                    child: TutorLmsTextWidget(title: 'Course Video', style: AppTextStyle.normalTextStyle(FontSize.sp_20, Theme.of(context).highlightColor)),
                  ),
                  VerticalSpacing(height: Dimensions.h_5),

                  VerticalSpacing(height: Dimensions.h_30),
                  Padding(
                    padding:  EdgeInsets.only(left: Dimensions.w_20),
                    child: TutorLmsTextWidget(title: 'What You will learn', style: AppTextStyle.normalTextStyle(FontSize.sp_20, Theme.of(context).highlightColor)),
                  ),
                  VerticalSpacing(height: Dimensions.h_10),
                  Padding(
                    padding: EdgeInsets.only(right: Dimensions.w_20),
                    child: flutter_html.Html(
                      data: controller.course?.whatYouWillLearn ?? '',
                      style: {
                        '#': flutter_html.Style(
                          color: Theme.of(context).shadowColor,
                        ),
                      },
                    ),
                  ),
                  VerticalSpacing(height: Dimensions.h_20),
                  Padding(
                    padding:  EdgeInsets.only(left: Dimensions.w_20),
                    child: TutorLmsTextWidget(title: 'Requirements', style: AppTextStyle.normalTextStyle(FontSize.sp_16, Theme.of(context).highlightColor)),
                  ),
                  VerticalSpacing(height: Dimensions.h_3),
                  Padding(
                    padding:  EdgeInsets.only(left: Dimensions.w_20),
                    child: TutorLmsTextWidget(title: controller.course?.requirements ?? '', style: AppTextStyle.normalTextStyle(FontSize.sp_16, Theme.of(context).shadowColor)),
                  ),
                  VerticalSpacing(height: Dimensions.h_20),
                  Padding(
                    padding:  EdgeInsets.only(left: Dimensions.w_20),
                    child: TutorLmsTextWidget(title: 'Meet Your Instructors', style: AppTextStyle.normalTextStyle(FontSize.sp_16, Theme.of(context).highlightColor)),
                  ),
                  VerticalSpacing(height: Dimensions.h_20),
                  Padding(
                    padding:  EdgeInsets.only(left: Dimensions.w_20),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: TlCachedNetworkImage(
                            imageUrl: controller.course?.user?.profilePhoto ?? '',
                          ),),
                        HorizontalSpacing(width: Dimensions.w_20),
                        TutorLmsTextWidget(title: "${controller.course?.user?.firstName ?? ''} ${controller.course?.user?.lastName ?? ''}",style: AppTextStyle.normalTextStyle(FontSize.sp_16, Theme.of(context).highlightColor),),
                      ],
                    ),
                  ),
                  VerticalSpacing(height: Dimensions.h_20),
                  Padding(
                    padding:  EdgeInsets.only(left: Dimensions.w_20),
                    child: TutorLmsTextWidget(textOverflow: TextOverflow.visible,title: controller.course?.user?.bio ?? '', style: AppTextStyle.normalTextStyle(FontSize.sp_13, Theme.of(context).shadowColor)),
                  ),
                  VerticalSpacing(height: Dimensions.h_20),
                ],
              ),
            ),
          ),
        ),
      );
      },
    );
  }

  get() async {
    await courseController.onCourse(context, widget.slug);
    videoController = PodPlayerController(
        playVideoFrom: PlayVideoFrom.vimeo(courseController.course?.videos?[0].video ?? ''),
        podPlayerConfig: const PodPlayerConfig(
          autoPlay: true,
          isLooping: false,
          videoQualityPriority: [1080,720, 360],
        )
    )..initialise();
  }

  @override
  void dispose() {
    videoController.dispose();
    Get.delete<CourseController>();
    super.dispose();
  }
  }

