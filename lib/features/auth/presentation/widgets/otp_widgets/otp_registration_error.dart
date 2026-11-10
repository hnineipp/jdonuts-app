import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jd_donuts/core/theme/app_colors.dart';

class OtpRegistrationError extends StatelessWidget {
  const OtpRegistrationError({
    super.key,
    required this.onRegister,
  });

  final VoidCallback onRegister;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Text(
          'This number is not registered. ',
          style: TextStyle(
            color: AppColors.error,
            fontSize: 12.sp,
            height: 1.4,
          ),
        ),
        GestureDetector(
          onTap: onRegister,
          child: Text(
            'Register now',
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
