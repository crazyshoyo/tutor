import 'package:flutter/material.dart';
import 'package:tutor_lms/widgets/spacing.dart';
import 'package:tutor_lms/widgets/tutor_lms_container.dart';
import 'package:tutor_lms/widgets/tutor_text.dart';
import '../constants/appcolor.dart';
import '../constants/apptextstyle.dart';
import '../constants/fontsize.dart';

class TutorLmsAppbar extends StatelessWidget {
  final double? height;
  final String? title;
  final Color? color;
  final void Function()? onTap;
  const TutorLmsAppbar({super.key, this.height,this.title,this.onTap,this.color});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(height ?? Dimensions.h_50),
      child: TutorLmsConatiner(
        width: double.infinity,
        padding: EdgeInsets.only(top: Dimensions.h_10,bottom: Dimensions.h_10),
        decoration: BoxDecoration(
            color: color ?? Theme.of(context).scaffoldBackgroundColor
        ),
        child: Center(
          child: Row(
            children: [
              HorizontalSpacing(width: Dimensions.w_15),
              GestureDetector(
                onTap: onTap,
                child: TutorLmsConatiner(
                    height: Dimensions.h_25,
                    width: Dimensions.h_25,
                    padding: const EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).cardColor,
                        border: Border.all(
                            color: Theme.of(context).shadowColor.withOpacity(0.3)
                        )
                    ),
                    child: const Icon(Icons.arrow_back_ios,size: 15,weight: 40,)
                ),
              ),
              HorizontalSpacing(width: Dimensions.w_60),
              TutorLmsTextWidget(title: title ?? '', style: AppTextStyle.themeBoldNormalTextStyle(
                  color: Theme.of(context).highlightColor,
                  fontSize: FontSize.sp_18
              ))
            ],
          ),
        ),
      ),
    );
  }
}
