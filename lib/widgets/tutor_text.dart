import 'package:flutter/material.dart';

class TutorLmsTextWidget extends StatelessWidget {
  final String title;
  final TextStyle style;
  final TextAlign textAlign;
  final TextOverflow textOverflow;
  final int? maxLines;

  const TutorLmsTextWidget(
      {Key? key,
      required this.title,
      required this.style,
      this.textAlign = TextAlign.start,
      this.textOverflow = TextOverflow.ellipsis,
      this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: style,
      textAlign: textAlign,
      overflow: textOverflow,
      maxLines: maxLines,
    );
  }
}
