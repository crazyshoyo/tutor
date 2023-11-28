import 'dart:convert';
import 'dart:developer';
import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_lms/constants/appcolor.dart';
import 'package:tutor_lms/constants/constants.dart';
import 'package:tutor_lms/data.datasource/local/local_storage.dart';
import 'package:tutor_lms/data.datasource/remote/services/apis.dart';
import 'package:tutor_lms/presentation/membership/membership_controller.dart';
import 'package:tutor_lms/widgets/common_appbar.dart';
import 'package:tutor_lms/widgets/ozstaff_loader.dart';
import '../../constants/apptextstyle.dart';
import '../../constants/fontsize.dart';
import '../../constants/images.dart';
import '../../widgets/spacing.dart';
import '../../widgets/tutorlms_textbutton.dart';
import '../../widgets/tutor_text.dart';
import '../dashboard/dashboard.dart';
import 'package:http/http.dart' as http;

class MemberShip extends StatefulWidget {
  const MemberShip({super.key});
  @override
  State<MemberShip> createState() => _MemberShipState();
}

class _MemberShipState extends State<MemberShip> {
  final MemberShipController memberShipController = Get.put(MemberShipController());
 List<Plan>? plans;
 bool loading = false;

  @override
  void initState()  {
    memberShip();
    super.initState();
  }


