
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutor_lms/widgets/player/src/controllers/pod_getx_video_controller.dart';
import 'package:tutor_lms/widgets/player/src/widgets/animated_play_pause_icon.dart';
import 'package:tutor_lms/widgets/player/src/widgets/core/video_gesture_detector.dart';
import 'package:tutor_lms/widgets/player/src/widgets/double_tap_icon.dart';
import 'package:tutor_lms/widgets/player/src/widgets/material_icon_button.dart';

import 'mobile_bottomsheet.dart';

class MobileOverlay extends StatelessWidget {
  final String tag;

  const MobileOverlay({super.key,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    const itemColor = Colors.white;
    final podCtr = Get.find<PodGetXVideoController>(tag: tag);
    return Stack(
      alignment: Alignment.center,
      children: [
        VideoGestureDetector(
          tag: tag,
          child: ColoredBox(
            color: Theme.of(context).cardColor,
            child: Row(
              children: [
                Expanded(
                  child: DoubleTapIcon(
                    tag: tag,
                    isForward: false,
                    height: double.maxFinite,
                    onDoubleTap: _isRtl()
                        ? podCtr.onRightDoubleTap
                        : podCtr.onLeftDoubleTap,
                  ),
                ),
                SizedBox(
                  height: double.infinity,
                  child: Center(
                    child: AnimatedPlayPauseIcon(tag: tag, size: 42),
                  ),
                ),
                Expanded(
                  child: DoubleTapIcon(
                    isForward: true,
                    tag: tag,
                    height: double.maxFinite,
                    onDoubleTap: _isRtl()
                        ? podCtr.onLeftDoubleTap
                        : podCtr.onRightDoubleTap,
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: IgnorePointer(
                  child: podCtr.videoTitle ?? const SizedBox(),
                ),
              ),
              MaterialIconButton(
                toolTipMesg: podCtr.podPlayerLabels.settings,
                color: itemColor,
                onPressed: () {
                  if (podCtr.isOverlayVisible) {
                    _bottomSheet(context);
                  } else {
                    podCtr.toggleVideoOverlay();
                  }
                },
                child: const Icon(
                  Icons.more_vert_rounded,
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: MobileOverlayBottomControlles(tag: tag),
        ),
      ],
    );
  }

  bool _isRtl() {
    final Locale locale = WidgetsBinding.instance.platformDispatcher.locale;
    final langs = [
      'ar', // Arabic
      'fa', // Farsi
      'he', // Hebrew
      'ps', // Pashto
      'ur', // Urdu
    ];
    for (int i = 0; i < langs.length; i++) {
      final lang = langs[i];
      if (locale.toString().contains(lang)) {
        return true;
      }
    }
    return false;
  }

  void _bottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      backgroundColor: Theme.of(context).cardColor,
      context: context,
      builder: (context) => SafeArea(child: MobileBottomSheet(tag: tag,context: context)),
    );
  }
}
