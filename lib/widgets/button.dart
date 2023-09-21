import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learnify_test/config/app_colors.dart';

class Button extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const Button({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Material(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(30.r),
        child: InkWell(
          onTap: () => widget.onTap(),
          borderRadius: BorderRadius.circular(30.r),
          splashColor: AppColors.white.withOpacity(.2),
          child: Center(
            child: Text(
              widget.text,
              style: TextStyle(
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
