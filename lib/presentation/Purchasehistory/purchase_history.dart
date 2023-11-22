
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tutor_lms/constants/appcolor.dart';
import 'package:tutor_lms/constants/apptextstyle.dart';
import 'package:tutor_lms/constants/fontsize.dart';
import 'package:tutor_lms/data.datasource/local/local_storage.dart';
import 'package:tutor_lms/data.datasource/remote/models/response/purchase_history.dart';
import 'package:tutor_lms/data.datasource/remote/services/dio/rest_client.dart';
import 'package:tutor_lms/presentation/Account/Account.dart';
import 'package:tutor_lms/presentation/dashboard/dashboard.dart';
import 'package:tutor_lms/widgets/common_appbar.dart';
import 'package:tutor_lms/widgets/spacing.dart';
import 'package:tutor_lms/widgets/tutor_text.dart';
import '../../data.datasource/remote/services/apis.dart';
class PurchaseHistory extends StatefulWidget {
  const PurchaseHistory({super.key});
  @override
  State<PurchaseHistory> createState() => _PurchaseHistoryState();
}

class _PurchaseHistoryState extends State<PurchaseHistory> {
  List<Enrolment> enrolments = [];
  bool firsTime = true;
  bool loading = false;
  final restClient = Get.find<RestClient>();

  @override
  void initState() {
    purchase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(preferredSize: Size.fromHeight(Dimensions.h_60),child: TutorLmsAppbar(title: 'Purchase History',onTap: ()=> Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context)=> DashBoard(index: 3))),color: Theme.of(context).scaffoldBackgroundColor,)),
        body: SingleChildScrollView(
          child: Column(
            children: [
              VerticalSpacing(height: Dimensions.h_15),
             loading ? Center(
               child: Padding(
                 padding:  EdgeInsets.only(top: Dimensions.h_200),
                 child: const CupertinoActivityIndicator(
                   radius: 18,
                 ),
               ),
             ) : (enrolments.isNotEmpty ?? false) ? ListView.builder(
                shrinkWrap: true,
                itemCount: enrolments.length ?? 0,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder:(context, index) {
                  DateTime enrollmentDate = enrolments[index].createdAt ?? DateTime(00, 00, 00);
                  String formattedDate = DateFormat.yMd().format(enrollmentDate);
                  DateTime enrollmentDate1 = enrolments[index].createdAt ?? DateTime(00, 00, 00);
                  String formattedDate1 = DateFormat.yMd().format(enrollmentDate1);
                  return Column(
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
                              VerticalSpacing(height: Dimensions.h_20),
                              Padding(
                                padding:  EdgeInsets.only(left: Dimensions.w_15,right: Dimensions.w_15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TutorLmsTextWidget(title: enrolments[index].package.name.toUpperCase() ?? 'GOld', style: AppTextStyle.themeBoldNormalTextStyle(fontSize: FontSize.sp_20, color: Theme.of(context).highlightColor) ),
                                    Container(
                                      alignment: Alignment.center,
                                      height: Dimensions.h_30,
                                      width: Dimensions.w_80,
                                      decoration: BoxDecoration(
                                          color: enrolments[index].status.toString() == "1" ? Colors.green : Colors.red,
                                          borderRadius: BorderRadius.circular(20)
                                      ),
                                      child: TutorLmsTextWidget(title: enrolments[index].status.toString() == "1" ?"Active":"Inactive"?? '',style: AppTextStyle.normalTextStyle(FontSize.sp_14, Theme.of(context).highlightColor)),
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
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        TutorLmsTextWidget(title: 'Purchased At',style: AppTextStyle.normalTextStyle(FontSize.sp_12, Theme.of(context).shadowColor)),
                                        VerticalSpacing(height: Dimensions.h_5),
                                        TutorLmsTextWidget(title: formattedDate.toLowerCase(),style: AppTextStyle.normalTextStyle(FontSize.sp_14, Theme.of(context).highlightColor)),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        TutorLmsTextWidget(title: 'Expired At',style: AppTextStyle.normalTextStyle(FontSize.sp_12, Theme.of(context).shadowColor)),
                                        VerticalSpacing(height: Dimensions.h_5),
                                        TutorLmsTextWidget(title:formattedDate1,style: AppTextStyle.normalTextStyle(FontSize.sp_14, Theme.of(context).highlightColor)),

                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        TutorLmsTextWidget(title:'Price (USD)',style: AppTextStyle.normalTextStyle(FontSize.sp_12, Theme.of(context).shadowColor)),
                                        VerticalSpacing(height: Dimensions.h_5),
                                        Padding(
                                          padding:  EdgeInsets.only(right: Dimensions.w_20),
                                          child: TutorLmsTextWidget(title: enrolments[index].boughtPrice.toString() ??'0',style: AppTextStyle.normalTextStyle(FontSize.sp_14, Theme.of(context).highlightColor)),
                                        )

                                      ],
                                    )
                                  ],
                                ),
                              ),
                              VerticalSpacing(height: Dimensions.h_20),
                              Row(
                                children: [
                                  HorizontalSpacing(width: Dimensions.w_15),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TutorLmsTextWidget(title: 'Payment Status ',style: AppTextStyle.normalTextStyle(FontSize.sp_12, Theme.of(context).shadowColor)),
                                      TutorLmsTextWidget(title: enrolments[index].stPayStatus.toString()==null ? "pending" : "_" ,style: AppTextStyle.normalTextStyle(FontSize.sp_12, Theme.of(context).highlightColor)),
                                    ],
                                  ),
                                  HorizontalSpacing(width: Dimensions.w_25),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TutorLmsTextWidget(title: 'Comment ',style: AppTextStyle.normalTextStyle(FontSize.sp_12, Theme.of(context).shadowColor)),
                                      TutorLmsTextWidget(title: '-',style: AppTextStyle.normalTextStyle(FontSize.sp_14, Theme.of(context).highlightColor)),
                                    ],
                                  ),
                                ],
                              ),
                              VerticalSpacing(height: Dimensions.h_20),
                            ],
                          ),
                        ),
                      ),
                      VerticalSpacing(height: Dimensions.h_20),

                    ],
                  );
                },
              ) : Center(
               child: TutorLmsTextWidget(title: 'No Data found',
                   style: AppTextStyle.normalTextStyle(FontSize.sp_16, Theme.of(context).highlightColor)
               ),
             )
            ],
          ),
        )

      ),
    );
  }
purchase() async{
    loading = true;
    final dio = Dio();
    const url = Apis.purchasehistory;
    try {
      final response = await dio.get(url,options: Options(responseType: ResponseType.plain,headers: {
        'Authorization' : LocalStorage.getAuthToken(),
      }),);

      if (response.statusCode == 200) {
        log(response.data);
        var data = purchaseHistoryFromJsonFromJson(response.data);
        if(enrolments.isEmpty ?? false) {
          setState(() {
            loading = false;
            enrolments.addAll(data.enrolments);
          });
        }
        else {
          loading = false;
          print('MeowMeowMeowMoewMeow');
        }

      } else {
        print('${response.statusCode} : ${response.data.toString()}');
        throw response;
      }
    } catch (error) {
      print(error);
    }
}


  }


