import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_lms/constants/appcolor.dart';
import 'package:tutor_lms/constants/apptextstyle.dart';
import 'package:tutor_lms/constants/constants.dart';
import 'package:tutor_lms/constants/fontsize.dart';
import 'package:tutor_lms/data.datasource/local/local_storage.dart';
import 'package:tutor_lms/data.datasource/remote/services/apis.dart';
import 'package:tutor_lms/presentation/All_course/All_Course.dart';
import 'package:tutor_lms/presentation/Course/Course.dart';
import 'package:tutor_lms/presentation/Homepage/home_controller.dart';
import 'package:tutor_lms/presentation/Notification/Notification.dart';
import 'package:tutor_lms/presentation/category_api_meta_mask_connect_piccadlly_meta_boxfy_dj/category_choota.dart';
import 'package:tutor_lms/widgets/ozstaff_loader.dart';
import 'package:tutor_lms/widgets/spacing.dart';
import 'package:tutor_lms/widgets/tutor_lms_container.dart';
import 'package:tutor_lms/widgets/tutor_text.dart';
import '../../constants/images.dart';
import 'package:http/http.dart' as http;
import '../../data.datasource/remote/models/response/CategeriesResponse.dart';
import '../../data.datasource/remote/models/response/dashboardResponse.dart';
import '../../data.datasource/remote/models/response/learning_model.dart';
import '../../data.datasource/remote/services/dio/rest_client.dart';
import '../../widgets/tb_cached_image.dart';
import '../TutorLmssearch_page.dart';
import '../membership/membershipplan.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  bool isLoading=false;
  bool loading = false;
  List<Recent> recent = [];
  final restClient = Get.put(RestClient());
  List<LearningResponse> learning = [];
  List<LearningResponse> learningData = [];
  final HomepageController homeController = Get.put(HomepageController());
  List<String> tutorlmsimage = [
    Images.art,
    Images.coding,
    Images.marketing,
    Images.business,
    Images.music
  ];
  List<Category>? category;
  @override
  void initState() {
    recentlearning();
    categeries();
    homeController.onResetBanner(context);
    homeController.onProfile(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomepageController>(
        id: ControllerBuilders.homeController,
        init: homeController,
        builder: (controller) {
          return SafeArea(
            top: true,
            child: Scaffold(
              appBar: PreferredSize(preferredSize: Size.fromHeight(Dimensions.h_40), child:  ListTile(
                leading: SizedBox(
                    height: Dimensions.h_35,
                    width: Dimensions.h_35,
                    child: Image.asset(Images.avatar)),
                title: TutorLmsTextWidget(
                  title: 'Hello ',
                  style: AppTextStyle.normalTextStyle(
                      FontSize.sp_12,
                      Theme.of(context).shadowColor),
                ),
                subtitle: TutorLmsTextWidget(
                    title: "${controller.user?.firstName ?? ''} ${controller.user?.lastName ?? ''}",
                    style: AppTextStyle.normalTextStyle(
                        FontSize.sp_16,
                        Theme.of(context).highlightColor)),
                trailing: GestureDetector(
                    onTap: () {
                      LocalStorage.writeBool(GetXStorageConstants.exchangeFromHome, false);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                              const TutorNotification()));
                    },
                    child: Image.asset(Images.new_notification)),
              ),),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              body: controller.loading ? const Center(child: TutorActivityIndicator()) :Padding(
                padding: EdgeInsets.only(
                    top: Dimensions.h_15,
                    left: Dimensions.w_20,
                    right: Dimensions.w_20
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      VerticalSpacing(height: Dimensions.h_20),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> TutorLmsSearchPage(homepageController: controller)));
                        },
                        child: SizedBox(
                          height: Dimensions.h_40,
                          child: TextFormField(
                            enabled: false,
                            cursorColor: Theme.of(context).shadowColor,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: Dimensions.h_5,bottom: Dimensions.h_2),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(Dimensions.h_20),
                                  borderSide: BorderSide(
                                      color: Theme.of(context).cardColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(Dimensions.h_20),
                                  borderSide: BorderSide(
                                      color: Theme.of(context).cardColor),
                                ),
                                filled: true,
                                fillColor: Theme.of(context).cardColor,
                                prefixIcon: Icon(
                                  Icons.search,
                                  size: Dimensions.h_18,
                                  color: Theme.of(context).shadowColor,
                                ),
                                // suffixIcon: Icon(
                                //   Icons.menu_open,
                                //   size: Dimensions.h_18,
                                //   color: Theme.of(context).shadowColor,
                                // ),
                                hintText: 'Find Course',
                                hintStyle: AppTextStyle.normalTextStyle(FontSize.sp_14, Theme.of(context).shadowColor),
                                hintTextDirection: TextDirection.ltr),
                          ),
                        ),
                      ),
                      VerticalSpacing(height: Dimensions.h_20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TutorLmsTextWidget(
                              title: 'Categories',
                              style: AppTextStyle.themeBoldNormalTextStyle(
                                  fontSize: FontSize.sp_16,
                                  color:Theme.of(context).shadowColor)),
                          // GestureDetector(
                          //   onTap: (){
                          //     Navigator.push(context, MaterialPageRoute(builder: (context)=>const AllCourse()));
                          //   },
                          //   child: TutorLmsTextWidget(
                          //       title: 'See all',
                          //       style: AppTextStyle.normalTextStyle(
                          //           FontSize.sp_12, AppColor.appColor)),
                          // )
                        ],
                      ),
                      VerticalSpacing(height: Dimensions.h_10),
                      SizedBox(
                        height: Dimensions.h_40,
                        child: category?.isEmpty ?? false ? Center(
                          child: TutorLmsTextWidget(
                            title: 'No data found',style: AppTextStyle.normalTextStyle(FontSize.sp_16, Theme.of(context).highlightColor),
                          ),
                        ):ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: category?.length ?? 0,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap:  () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> MetaMaskConnect(slug: category?[index].slug ?? '')));
                              },
                              child: Padding(
                                padding: EdgeInsets.only(right: Dimensions.w_10),
                                child: Container(
                                    padding: EdgeInsets.only(left: Dimensions.w_10,right: Dimensions.w_10),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: TutorLmsTextWidget(
                                        title: category?[index].name ?? "null",
                                        style: AppTextStyle.normalTextStyle(
                                            FontSize.sp_12,
                                            Theme.of(context).shadowColor))),
                              ),
                            );
                          },
                        ),
                      ),
                      VerticalSpacing(height: Dimensions.h_20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TutorLmsTextWidget(
                              title: 'Recent Learning',
                              style: AppTextStyle.themeBoldNormalTextStyle(
                                  fontSize: FontSize.sp_14,
                                  color: Theme.of(context).shadowColor)),
                          // GestureDetector(
                          //   onTap: (){
                          //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const AllCourse()));
                          //   },
                          //   child: TutorLmsTextWidget(
                          //       title: 'See all',
                          //       style: AppTextStyle.normalTextStyle(
                          //           FontSize.sp_12, AppColor.appColor)),
                          // )
                        ],
                      ),
                      VerticalSpacing(height: Dimensions.h_10),
                      SizedBox(
                        height: Dimensions.h_50,
                        child: recent.isEmpty ?? true
                            ?  Center(
                            child: TutorLmsTextWidget(title: 'No recent leaning', style: AppTextStyle.normalTextStyle(FontSize.sp_16, Theme.of(context).highlightColor))
                        )
                            : isLoading ==false? ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:recent.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                                onTap: () {
                                  LocalStorage.writeBool(GetXStorageConstants.searchFromHome,false);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (c) => CourseTutor(
                                              slug: recent[index].course?.slug ?? '')));
                                } ,
                                child:  TutorLmsConatiner(
                                  margin: EdgeInsets.only(
                                    right: Dimensions.w_10,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(Dimensions.h_8),
                                      color: Theme.of(context).cardColor),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: Dimensions.h_50,
                                        width: Dimensions.w_100,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.h_8),bottomLeft: Radius.circular(Dimensions.h_8)),
                                            image: DecorationImage(
                                                fit: BoxFit.contain,
                                                image: NetworkImage(recent[index].course?.image ?? ''))
                                        ),
                                      ),
                                      HorizontalSpacing(width: Dimensions.w_10),
                                      SizedBox(
                                        width: Dimensions.w_70,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            VerticalSpacing(height: Dimensions.h_5),
                                            TutorLmsTextWidget(
                                                textAlign: TextAlign.start,
                                                textOverflow: TextOverflow.ellipsis,
                                                title: recent[index].course?.title ?? '',
                                                style: AppTextStyle.normalTextStyle(FontSize.sp_10, AppColor.appColor)),
                                            VerticalSpacing(height: Dimensions.h_5),
                                            TutorLmsTextWidget(
                                                textAlign: TextAlign.start,
                                                title:
                                                '${recent[index].video?.groupName?.length?? ''} lesson',
                                                style: AppTextStyle.normalTextStyle(
                                                    FontSize.sp_10,
                                                    Theme.of(context).shadowColor)),
                                            VerticalSpacing(height: Dimensions.h_10),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ));
                          },
                        ):const Center(
                          child: CircularProgressIndicator(
                            color: AppColor.appColor,
                          ),
                        ),
                      ),
                      VerticalSpacing(height: Dimensions.h_20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TutorLmsTextWidget(
                              title: 'Popular Courses',
                              style: AppTextStyle.themeBoldNormalTextStyle(
                                  fontSize: FontSize.sp_14,
                                  color: Theme.of(context).shadowColor)),
                          GestureDetector(
                            onTap: (){
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const AllCourse()));
                            },
                            child: TutorLmsTextWidget(
                                title: 'See all',
                                style: AppTextStyle.normalTextStyle(
                                    FontSize.sp_12, AppColor.appColor)),
                          )
                        ],
                      ),
                      VerticalSpacing(height: Dimensions.h_15),
                      SizedBox(
                        height: Dimensions.h_200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.bannerList.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (c) => CourseTutor(
                                          slug: controller
                                              .bannerList[index].slug ?? ''))),
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
                                    SizedBox(
                                      height: Dimensions.h_100,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(Dimensions.h_10),
                                            topRight: Radius.circular(Dimensions.h_10)
                                        ),
                                        child: TlCachedNetworkImage(
                                          imageUrl: controller
                                              .bannerList[index].image ?? '',
                                        ),
                                      ),
                                    ),
                                    VerticalSpacing(height: Dimensions.h_15),
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
                                              title: controller.bannerList[index]
                                                  .category?.name ?? '',
                                              style: AppTextStyle.normalTextStyle(
                                                  FontSize.sp_10,
                                                  AppColor.appColor)),
                                        ],
                                      ),
                                    ),
                                    VerticalSpacing(height: Dimensions.h_5),
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: Dimensions.w_10,right: Dimensions.w_10),
                                        child: TutorLmsTextWidget(
                                            textOverflow: TextOverflow.visible,
                                            textAlign: TextAlign.start,
                                            title: controller.bannerList[index].title ?? '',
                                            style: AppTextStyle.normalTextStyle(FontSize.sp_12, Theme.of(context).highlightColor)),
                                      ),
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
                                              '${controller.bannerList[index].videos?.length.toString()} lesson',
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
                            );
                          },
                        ),
                      ),
                      VerticalSpacing(height: Dimensions.h_20),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }




  ///Recent learning  Api
  recentlearning() async {
    setState(() {
      isLoading = true;

    });
    var response = await restClient.get(url: Apis.dashboardapi);
    var data = dashboardResponseFromJson(response);
    setState(() {
      recent.addAll(data.recent ?? []);
      isLoading = false;
    });
  }

  ///Categeries
  categeries() async {
    try {
      final response = await http.get(Uri.parse(Apis.categories));
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        var r = CategeriesResponse.fromJson(data);
        setState(() {
          category = r.categories;
        });
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }}