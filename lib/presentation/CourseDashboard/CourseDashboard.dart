import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:tutor_lms/constants/fontsize.dart';
import 'package:tutor_lms/widgets/spacing.dart';
import '../../constants/apptextstyle.dart';
import '../../constants/images.dart';
import '../../data.datasource/remote/models/response/dashboardResponse.dart';
import '../../data.datasource/remote/services/apis.dart';
import '../../data.datasource/remote/services/dio/rest_client.dart';
import '../../widgets/tutor_text.dart';

class CourseDashboard extends StatefulWidget {
  @override  const CourseDashboard({super.key});
  State<CourseDashboard> createState() => _CourseDashboardState();
}
class _CourseDashboardState extends State<CourseDashboard> {
  final restClient = Get.put(RestClient());
  Courses?  courses;
  Membership? membership;
   List<Recent> recent = [];
   bool loading = false;
  @override
  void initState() {
    dashboard();
    super.initState();
  }
  Widget build(BuildContext context) {
    DateTime enrollmentDate = membership?.createdAt ?? DateTime(2023, 9, 28);
    String formattedDate = DateFormat.yMd().format(enrollmentDate);
    DateTime enrollmentDate1 = membership?.createdAt ?? DateTime(2023, 10, 28);
    String formattedDate1 = DateFormat.yMd().format(enrollmentDate1);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VerticalSpacing(height: Dimensions.h_50),
            Padding(
              padding:  EdgeInsets.only(left: Dimensions.w_20),
              child: TutorLmsTextWidget(title: 'Dashboard', style: AppTextStyle.themeBoldTextStyle(fontSize: FontSize.sp_22,color: Theme.of(context).highlightColor)),
            ),
            VerticalSpacing(height: Dimensions.h_40),
            Padding(
              padding:  EdgeInsets.only(left: Dimensions.w_15,right: Dimensions.w_15),
              child: Container(
                padding: EdgeInsets.only(
                  left: Dimensions.w_15,right: Dimensions.w_15,
                  top: Dimensions.h_10,
                  bottom: Dimensions.h_10
                ),
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: Dimensions.h_40,
                          width: Dimensions.h_40,
                          child: Image.asset(Images.totalCourse),
                        ),
                        HorizontalSpacing(width: Dimensions.w_30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TutorLmsTextWidget(title: 'Total Course',style: AppTextStyle.themeBoldNormalTextStyle(fontSize: FontSize.sp_16, color:Theme.of(context).shadowColor),),
                            TutorLmsTextWidget(title: 'Enrolled',style: AppTextStyle.themeBoldNormalTextStyle(fontSize: FontSize.sp_13, color:Theme.of(context).shadowColor),),
                          ],
                        ),
                      ],
                    ),
                    TutorLmsTextWidget(title: (courses?.totalEnroll ?? '0').toString(),style: AppTextStyle.themeBoldTextStyle(fontSize : FontSize.sp_22,
                        color: Theme.of(context).highlightColor)),
                  ],
                )
              ),
            ),
            VerticalSpacing(height: Dimensions.h_10),
            Padding(
              padding:  EdgeInsets.only(left: Dimensions.w_15,right: Dimensions.w_15),
              child: Container(
                  padding: EdgeInsets.only(
                      left: Dimensions.w_15,right: Dimensions.w_15,
                      top: Dimensions.h_10,
                      bottom: Dimensions.h_10
                  ),
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: Dimensions.h_40,
                            width: Dimensions.h_40,
                            child: Image.asset(Images.completedCourse),
                          ),
                          HorizontalSpacing(width: Dimensions.w_30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TutorLmsTextWidget(title: 'Total Course',style: AppTextStyle.themeBoldNormalTextStyle(fontSize: FontSize.sp_16, color:Theme.of(context).shadowColor),),
                              TutorLmsTextWidget(title: 'Completed',style: AppTextStyle.themeBoldNormalTextStyle(fontSize: FontSize.sp_12, color:Theme.of(context).shadowColor),),
                            ],
                          ),
                        ],
                      ),
                      TutorLmsTextWidget(title: (courses?.courseCompleted ?? '0').toString(),style: AppTextStyle.themeBoldTextStyle(fontSize : FontSize.sp_22,
                          color: Theme.of(context).highlightColor)),
                    ],
                  )
              ),
            ),
            VerticalSpacing(height: Dimensions.h_10),
            Padding(
              padding:  EdgeInsets.only(left: Dimensions.w_15,right: Dimensions.w_15),
              child: Container(
                  padding: EdgeInsets.only(
                      left: Dimensions.w_15,right: Dimensions.w_15,
                      top: Dimensions.h_10,
                      bottom: Dimensions.h_10
                  ),
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: Dimensions.h_40,
                            width: Dimensions.h_40,
                            child: Image.asset(Images.pendingCourse),
                          ),
                          HorizontalSpacing(width: Dimensions.w_30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TutorLmsTextWidget(title: 'Total Course',style: AppTextStyle.themeBoldNormalTextStyle(fontSize: FontSize.sp_16, color:Theme.of(context).shadowColor),),
                              TutorLmsTextWidget(title: 'Pending',style: AppTextStyle.themeBoldNormalTextStyle(fontSize: FontSize.sp_13, color:Theme.of(context).shadowColor),),
                            ],
                          ),
                        ],
                      ),
                      TutorLmsTextWidget(title: (courses?.coursePending ?? '0').toString(),style: AppTextStyle.themeBoldTextStyle(fontSize : FontSize.sp_22,
                          color: Theme.of(context).highlightColor)),
                    ],
                  )
              ),
            ),
            VerticalSpacing(height: Dimensions.h_30),
            Padding(
              padding:  EdgeInsets.only(left: Dimensions.w_20),
              child: TutorLmsTextWidget(title: 'Active Package', style: AppTextStyle.themeBoldTextStyle(fontSize: FontSize.sp_18, color: Theme.of(context).highlightColor)),
            ),
            VerticalSpacing(height: Dimensions.h_10),
            Padding(
              padding:  EdgeInsets.only(left: Dimensions.w_15,right: Dimensions.w_15),
              child: loading ?  Center(child: Padding(
                padding: EdgeInsets.only(top: Dimensions.h_40),
                child: const CupertinoActivityIndicator(),
              )) : membership ==null ? SizedBox(
                  height:100,child: Center(child: TutorLmsTextWidget(title: 'No Active Package', style: AppTextStyle.normalTextStyle(FontSize.sp_16, Theme.of(context).highlightColor))))
             : Container(
                padding: EdgeInsets.only(bottom: Dimensions.h_10),
                margin: EdgeInsets.only(bottom: Dimensions.h_10),
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: [
                    VerticalSpacing(height: Dimensions.h_20),
                    Padding(
                      padding:  EdgeInsets.only(left: Dimensions.w_15,right: Dimensions.w_15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TutorLmsTextWidget(title: membership?.package?.name?.toUpperCase() ?? "Gold", style: AppTextStyle.normalTextStyle(FontSize.sp_16, Theme.of(context).highlightColor) ),
                          Container(
                            alignment: Alignment.center,
                            height: Dimensions.h_30,
                              width: Dimensions.w_80,
                            decoration: BoxDecoration(
                                color: membership?.status == 1 ? Colors.green : Colors.red,
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: TutorLmsTextWidget(title: (membership?.status==1 ? "Active":"Inactive" ).toString(),style: AppTextStyle.normalTextStyle(FontSize.sp_14, Theme.of(context).highlightColor)),
                          )
                        ],
                      ),
                    ),
                    VerticalSpacing(height: Dimensions.h_30),
                    Padding(
                      padding:  EdgeInsets.only(left: Dimensions.w_15,right: Dimensions.w_15,),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TutorLmsTextWidget(title: 'Purchased At ',style: AppTextStyle.normalTextStyle(FontSize.sp_13, Theme.of(context).shadowColor)),
                          TutorLmsTextWidget(title: 'Expired At ',style: AppTextStyle.normalTextStyle(FontSize.sp_13, Theme.of(context).shadowColor)),
                          TutorLmsTextWidget(title: 'Price (USD) ',style: AppTextStyle.normalTextStyle(FontSize.sp_13, Theme.of(context).shadowColor))
                        ],
                      ),
                    ),
                    VerticalSpacing(height: Dimensions.h_10),
                    Padding(
                      padding:  EdgeInsets.only(left: Dimensions.w_15,right: Dimensions.w_45),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TutorLmsTextWidget(title: formattedDate.toString(),style: AppTextStyle.normalTextStyle(FontSize.sp_13, Theme.of(context).highlightColor)),
                          TutorLmsTextWidget(title:  formattedDate1.toString()  ,style: AppTextStyle.normalTextStyle(FontSize.sp_13, Theme.of(context).highlightColor)),
                          TutorLmsTextWidget(title: membership?.boughtPrice ?? "0",style: AppTextStyle.normalTextStyle(FontSize.sp_13, Theme.of(context).highlightColor))
                        ],
                      ),
                    ),
                    VerticalSpacing(height: Dimensions.h_20),
                    Row(
                      children: [
                        HorizontalSpacing(width: Dimensions.w_15),
                        TutorLmsTextWidget(title: 'Payment Status ',style: AppTextStyle.normalTextStyle(FontSize.sp_13, Theme.of(context).shadowColor)),
                        HorizontalSpacing(width: Dimensions.w_25),
                        TutorLmsTextWidget(title: 'Comment ',style: AppTextStyle.normalTextStyle(FontSize.sp_13, Theme.of(context).shadowColor)),
                      ],
                    ),
                    VerticalSpacing(height: Dimensions.h_10),
                    Row(
                      children: [
                        HorizontalSpacing(width: Dimensions.w_15),
                        TutorLmsTextWidget(title: membership?.stPayStatus ??"pending",style: AppTextStyle.normalTextStyle(FontSize.sp_13, Theme.of(context).highlightColor)),
                        HorizontalSpacing(width: Dimensions.w_120),
                        TutorLmsTextWidget(title: membership?.reason ??"_",style: AppTextStyle.normalTextStyle(FontSize.sp_13, Theme.of(context).highlightColor)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            VerticalSpacing(height: Dimensions.h_10)
          ],
        ),
      ),
    );
  }
  dashboard()async{
    setState(() {
      loading = true;
    });
    var response = await restClient.get(url: Apis.dashboardapi);
    var data = dashboardResponseFromJson(response);
      setState(() {
        courses = data.courses;
        membership= data.membership;
        recent.addAll(data.recent ?? []);
        loading = false;
      });
    }
  }

