import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:jd_donuts/app/router/route_names.dart';

import 'package:jd_donuts/core/motion/motion.dart';
import 'package:jd_donuts/core/theme/app_colors.dart';
import 'package:jd_donuts/core/widgets/common_widgets.dart';
import 'package:jd_donuts/core/widgets/feature_placeholder_sheet.dart';
import 'package:jd_donuts/data/auth/domain/validators/auth_validators.dart';
import 'package:jd_donuts/data/auth/domain/validators/birth_date_validator.dart';
import 'package:jd_donuts/l10n/app_localizations.dart';
import 'package:jd_donuts/features/auth/view_models/auth_view_model.dart';
import 'package:jd_donuts/features/auth/presentation/widgets/otp_widgets/otp_code_fields.dart';
import 'package:jd_donuts/features/auth/presentation/widgets/otp_widgets/otp_registration_error.dart';
import 'package:jd_donuts/features/auth/presentation/widgets/otp_widgets/otp_resend_button.dart';
import 'package:jd_donuts/features/auth/presentation/widgets/progress_circular_widget.dart';

part 'parts/auth_shell.dart';
part 'parts/onboarding_screen.dart';
part 'parts/phone_screen.dart';
part 'parts/otp_screen.dart';
part 'parts/name_screen.dart';
part 'parts/birth_date_screen.dart';
