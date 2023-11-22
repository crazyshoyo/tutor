import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_lms/constants/appcolor.dart';
import 'package:tutor_lms/constants/constants.dart';
import 'package:tutor_lms/presentation/membership/membership_controller.dart';
import '../../constants/apptextstyle.dart';
import '../../constants/fontsize.dart';
import '../../constants/images.dart';
import '../../widgets/spacing.dart';
import '../../widgets/tutorlms_textbutton.dart';
import '../../widgets/tutor_text.dart';
import '../dashboard/dashboard.dart';

class MemberShip extends StatefulWidget {
  const MemberShip({super.key});
  @override
  State<MemberShip> createState() => _MemberShipState();
}

class _MemberShipState extends State<MemberShip> {
  final MemberShipController memberShipController = Get.put(MemberShipController());

  @override
  void initState()  {
    memberShipController.onMemberShip(context);
    memberShipController.planId = (memberShipController.plans?.gold?[0].id.toString() ?? '') ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: memberShipController,
      id: ControllerBuilders.memberShipController,
      builder: ( controller) {
        return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  VerticalSpacing(height: Dimensions.h_40),
                  ListTile(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => DashBoard(index: 0)));
                    },
                    leading: Icon(Icons.arrow_back, color: Theme
                        .of(context)
                        .shadowColor,),
                    title: TutorLmsTextWidget(title: 'Member Ship Plan',
                        style: AppTextStyle.normalTextStyle(FontSize.sp_18, Theme.of(context).highlightColor)),
                  ),
                  VerticalSpacing(height: Dimensions.h_20),
                  ///Silver
                  Column(
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(left: Dimensions.w_15,right: Dimensions.w_15),
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
                                    TutorLmsTextWidget(title:controller.plans?.silver?[0].name?.toUpperCase() ?? 'SILVER', style: AppTextStyle.normalTextStyle(FontSize.sp_16, Theme.of(context).highlightColor) ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: Dimensions.h_30,
                                      width: Dimensions.w_80,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Theme.of(context).scaffoldBackgroundColor
                                      ),
                                      child: TutorLmsTextWidget(title: controller.plans?.silver?[0].type ?? 'Month',style:AppTextStyle.normalTextStyle(14, AppColor.appColor)),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding:  EdgeInsets.only(left: Dimensions.w_15),
                                    child: TutorLmsTextWidget(title: controller.plans?.silver?[0].description ?? 'Enjoy Course', style: AppTextStyle.normalTextStyle(FontSize.sp_12, Theme.of(context).shadowColor)),
                                  )),
                              VerticalSpacing(height: Dimensions.h_18),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding:  EdgeInsets.only(left: Dimensions.w_15),
                                    child: TutorLmsTextWidget(title: '\$${
                                      controller.plans?.silver?[0].price ?? '0.0'}',
                                     style: AppTextStyle.normalTextStyle(FontSize.sp_16, Theme.of(context).highlightColor)),
                                  )),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding:  EdgeInsets.only(left: Dimensions.w_15),
                                    child: TutorLmsTextWidget(title: 'Onetime Plan / Per user', style: AppTextStyle.normalTextStyle(FontSize.sp_16, Theme.of(context).shadowColor)),
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
                                title: TutorLmsTextWidget(title: '${
                                    controller.plans?.silver?[0].totalCourses ?? '5'} Courses',style: AppTextStyle.normalTextStyle(FontSize.sp_14, Theme.of(context).highlightColor)),
                                subtitle: TutorLmsTextWidget(title: 'Excel in any ${
                                    controller.plans?.silver?[0].totalCourses ?? '5'} Courses for you',style: AppTextStyle.normalTextStyle(FontSize.sp_12, Theme.of(context).shadowColor)),
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
                              Padding(
                                padding:  EdgeInsets.only(left: Dimensions.w_15,right: Dimensions.w_15),
                                child: (double.parse(controller.plans?.silver?[0].price ?? '0.0') == 0.0 )  ? TutorLmsTextButton(
                                  labelName: "Inactive plan",
                                  style: AppTextStyle.buttonTextStyle(
                                      color: AppColor.white),
                                  onTap: () {
                                  },
                                  margin: EdgeInsets.zero,
                                  color: Theme.of(context).shadowColor,
                                ): TutorLmsTextButton(
                                  labelName: "Choose plan",
                                  style: AppTextStyle.buttonTextStyle(
                                      color: AppColor.white),
                                  onTap: () {
                                  },
                                  margin: EdgeInsets.zero,
                                  color: AppColor.appColor,
                                )
                              ),
                              VerticalSpacing(height: Dimensions.h_20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  VerticalSpacing(height: Dimensions.h_10),
                  ///platinum
                  Column(
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(left: Dimensions.w_15,right: Dimensions.w_15),
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
                                    TutorLmsTextWidget(title: controller.month ? (controller.plans?.platinum?[0].name?.toUpperCase()?? 'PLATINUM') : (controller.plans?.platinum?[1].name?.toUpperCase()?? ''), style: AppTextStyle.normalTextStyle(FontSize.sp_16, Theme.of(context).highlightColor) ),
                                    HorizontalSpacing(width: Dimensions.w_30),
                                    GestureDetector(
                                      onTap: (){
                                        controller.onMonth();
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: Dimensions.h_30,
                                        width: Dimensions.w_80,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Theme.of(context).scaffoldBackgroundColor
                                        ),
                                        child: TutorLmsTextWidget(title: 'Month',style:AppTextStyle.normalTextStyle(14, controller.month ? AppColor.appColor : Theme.of(context).highlightColor), ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        controller.onAnnual(controller.plans?.platinum?[1].id.toString() ?? '');
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: Dimensions.h_30,
                                        width: Dimensions.w_80,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Theme.of(context).scaffoldBackgroundColor
                                        ),
                                        child: TutorLmsTextWidget(title: 'Annual',style:AppTextStyle.normalTextStyle(14,controller.annual ? AppColor.appColor : Theme.of(context).highlightColor)),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding:  EdgeInsets.only(left: Dimensions.w_15),
                                    child: TutorLmsTextWidget(title: controller.month ? (controller.plans?.platinum?[0].description ?? 'Enjoy Course') : (controller.plans?.platinum?[1].description ?? 'Enjoy Course'), style: AppTextStyle.normalTextStyle(FontSize.sp_14, Theme.of(context).shadowColor)),
                                  )),
                              VerticalSpacing(height: Dimensions.h_10),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding:  EdgeInsets.only(left: Dimensions.w_15),
                                    child: TutorLmsTextWidget(title: controller.month ? ('\$${controller.plans?.platinum?[0].price ?? '0.0'}') : ('\$${controller.plans?.platinum?[1].price ?? '0.0'}') , style: AppTextStyle.normalTextStyle(FontSize.sp_16, Theme.of(context).highlightColor)),
                                  )),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding:  EdgeInsets.only(left: Dimensions.w_15),
                                    child: TutorLmsTextWidget(title: 'Month Plan / Per user', style: AppTextStyle.normalTextStyle(FontSize.sp_16, Theme.of(context).shadowColor)),
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
                                title: TutorLmsTextWidget(title: controller.month ? ('${controller.plans?.platinum?[0].totalCourses.toString() ?? '2'} Courses') : ('${controller.plans?.platinum?[1].totalCourses.toString() ?? '2'} Courses'),style: AppTextStyle.normalTextStyle(FontSize.sp_14, Theme.of(context).highlightColor)),
                                subtitle: TutorLmsTextWidget(title: controller.month ? ('Excel in any ${controller.plans?.platinum?[0].totalCourses.toString() ?? ''} Courses for you') : ('Excel in any ${controller.plans?.platinum?[1].totalCourses.toString() ?? ''} Courses for you'),style: AppTextStyle.normalTextStyle(FontSize.sp_12, Theme.of(context).highlightColor)),
                              ),
                              ListTile(
                                leading: SizedBox(
                                    height: Dimensions.h_30,
                                    width: Dimensions.h_30,
                                    child: Image.asset(Images.support,)),
                                title: TutorLmsTextWidget(title: '24x7 Support',style: AppTextStyle.normalTextStyle(FontSize.sp_16, Theme.of(context).highlightColor)),
                                subtitle: TutorLmsTextWidget(title: 'Introducing Our 24/7 Support',style: AppTextStyle.normalTextStyle(FontSize.sp_14, Theme.of(context).shadowColor)),
                              ),
                              Divider(
                                color: Theme.of(context).shadowColor,
                                height: 20,
                                indent: 20,
                                endIndent: 20,
                              ),
                              VerticalSpacing(height: Dimensions.h_10),
                              Padding(
                                padding:  EdgeInsets.only(left: Dimensions.w_15,right: Dimensions.w_15),
                                child: TutorLmsTextButton(
                                  loading: controller.buttonLoading,
                                  labelName: "Choose plan",
                                  style: AppTextStyle.buttonTextStyle(
                                      color: AppColor.white),
                                  onTap: () {
                                    controller.makePayment(context);
                                  },
                                  margin: EdgeInsets.zero,
                                  color: AppColor.appColor,
                                ),
                              ),
                              VerticalSpacing(height: Dimensions.h_20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  VerticalSpacing(height: Dimensions.h_20),
                  ///gold
                  Column(
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(left: Dimensions.w_15,right: Dimensions.w_15),
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
                                    TutorLmsTextWidget(title: controller.month1 ? (controller.plans?.gold?[0].name?.toUpperCase()?? 'GOLD') : (controller.plans?.gold?[1].name?.toUpperCase()?? ''), style: AppTextStyle.normalTextStyle(FontSize.sp_16, Theme.of(context).highlightColor) ),
                                    HorizontalSpacing(width: Dimensions.w_30),
                                    GestureDetector(
                                      onTap: (){
                                        controller.onMonthGold(controller.plans?.gold?[0].id.toString() ?? '');
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: Dimensions.h_30,
                                        width: Dimensions.w_80,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Theme.of(context).scaffoldBackgroundColor
                                        ),
                                        child: TutorLmsTextWidget(title: 'Month',style:AppTextStyle.normalTextStyle(14, controller.month1 ? AppColor.appColor : Theme.of(context).highlightColor), ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        controller.onAnnualGold(controller.plans?.gold?[1].id.toString() ?? '');
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: Dimensions.h_30,
                                        width: Dimensions.w_80,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Theme.of(context).scaffoldBackgroundColor
                                        ),
                                        child: TutorLmsTextWidget(title: 'Annual',style:AppTextStyle.normalTextStyle(14,controller.annual1 ? AppColor.appColor : Theme.of(context).highlightColor),),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding:  EdgeInsets.only(left: Dimensions.w_15),
                                    child: TutorLmsTextWidget(title: controller.month1 ? (controller.plans?.gold?[0].description ?? 'Enjoy course') : (controller.plans?.gold?[1].description ?? 'Enjoy Course'), style: AppTextStyle.normalTextStyle(FontSize.sp_14, Theme.of(context).shadowColor)),
                                  )),
                              VerticalSpacing(height: Dimensions.h_10),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding:  EdgeInsets.only(left: Dimensions.w_15),
                                    child: TutorLmsTextWidget(title: controller.month1 ? ('\$${controller.plans?.gold?[0].price ?? '0.0'}') : ('\$${controller.plans?.gold?[1].price ?? '0.0'}') , style: AppTextStyle.normalTextStyle(FontSize.sp_16, Theme.of(context).highlightColor)),
                                  )),
                              VerticalSpacing(height: Dimensions.h_10),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding:  EdgeInsets.only(left: Dimensions.w_15),
                                    child: TutorLmsTextWidget(title: 'Month Plan / Per user', style: AppTextStyle.normalTextStyle(FontSize.sp_16, Theme.of(context).shadowColor)),
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
                                title: TutorLmsTextWidget(title: controller.month1? ('${controller.plans?.gold?[0].totalCourses.toString() ?? '150'} Courses') : ('${controller.plans?.gold?[1].totalCourses.toString() ?? '150'} Courses'),style: AppTextStyle.normalTextStyle(FontSize.sp_14, Theme.of(context).highlightColor)),
                                subtitle: TutorLmsTextWidget(title: controller.month1 ? ('Excel in any ${controller.plans?.gold?[0].totalCourses.toString() ?? '150'} Courses for you') : ('Excel in any ${controller.plans?.gold?[1].totalCourses.toString() ?? '150'} Courses for you'),style: AppTextStyle.normalTextStyle(FontSize.sp_12, Theme.of(context).highlightColor)),
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
                              Padding(
                                padding:  EdgeInsets.only(left: Dimensions.w_15,right: Dimensions.w_15),
                                child: TutorLmsTextButton(
                                  loading: controller.buttonLoading,
                                  labelName: "Choose plan",
                                  style: AppTextStyle.buttonTextStyle(
                                      color: AppColor.white),
                                  onTap: ()  async {
                                    controller.makePayment(context);
                                  },
                                  margin: EdgeInsets.zero,
                                  color: AppColor.appColor,
                                ),
                              ),
                              VerticalSpacing(height: Dimensions.h_20),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  VerticalSpacing(height: Dimensions.h_30),
                ],
              ),
            )

        );

      },
    );
  }


}
