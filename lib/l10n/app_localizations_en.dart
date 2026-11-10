// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'J\'Donuts';

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get logout => 'Log out';

  @override
  String get welcome => 'Welcome';

  @override
  String get phoneNumber => 'Phone number';

  @override
  String get firstName => 'First name';

  @override
  String get lastName => 'Last name';

  @override
  String get dateOfBirth => 'Date of birth';

  @override
  String get continueLabel => 'Continue';

  @override
  String get cancel => 'Cancel';

  @override
  String get retry => 'Retry';

  @override
  String get offlineMessage => 'You are offline · Showing saved content';

  @override
  String get loading => 'Loading...';

  @override
  String get emptyProducts => 'No products available';

  @override
  String get productNotFound => 'Product not found.';

  @override
  String get somethingWentWrong => 'Something went wrong. Please try again.';

  @override
  String get nearYou => 'near you';

  @override
  String get exploreNow => 'EXPLORE NOW';

  @override
  String pointsLeftToTier(String points, String tier) {
    return '$points points left to become $tier Member';
  }

  @override
  String memberTier(String tier) {
    return '$tier member';
  }

  @override
  String notificationCount(String count) {
    return '$count notifications';
  }

  @override
  String get noPromotionsAvailable => 'No promotions available';

  @override
  String get homeRetry => 'Try again';

  @override
  String get seasonalSpecials => 'Seasonal specials';

  @override
  String get popular => 'Popular';

  @override
  String get orderAgain => 'Order again';

  @override
  String nearbyShopCount(String count) {
    return 'There are $count J’Donut shops near you';
  }

  @override
  String get homeError => 'Could not load your saved home data.';

  @override
  String get sectionLoadError => 'This section could not be loaded.';

  @override
  String get noNearbyShops => 'No nearby shops found';

  @override
  String get orderOnline => 'Order online';

  @override
  String get home => 'Home';

  @override
  String get rewards => 'Rewards';

  @override
  String get order => 'Order';

  @override
  String get nearby => 'Nearby';

  @override
  String get settings => 'Settings';

  @override
  String get noProductsAvailableYet => 'No products available yet';

  @override
  String discountOff(String discount) {
    return '$discount% off';
  }

  @override
  String get account => 'Account';

  @override
  String get wallet => 'Wallet';

  @override
  String get productUnavailable => 'Product unavailable.';

  @override
  String get newBadge => 'New';

  @override
  String get whatsThis => 'What\'s this?';

  @override
  String get addToCart => 'Add to cart';

  @override
  String addedToCart(int quantity, String productName) {
    return '$quantity × $productName added to cart';
  }

  @override
  String get onboardingTagline => 'Round food for\nevery mood';

  @override
  String get getStarted => 'LET\'S GET STARTED';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get googleSignIn => 'Google sign-in';

  @override
  String get appleSignIn => 'Apple sign-in';

  @override
  String get facebookSignIn => 'Facebook sign-in';

  @override
  String get legalNotice =>
      'By continuing, you acknowledge that you have read and agree to our';

  @override
  String get termsOfUse => 'Terms of Use';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get andLabel => 'and';

  @override
  String get enterPhoneNumber => 'Enter your phone\nnumber';

  @override
  String get invalidMyanmarPhone => 'Enter a valid Myanmar phone number.';

  @override
  String get verifyYourNumber => 'Verify your number';

  @override
  String otpSentTo(String phone) {
    return 'We\'ve sent a 6 digit OTP to $phone';
  }

  @override
  String get tooManyIncorrectOtpAttempts =>
      'Too many incorrect attempts. Resend code to try again.';

  @override
  String get incorrectOtp => 'Incorrect code. Please try again.';

  @override
  String get unregisteredPhone =>
      'This number is not registered. Register now.';

  @override
  String get unableToSignIn => 'Unable to sign in. Please try again.';

  @override
  String get tooManyAttemptsResend =>
      'Too many attempts. Tap Resend code to try again.';

  @override
  String get didntReceiveCode => 'Didn\'t receive the code?';

  @override
  String get whatsYourName => 'What\'s your\nname?';

  @override
  String get invalidFirstName => 'Enter a valid first name.';

  @override
  String get invalidNameCharacters => 'Use letters and spaces only.';

  @override
  String get whatsYourDateOfBirth => 'What\'s your\ndate of birth?';

  @override
  String get month => 'Month (1–12)';

  @override
  String get day => 'Day';

  @override
  String get year => 'Year';

  @override
  String get invalidDateOfBirth => 'Enter a valid date of birth.';

  @override
  String get invalidCalendarDate => 'Enter a real calendar date.';

  @override
  String get futureDateOfBirth => 'Date of birth cannot be in the future.';

  @override
  String get minimumAgeError => 'You must be at least 13 years old.';

  @override
  String get registrationFailed =>
      'Unable to complete registration. Please try again.';

  @override
  String featureDemoPlaceholder(String feature) {
    return '$feature is a demo placeholder.';
  }

  @override
  String get resendCode => 'Resend code';

  @override
  String resendIn(String time) {
    return 'Resend in $time';
  }

  @override
  String get registerNow => 'Register now';

  @override
  String get logoutConfirmationTitle => 'Log out?';

  @override
  String get logoutConfirmationMessage => 'Are you sure you want to log out?';

  @override
  String get logoutFailed => 'Unable to log out. Please try again.';

  @override
  String get logoutDescription =>
      'You will be signed out of this device. You can sign in again anytime.';

  @override
  String get loggingOut => 'Logging out...';
}
