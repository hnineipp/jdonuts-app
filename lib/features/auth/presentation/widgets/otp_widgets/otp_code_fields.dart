import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpCodeFields extends StatelessWidget {
  const OtpCodeFields({
    super.key,
    required this.controllers,
    required this.focusNodes,
    required this.enabled,
    required this.onChanged,
  });

  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final bool enabled;
  final void Function(int index, String value) onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Row(
      children: List.generate(6, (index) {
        return Expanded(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: SizedBox(
                height: 56.h,
                child: TextField(
                  controller: controllers[index],
                  focusNode: focusNodes[index],
                  enabled: enabled,
                  keyboardType: TextInputType.number,
                  textInputAction:
                      index == 5 ? TextInputAction.done : TextInputAction.next,
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  minLines: null,
                  maxLines: null,
                  expands: true,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(1),
                  ],
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontSize: 18.sp,
                    height: 1.0,
                    fontWeight: FontWeight.w700,
                    color: colors.onSurface,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: colors.surface,
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(
                        color: colors.secondary,
                        width: 1.5,
                      ),
                    ),
                  ),
                  onChanged: (value) => onChanged(index, value),
                ),
              )),
        );
      }),
    );
  }
}
