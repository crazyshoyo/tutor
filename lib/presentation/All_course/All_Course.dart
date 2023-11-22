import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:tutor_lms/data.datasource/remote/services/apis.dart';
import 'package:tutor_lms/presentation/dashboard/dashboard.dart';
import 'package:tutor_lms/widgets/common_appbar.dart';
import '../../constants/appcolor.dart';
import '../../constants/apptextstyle.dart';
import '../../constants/fontsize.dart';
import '../../data.datasource/remote/models/response/all_Course.dart';
import '../../widgets/spacing.dart';
import '../../widgets/tb_cached_image.dart';
import '../../widgets/tutor_lms_container.dart';
import '../../widgets/tutor_text.dart';
import '../Course/Course.dart';
import '../Homepage/home_controller.dart';
class AllCourse extends StatefulWidget {
  const AllCourse({super.key});
  @override
  State<AllCourse> createState() => _AllCourseState();
}

class _AllCourseState extends State<AllCourse> {
  final HomepageController homeController = Get.put(HomepageController());
  late bool loading;
  late ScrollController scrollController;
  late bool isLastPage;
  late int pageNumber;
  late bool error;
  late int numberOfPostsPerRequest;
  List<Course> allCourse = [];

  @override
  void initState() {
    pageNumber = 1;
    isLastPage = false;
    loading = true;
    error = false;
    numberOfPostsPerRequest = 12;
    scrollController = ScrollController();
    fetchData();
    super.initState();
  }


  Future<void> fetchData() async {
    try {
      final response = await get(Uri.parse("${Apis.baseUrl}/api/all-courses/?page=$pageNumber&limit=$numberOfPostsPerRequest"));
      var responseList = allCourseResponseFromJson(response.body);
      setState(() {
        isLastPage = allCourse.length < numberOfPostsPerRequest;
        loading = false;
        pageNumber = pageNumber + 1;
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
    scrollController.addListener(() {
      var nextPageTrigger = 0.8 * scrollController.position.maxScrollExtent;
      if (scrollController.position.pixels > nextPageTrigger) {
        loading = true;
        fetchData();
      }
    });
    return SafeArea(
      top: true,
      child: Scaffold(
          appBar: PreferredSize(preferredSize: Size.fromHeight(Dimensions.h_45), child: TutorLmsAppbar(onTap: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> DashBoard(index: 0)));
          },)),
          body: loading ? const Center(
            child: CupertinoActivityIndicator(),
          ): GridView.builder(
            controller: scrollController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 2/2.8,
              crossAxisSpacing: 5,
              mainAxisSpacing: 15,
              crossAxisCount: 2,
            ),
            itemCount: allCourse.length + (isLastPage ? 0 : 1),
            itemBuilder: (context, index) {
              if (index == allCourse.length) {
                if (error) {
                  return const Center(
                      child: Text("Error")
                  );
                }
              }
              return SizedBox(
                  height: Dimensions.h_230,
                  child: GestureDetector(
                    onTap: () => Navigator.pushReplacement(
                        context, MaterialPageRoute(
                        builder: (context) => CourseTutor(slug: allCourse[index].slug ?? ''))),
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
                                imageUrl: allCourse[index].image ?? '',
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
                                  title: allCourse[index]
                                      .category?.name ?? '',
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
                                title: allCourse[index].title ?? '',
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
                        ],
                      ),
                    ),
                  )
              );
            },
          )
      ),
    );
  }
}