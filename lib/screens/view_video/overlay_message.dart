import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaosity_app/screens/view_video/controller/view_video_controller.dart';
import 'package:kaosity_app/utils/app_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OverlayMessage extends StatefulWidget {
  final String title;
  final String subtitle;
  final Color color;
  final Widget child;

  const OverlayMessage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.child,
  });

  @override
  _OverlayMessageState createState() => _OverlayMessageState();
}

class _OverlayMessageState extends State<OverlayMessage> {
  final ViewVideoController controller = Get.find();
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isVisible = false;
        });
        controller.isPuzzleActive.value = false;
        controller.showProgress.value = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isVisible
        ? Center(
            child: Container(
              width: getWidth(363),
              height: getHeight(340),
              margin: EdgeInsets.only(bottom: getHeight(16)),
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.title,
                    style: AppStyles.whiteTextStyle()
                        .copyWith(fontSize: 22.sp, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: getHeight(18)),
                  Text(
                    widget.subtitle,
                    textAlign: TextAlign.center,
                    style: AppStyles.whiteTextStyle().copyWith(fontSize: 16.sp),
                  ),
                  SizedBox(height: getHeight(31)),
                  widget.child,
                ],
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
