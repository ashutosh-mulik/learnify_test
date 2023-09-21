import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learnify_test/config/app_colors.dart';

class SnackBarUtil {
  static void showError(BuildContext context, String message) {
    var snackBar = SnackBar(
      margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
      ),
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void show(BuildContext context, String message) {
    var snackBar = SnackBar(
      margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
      ),
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void loading(BuildContext context, String message) {
    var snackBar = SnackBar(
      margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.grey,
      content: Row(
        children: [
          Expanded(
            child: Text(message),
          ),
          SizedBox(
            height: 20.w,
            width: 20.w,
            child: CircularProgressIndicator(
              color: AppColors.white,
            ),
          ),
        ],
      ),
      duration: const Duration(days: 100),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.r),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void close(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }
}