  memberShip() async {
    loading = true;
    try {
      final response = await http.get(Uri.parse(Apis.memberShipPlan));
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        print('data get now');
        print(data.toString());
        setState(() {
          plans = [];
          data['plans'].forEach((key, value) {
            plans?.addAll((value as List<dynamic>).map((plan) => Plan(
              name: plan['name'],
              id: plan['id'],
              totalCourses: plan['total_courses'],
              price: double.parse(plan['price']),
              description: plan['description'],
              currency: plan['currency'],
              type: plan['type'],
            )));
          });
          for(var i in plans ?? []) {
            if(i.type == 'month' && i.type == 'year') {
              print('get the data in here ');
            }
          }
          plans?.forEach((element) {
            if(element.type == 'month' && element.type == 'year' ) {
              plans?.add(element);
              log("==============================================>${plans.toString()}");
            }
          });
          loading = false;
        });
      } else {}
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: memberShipController,
      id: ControllerBuilders.memberShipController,
      builder: ( controller) {
        return WillPopScope(
          onWillPop: () async => false,
          child: SafeArea(
            child: Scaffold(
              appBar: PreferredSize(preferredSize: Size.fromHeight(Dimensions.h_50), child:
              TutorLmsAppbar(title: 'MemberShip Plan',onTap: ()=> Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context)=> DashBoard(index: 3))),color: Theme.of(context).scaffoldBackgroundColor,)),
                body: loading ? const Center(
                  child: TutorActivityIndicator(),
                ) :  SingleChildScrollView(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: plans?.length ?? 0,
                      itemBuilder: (c,i) {
                    return  Padding(
                      padding:  EdgeInsets.only(left: Dimensions.w_15,right: Dimensions.w_15,top: Dimensions.h_20),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          children: [
                            VerticalSpacing(height: Dimensions.h_10),
                            Padding(
                              padding:  EdgeInsets.only(left: Dimensions.w_15,right: Dimensions.w_15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TutorLmsTextWidget(title: StringUtils.capitalize(plans?[i].name ?? '' )?? '', style: AppTextStyle.themeBoldNormalTextStyle(fontSize : FontSize.sp_22, color: Theme.of(context).highlightColor) ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: Dimensions.h_30,
                                    width: Dimensions.w_80,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Theme.of(context).scaffoldBackgroundColor
                                    ),
                                    child: TutorLmsTextWidget(title: plans?[i].type ?? '',style:AppTextStyle.normalTextStyle(14, AppColor.appColor)),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding:  EdgeInsets.only(left: Dimensions.w_15),
                                  child: TutorLmsTextWidget(title: plans?[i].description ?? '', style: AppTextStyle.normalTextStyle(FontSize.sp_12, Theme.of(context).shadowColor)),
                                )),
                            VerticalSpacing(height: Dimensions.h_18),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding:  EdgeInsets.only(left: Dimensions.w_15),
                                  child: TutorLmsTextWidget(title: '\$${plans?[i].price ?? ''}',
                                      style: AppTextStyle.normalTextStyle(FontSize.sp_16, Theme.of(context).highlightColor)),
                                )),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding:  EdgeInsets.only(left: Dimensions.w_15),
                                  child: TutorLmsTextWidget(title: plans?[i].currency ?? '', style: AppTextStyle.normalTextStyle(FontSize.sp_16, Theme.of(context).shadowColor)),
                                )),
                            VerticalSpacing(height: Dimensions.h_10),
                            Divider(
                              color: Theme.of(context).shadowColor,
                              height: 20,
                              indent: 20,
                              endIndent: 20,
                            ),
                            VerticalSpacing(height: Dimensions.h_5),
                            ListTile(
                              leading: SizedBox(
                                  height: Dimensions.h_30,
                                  width: Dimensions.h_30,
                                  child: Image.asset(Images.book,scale: 10,)),
                              title: TutorLmsTextWidget(title: '${plans?[i].totalCourses ?? ''} Courses',style: AppTextStyle.normalTextStyle(FontSize.sp_14, Theme.of(context).highlightColor)),
                              subtitle: TutorLmsTextWidget(title: 'Excel in any ${plans?[i].totalCourses} Courses for you',style: AppTextStyle.normalTextStyle(FontSize.sp_12, Theme.of(context).shadowColor)),
                            ),
                            ListTile(
                              leading: SizedBox(
                                  height: Dimensions.h_30,
                                  width: Dimensions.h_30,
                                  child: Image.asset(Images.support,)),
                              title: TutorLmsTextWidget(title: '24x7 Support',style: AppTextStyle.normalTextStyle(FontSize.sp_14, Theme.of(context).highlightColor)),
                              subtitle: TutorLmsTextWidget(title: 'Introducing Our 24/7 Support',style: AppTextStyle.normalTextStyle(FontSize.sp_12, Theme.of(context).shadowColor)),
                            ),
                            Divider(
                              color: Theme.of(context).shadowColor,
                              height: 20,
                              indent: 20,
                              endIndent: 20,
                            ),
                            VerticalSpacing(height: Dimensions.h_10),
                            LocalStorage.getBool(GetXStorageConstants.userLogin) == true ? Padding(
                              padding:  EdgeInsets.only(left: Dimensions.w_15,right: Dimensions.w_15),
                              child: TutorLmsTextButton(
                                height: Dimensions.h_40,
                                labelName: "Choose plan",
                                style: AppTextStyle.buttonTextStyle(
                                    color: AppColor.white),
                                onTap: () {
                                },
                                margin: EdgeInsets.zero,
                                color: AppColor.appColor,
                              ),
                            ) : Padding(
                                padding:  EdgeInsets.only(left: Dimensions.w_15,right: Dimensions.w_15),
                                child:  TutorLmsTextButton(
                                  height: Dimensions.h_40,
                                  labelName: "Inactive plan",
                                  style: AppTextStyle.buttonTextStyle(
                                      color: AppColor.white),
                                  onTap: () {
                                  },
                                  margin: EdgeInsets.zero,
                                  color: Theme.of(context).shadowColor,
                                )
                            ),
                            VerticalSpacing(height: Dimensions.h_20),
                          ],
                        ),
                      ),
                    );
                  })
                )

            ),
          ),
        );

      },
    );
  }


}

class Plan {
  final String name;
  final int totalCourses;
  final double price;
  final String description;
  final String currency;
  final String type;
  final int id;

  Plan({
    required this.name,
    required this.totalCourses,
    required this.price,
    required this.description,
    required this.currency,
    required this.type,
    required this.id
  });
}