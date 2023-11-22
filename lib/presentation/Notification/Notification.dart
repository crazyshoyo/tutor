import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tutor_lms/constants/constants.dart';
import 'package:tutor_lms/data.datasource/local/local_storage.dart';
import 'package:tutor_lms/presentation/dashboard/dashboard.dart';
import '../../constants/apptextstyle.dart';
import '../../constants/fontsize.dart';
import '../../constants/images.dart';
import '../../data.datasource/remote/models/response/notofication_response.dart';
import '../../data.datasource/remote/services/apis.dart';
import '../../widgets/spacing.dart';
import '../../widgets/tutor_text.dart';
class TutorNotification extends StatefulWidget {
  const TutorNotification({super.key});
  @override
  State<TutorNotification> createState() => _TutorNotificationState();
}
class _TutorNotificationState extends State<TutorNotification> {
  List<NotificationResponse>? notification;
  bool loading = false;
  
  @override
  void initState() {
    notificationApi();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          VerticalSpacing(height: Dimensions.h_40),
          ListTile(
            onTap: (){
              LocalStorage.getBool(GetXStorageConstants.exchangeFromHome)== true ? Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DashBoard(index: 3))) : Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DashBoard(index: 0)));
            },
            leading: Icon(Icons.arrow_back,color: Theme.of(context).shadowColor,),
            title: TutorLmsTextWidget(title: 'Notification', style: AppTextStyle.normalTextStyle(FontSize.sp_18, Theme.of(context).highlightColor)),
          ),
          loading  ?  Center(
          child: Padding(
            padding: EdgeInsets.only(top: Dimensions.h_250),
            child: CupertinoActivityIndicator(),
          ),
         ): (notification?.isNotEmpty ?? false) ? ListView.builder(
            itemCount: notification?.length ?? 0,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return SizedBox(
                 height: Dimensions.h_70,
                 width: double.infinity,
                 child: Padding(
                   padding:  EdgeInsets.only(left: Dimensions.w_10,right: Dimensions.w_10),
                   child: Card(
                       color:Theme.of(context).cardColor,
                       child:ListTile(
                         leading:Image.asset(Images.message,),
                         title: TutorLmsTextWidget(title: notification?[index].list?[index].title ?? "", style: AppTextStyle.normalTextStyle(FontSize.sp_16, Theme.of(context).highlightColor)),
                         subtitle: TutorLmsTextWidget(title:  notification?[index].list?[index].description ?? "", style: AppTextStyle.normalTextStyle(FontSize.sp_16, Theme.of(context).shadowColor)),
                         trailing: TutorLmsTextWidget(title:  notification?[index].list?[index].createdAt.toString() ?? '', style: AppTextStyle.normalTextStyle(FontSize.sp_16, Theme.of(context).shadowColor)),
                       )
                   ),
                 ),
               );
            },
          ) 
              : Center(
            child: Padding(
              padding:  EdgeInsets.only(top: Dimensions.h_150),
              child: Image.asset(Images.NotificationImage),
            ),
          )
        ],
      ),
    );
  }
  Future<List<NotificationResponse>> notificationApi()async{
    loading = true;
    try{
      final response= await http.get(Uri.parse(Apis.notification),headers: {HttpHeaders.contentTypeHeader: "application/json", HttpHeaders.authorizationHeader: "${LocalStorage.getAuthToken()}"});
      var data = jsonDecode(response.body.toString());
      print(data[0]);
      if(response.statusCode==200){
        setState(() {
          notification?.clear();
          notification?.add(NotificationResponse.fromJson(data));
          loading = false;
        });
        return notification ?? [];
      }
      else {
      }
    } catch(e) {
      print(e.toString());
    }
    throw Exception('unable');
  }

}
