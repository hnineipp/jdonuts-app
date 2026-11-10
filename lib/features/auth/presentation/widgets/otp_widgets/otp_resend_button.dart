import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jd_donuts/core/theme/app_colors.dart';

class OtpResendButton extends StatelessWidget {
  const OtpResendButton({
    super.key,
    required this.seconds,
    required this.onResend,
  });

  final int seconds;
  final VoidCallback onResend;

  @override
  Widget build(BuildContext context) {
    final canResend = seconds == 0;
    final countdown = '${seconds ~/ 60}:'
        '${(seconds % 60).toString().padLeft(2, '0')}';

    return TextButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        alignment: Alignment.centerLeft,
      ),
      onPressed: canResend ? onResend : null,
      child: canResend
          ? Text(
              'Resend code',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            )
          : Text.rich(
              TextSpan(
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.muted,
                ),
                children: [
                  const TextSpan(text: 'Resend in '),
                  TextSpan(
                    text: countdown,
                    style: const TextStyle(color: AppColors.primary),
                  ),
                  const TextSpan(text: ' min'),
                ],
              ),
            ),
    );
  }
}
