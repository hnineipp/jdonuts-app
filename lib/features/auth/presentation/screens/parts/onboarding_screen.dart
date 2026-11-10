part of '../auth_screens.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: const DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.pinkBackground,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenHeight * 0.59,
            child: MotionEntrance(
              delay: const Duration(milliseconds: 100),
              offset: const Offset(0, -0.15),
              scale: true,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  const AppImage(
                    'assets/images/onboarding_donuts.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.transparent,
                          AppColors.pinkBackground,
                        ],
                        stops: [0.0, 0.72, 1.0],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  const Spacer(flex: 5),
                  MotionEntrance(
                    delay: const Duration(milliseconds: 450),
                    offset: const Offset(0, 0.25),
                    child: Text(
                      l10n.onboardingTagline,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineLarge,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  MotionEntrance(
                    delay: const Duration(milliseconds: 650),
                    offset: const Offset(0, 0.3),
                    child: PrimaryButton(
                      label: l10n.getStarted,
                      onPressed: () => context.pushNamed(RouteNames.main.phone),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  MotionEntrance(
                    delay: const Duration(milliseconds: 800),
                    offset: const Offset(0, 0.2),
                    child: TextButton(
                      onPressed: () => context.pushNamed(
                        RouteNames.main.phone,
                        queryParameters: {
                          'mode': 'login',
                        },
                      ),
                      child: Text.rich(
                        TextSpan(
                          style: const TextStyle(
                            color: AppColors.ink,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text: '${l10n.alreadyHaveAccount} ',
                            ),
                            TextSpan(
                              text: l10n.login,
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  MotionEntrance(
                    delay: const Duration(milliseconds: 950),
                    offset: const Offset(0, 0.2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _SocialIcon(
                          isGoogle: true,
                          onTap: () => FeaturePlaceholderSheet.show(
                            context,
                            title: l10n.googleSignIn,
                          ),
                        ),
                        _SocialIcon(
                          icon: Icons.apple,
                          iconColor: AppColors.black,
                          onTap: () => FeaturePlaceholderSheet.show(
                            context,
                            title: l10n.appleSignIn,
                          ),
                        ),
                        _SocialIcon(
                          icon: Icons.facebook,
                          iconColor: AppColors.socialBlue,
                          onTap: () => FeaturePlaceholderSheet.show(
                            context,
                            title: l10n.facebookSignIn,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(flex: 1),
                  const _LegalText(),
                  SizedBox(height: 12.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  const _SocialIcon({
    required this.onTap,
    this.icon,
    this.isGoogle = false,
    this.iconColor,
  });

  final IconData? icon;
  final Color? iconColor;
  final VoidCallback onTap;
  final bool isGoogle;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: isGoogle
          ? AppImage(
              'assets/icons/google.png',
              width: 24.w,
              height: 24.w,
              fit: BoxFit.contain,
            )
          : Icon(
              icon,
              color: iconColor,
              size: 28.sp,
            ),
      iconSize: 30,
    );
  }
}
