import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:tutor_lms/presentation/tutor_lm_scaffold.dart';
import 'package:tutor_lms/widgets/tutor_text.dart';
import '../../constants/appcolor.dart';
import '../../constants/apptextstyle.dart';
import '../../constants/fontsize.dart';
import '../../constants/images.dart';
import '../Account/Account.dart';
import '../CourseDashboard/CourseDashboard.dart';
import '../Homepage/homepage.dart';
import '../Search/Search.dart';
class DashBoard extends StatefulWidget {
    int index;
    DashBoard({Key? key,this.index = 0,}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> with WidgetsBindingObserver{
  int selectedIndex = 0;

  onPage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    selectedIndex = widget.index ?? 0;
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async => false,
      child: TutorLmsScaffold(
        body:  callPage(selectedIndex),
        bottomNavigationBar:  SalomonBottomBar(
          currentIndex: selectedIndex,
          backgroundColor: Theme.of(context).hintColor,
          onTap: onPage,
          items: [
          SalomonBottomBarItem(
            activeIcon: SizedBox(
                height: Dimensions.h_20,
                width: Dimensions.h_20,
                child: Image.asset(Images.home,color: AppColor.appColor,)),
            icon: SizedBox(
                height: Dimensions.h_23,
                width: Dimensions.h_23,
                child: Image.asset(Images.home)),
            title: TutorLmsTextWidget(title: "Home",style: AppTextStyle.themeBoldNormalTextStyle(
                fontSize: FontSize.sp_15,color: AppColor.appColor
            ),),
          ),
          // SalomonBottomBarItem(
          //   activeIcon: SizedBox(
          //       height: Dimensions.h_20,
          //       width: Dimensions.h_20,
          //       child: Image.asset(Images.market,color: AppColor.appColor,)),
          //   icon: SizedBox(
          //       height: Dimensions.h_25,
          //       width: Dimensions.h_25,
          //       child: Image.asset(Images.market)),
          //   title: TutorLmsTextWidget(title: "Course",style: AppTextStyle.themeBoldNormalTextStyle(
          //       fontSize: FontSize.sp_15,color: AppColor.appColor
          //   ),),
          // ),
          SalomonBottomBarItem(
            activeIcon: SizedBox(
                height: Dimensions.h_20,
                width: Dimensions.h_20,
                child: Image.asset(Images.exchange,color: AppColor.appColor,)),
            icon: SizedBox(
                height: Dimensions.h_20,
                width: Dimensions.h_20,
                child: Image.asset(Images.exchange)),
            title: TutorLmsTextWidget(title: "Courses",style: AppTextStyle.themeBoldNormalTextStyle(
                fontSize: FontSize.sp_15,color: AppColor.appColor
            ),),
          ),
          SalomonBottomBarItem(
            activeIcon: SizedBox(
                height: Dimensions.h_20,
                width: Dimensions.h_20,
                child: Image.asset(Images.wallet,color: AppColor.appColor,)),
            icon: SizedBox(
              height: Dimensions.h_20,
                width: Dimensions.h_20,
                child: Image.asset(Images.wallet)),
            title: TutorLmsTextWidget(title: "Dashboard",style: AppTextStyle.themeBoldNormalTextStyle(
                fontSize: FontSize.sp_15,color: AppColor.appColor
            ),),
          ),
          SalomonBottomBarItem(
                activeIcon: SizedBox(
                    height: Dimensions.h_20,
                    width: Dimensions.h_20,
                    child: Image.asset(
                      Images.user,
                      color: AppColor.appColor,
                    )),
                icon: SizedBox(
                    height: Dimensions.h_20,
                    width: Dimensions.h_20,
                    child: Image.asset(Images.user)),
                title:  TutorLmsTextWidget(title: "Account",style: AppTextStyle.themeBoldNormalTextStyle(
                  fontSize: FontSize.sp_15,color: Theme.of(context).highlightColor
                ),),
              ),
            ],
          )),
    );
  }
}

Widget? callPage(int i) {
  switch (i) {
    case 0:
      return const HomePage();
    case 1:
      return const AllCourse_bottom();
    case 2:
      return const CourseDashboard();
    case 3:
      return const Account();
    default:
      return const HomePage();
  }
}