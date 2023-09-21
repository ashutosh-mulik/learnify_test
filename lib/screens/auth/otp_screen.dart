import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnify_test/config/app_colors.dart';
import 'package:learnify_test/config/app_images.dart';
import 'package:learnify_test/config/strings.dart';
import 'package:learnify_test/screens/auth/bloc/auth_bloc.dart';
import 'package:learnify_test/utils/snack_bar.dart';
import 'package:learnify_test/widgets/button.dart';
import 'package:pinput/pinput.dart';

class OTPScreen extends StatefulWidget {
  final String phone;

  const OTPScreen({super.key, required this.phone});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController _pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          SnackBarUtil.loading(context, state.msg);
        }

        if (state is AuthError) {
          SnackBarUtil.close(context);
          SnackBarUtil.showError(context, state.error);
        }

        if (state is AuthOTPVerified) {
          SnackBarUtil.close(context);
          CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            text: "Your details has been submitted.",
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.transparent,
          title: Text(Strings.otpVerify),
          titleTextStyle: GoogleFonts.poppins(
            color: AppColors.black,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              Expanded(
                child: Image.asset(
                  AppImages.imgBro,
                ),
              ),
              SizedBox(height: 25.h),
              Text(
                Strings.otpSent,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.black.withOpacity(.65),
                ),
              ),
              Text(
                widget.phone,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 25.h),
              Pinput(
                controller: _pinController,
                onCompleted: (pin) {
                  context.read<AuthBloc>().add(VerifyOTP(code: pin));
                },
                defaultPinTheme: PinTheme(
                  width: 50.w,
                  height: 50.w,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.black.withOpacity(0.5),
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
              SizedBox(height: 25.h),
              Button(
                text: Strings.verifyOTP,
                onTap: () {
                  context.read<AuthBloc>().add(VerifyOTP(code: _pinController.text));
                },
              ),
              SizedBox(height: 60.h),
              Text(
                Strings.loginConsent,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.black.withOpacity(.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
