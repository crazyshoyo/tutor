import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:tutor_lms/data.datasource/remote/models/response/all_course.dart';
import 'package:tutor_lms/presentation/dashboard/dashboard.dart';
import 'package:tutor_lms/widgets/common_appbar.dart';
import 'package:tutor_lms/widgets/ozstaff_loader.dart';
import '../../constants/appcolor.dart';
import '../../constants/apptextstyle.dart';
import '../../constants/fontsize.dart';
import '../../data.datasource/remote/services/apis.dart';
import '../../widgets/spacing.dart';
import '../../widgets/tb_cached_image.dart';
import '../../widgets/tutor_lms_container.dart';
import '../../widgets/tutor_text.dart';
import '../Course/Course.dart';
import '../Homepage/home_controller.dart';
class AllCourse_bottom extends StatefulWidget {
  const AllCourse_bottom({super.key});
  @override
  State<AllCourse_bottom> createState() => _AllCourse_bottomState();
}

class _AllCourse_bottomState extends State<AllCourse_bottom> {
  final HomepageController homeController = Get.put(HomepageController());
  late bool loading;
  late ScrollController scrollController;
  late bool isLastPage;
  late int pageNumber;
  late bool error;
  bool hasData = true;
  bool pageLoading = false;
  late int numberOfPostsPerRequest;
  List<Course> allCourse = [];
  @override
  void initState() {
    pageNumber = 1;
    isLastPage = false;
    loading = true;
    error = false;
    numberOfPostsPerRequest = 10;
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    fetchData();
    super.initState();
  }

  void _scrollListener() {
    if (scrollController.offset == scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      pageNumber++;
      fetchData();
    }
  }

  Future<void> fetchData() async {
    setState(() {
      pageLoading = true;

    });
    try {
      final response = await get(Uri.parse("${Apis.baseUrl}/api/all-courses/?page=$pageNumber&limit=$numberOfPostsPerRequest"));
      var responseList = allCourseResponseFromJson(response.body);
      if(allCourse.length< numberOfPostsPerRequest) {
        setState(() {
          hasData = false;
        });
      }
      setState(() {
          loading = false;
          pageLoading = false;
        allCourse.addAll(responseList.courses ?? []);
      });
    } catch (e) {
      print("error --> $e");
      setState(() {
        loading = false;
        error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        top: true,
        child: Scaffold(
            appBar: PreferredSize(preferredSize: Size.fromHeight(Dimensions.h_50), child:  const TutorLmsAppbar(title: "Courses",
              hideBack: true,)),
            body: loading ? const Center(child: TutorActivityIndicator()): Padding(
              padding:  EdgeInsets.only(top: Dimensions.h_15),
              child: GridView.builder(
                controller: scrollController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 2/2.3,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 20,
                  crossAxisCount: 2,
                ),
                itemCount: allCourse.length + 1,
                itemBuilder: (context, index) {
                  if(index<allCourse.length) {
                    return Padding(
                      padding:  EdgeInsets.only(left: Dimensions.w_10),
                      child: GestureDetector(
                        onTap: () => Navigator.pushReplacement(
                            context, MaterialPageRoute(
                            builder: (context) => CourseTutor(slug: allCourse[index].slug ?? '', id: allCourse[index].courseId ?? 0,))),
                        child: TutorLmsConatiner(
                          width: Dimensions.w_185,
                          margin: EdgeInsets.only(
                            right: Dimensions.w_10,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).cardColor),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.zero,
                                height: Dimensions.h_100,
                                margin: EdgeInsets.zero,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10)
                                    ),
                                    image: DecorationImage(image: NetworkImage(allCourse[index].image ?? ''),fit: BoxFit.cover)
                                ),
                              ),
                              VerticalSpacing(height: Dimensions.h_13),
                              Padding(
                                padding:  EdgeInsets.only(left: Dimensions.w_10,right: Dimensions.w_10),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    TutorLmsTextWidget(
                                        textAlign: TextAlign.start,
                                        title: allCourse[index]
                                            .category?.name ?? '',
                                        style: AppTextStyle.normalTextStyle(
                                            FontSize.sp_10,
                                            AppColor.appColor)),
                                  ],
                                ),
                              ),
                              VerticalSpacing(height: Dimensions.h_5),
                              Padding(
                                padding:  EdgeInsets.only(left: Dimensions.w_10,right: Dimensions.w_10),
                                child: TutorLmsTextWidget(
                                    textOverflow: TextOverflow.clip,
                                    textAlign: TextAlign.start,
                                    title: allCourse[index].title ?? '',
                                    style: AppTextStyle.normalTextStyle(FontSize.sp_12, Theme.of(context).highlightColor)),
                              ),
                              VerticalSpacing(height: Dimensions.h_5),
                              Padding(
                                padding:  EdgeInsets.only(left: Dimensions.w_10,right: Dimensions.w_10),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    TutorLmsTextWidget(
                                        textAlign: TextAlign.start,
                                        title:
                                        '${allCourse[index].videos?.length.toString()} lesson',
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
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else if(pageLoading == true) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 2),
                        child: CupertinoActivityIndicator(
                          radius: 14,
                        ),
                      ),
                    );

                  } else if(hasData == false) {
                    return  Center(
                      child: Padding(
                        padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width / 2),
                        child: TutorLmsTextWidget(title: 'Sorry no more data', style: AppTextStyle.themeBoldNormalTextStyle(
                            fontSize: FontSize.sp_16,color: Theme.of(context).highlightColor
                        )),
                      ),
                    );
                  }
                },
              ),
            )
        ),
      ),
    );;
  }
}
