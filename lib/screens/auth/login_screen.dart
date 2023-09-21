import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learnify_test/config/app_colors.dart';
import 'package:learnify_test/config/app_images.dart';
import 'package:learnify_test/config/strings.dart';
import 'package:learnify_test/screens/auth/bloc/auth_bloc.dart';
import 'package:learnify_test/screens/auth/otp_screen.dart';
import 'package:learnify_test/utils/snack_bar.dart';
import 'package:learnify_test/widgets/button.dart';
import 'package:pinput/pinput.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final _smartAuth = SmartAuth();
  String _country = '+91';

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) => _requestHint());
  }

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

        if (state is AuthOTPSent) {
          SnackBarUtil.close(context);
          SnackBarUtil.show(context, "OTP Sent Successfully.");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => OTPScreen(phone: "$_country ${_phoneController.text}"),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.transparent,
          title: Text(Strings.login),
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
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  border: Border.all(),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CountryCodePicker(
                      initialSelection: 'IN',
                      showCountryOnly: false,
                      showOnlyCountryWhenClosed: false,
                      alignLeft: false,
                      showDropDownButton: false,
                      showFlag: false,
                      onChanged: (code) => code.dialCode != null ? _country = code.dialCode! : '',
                      builder: (code) {
                        return Row(
                          children: [
                            SizedBox(width: 12.w),
                            Text(code?.dialCode ?? ''),
                            const Icon(Icons.arrow_drop_down),
                          ],
                        );
                      },
                    ),
                    Flexible(
                      child: TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 12.h),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25.h),
              Button(
                text: Strings.getOTP,
                onTap: () {
                  context.read<AuthBloc>().add(SendOTP(country: _country, phone: _phoneController.text));
                },
              ),
              SizedBox(height: 80.h),
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

  void _requestHint() async {
    final res = await _smartAuth.requestHint(
      isPhoneNumberIdentifierSupported: true,
      isEmailAddressIdentifierSupported: false,
      showCancelButton: true,
    );
    setState(() {
      _phoneController.text = (res?.id ?? '').replaceAll(_country, '');
    });
  }
}
