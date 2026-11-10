import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_my.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('my')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'J\'Donuts'**
  String get appName;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logout;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneNumber;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get lastName;

  /// No description provided for @dateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get dateOfBirth;

  /// No description provided for @continueLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueLabel;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @offlineMessage.
  ///
  /// In en, this message translates to:
  /// **'You are offline · Showing saved content'**
  String get offlineMessage;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @emptyProducts.
  ///
  /// In en, this message translates to:
  /// **'No products available'**
  String get emptyProducts;

  /// No description provided for @productNotFound.
  ///
  /// In en, this message translates to:
  /// **'Product not found.'**
  String get productNotFound;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get somethingWentWrong;

  /// No description provided for @nearYou.
  ///
  /// In en, this message translates to:
  /// **'near you'**
  String get nearYou;

  /// No description provided for @exploreNow.
  ///
  /// In en, this message translates to:
  /// **'EXPLORE NOW'**
  String get exploreNow;

  /// No description provided for @pointsLeftToTier.
  ///
  /// In en, this message translates to:
  /// **'{points} points left to become {tier} Member'**
  String pointsLeftToTier(String points, String tier);

  /// No description provided for @memberTier.
  ///
  /// In en, this message translates to:
  /// **'{tier} member'**
  String memberTier(String tier);

  /// No description provided for @notificationCount.
  ///
  /// In en, this message translates to:
  /// **'{count} notifications'**
  String notificationCount(String count);

  /// No description provided for @noPromotionsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No promotions available'**
  String get noPromotionsAvailable;

  /// No description provided for @homeRetry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get homeRetry;

  /// No description provided for @seasonalSpecials.
  ///
  /// In en, this message translates to:
  /// **'Seasonal specials'**
  String get seasonalSpecials;

  /// No description provided for @popular.
  ///
  /// In en, this message translates to:
  /// **'Popular'**
  String get popular;

  /// No description provided for @orderAgain.
  ///
  /// In en, this message translates to:
  /// **'Order again'**
  String get orderAgain;

  /// No description provided for @nearbyShopCount.
  ///
  /// In en, this message translates to:
  /// **'There are {count} J’Donut shops near you'**
  String nearbyShopCount(String count);

  /// No description provided for @homeError.
  ///
  /// In en, this message translates to:
  /// **'Could not load your saved home data.'**
  String get homeError;

  /// No description provided for @sectionLoadError.
  ///
  /// In en, this message translates to:
  /// **'This section could not be loaded.'**
  String get sectionLoadError;

  /// No description provided for @noNearbyShops.
  ///
  /// In en, this message translates to:
  /// **'No nearby shops found'**
  String get noNearbyShops;

  /// No description provided for @orderOnline.
  ///
  /// In en, this message translates to:
  /// **'Order online'**
  String get orderOnline;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @rewards.
  ///
  /// In en, this message translates to:
  /// **'Rewards'**
  String get rewards;

  /// No description provided for @order.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get order;

  /// No description provided for @nearby.
  ///
  /// In en, this message translates to:
  /// **'Nearby'**
  String get nearby;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @noProductsAvailableYet.
  ///
  /// In en, this message translates to:
  /// **'No products available yet'**
  String get noProductsAvailableYet;

  /// Product discount percentage label
  ///
  /// In en, this message translates to:
  /// **'{discount}% off'**
  String discountOff(String discount);

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @wallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get wallet;

  /// No description provided for @productUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Product unavailable.'**
  String get productUnavailable;

  /// No description provided for @newBadge.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newBadge;

  /// No description provided for @whatsThis.
  ///
  /// In en, this message translates to:
  /// **'What\'s this?'**
  String get whatsThis;

  /// No description provided for @addToCart.
  ///
  /// In en, this message translates to:
  /// **'Add to cart'**
  String get addToCart;

  /// No description provided for @addedToCart.
  ///
  /// In en, this message translates to:
  /// **'{quantity} × {productName} added to cart'**
  String addedToCart(int quantity, String productName);

  /// No description provided for @onboardingTagline.
  ///
  /// In en, this message translates to:
  /// **'Round food for\nevery mood'**
  String get onboardingTagline;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'LET\'S GET STARTED'**
  String get getStarted;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @googleSignIn.
  ///
  /// In en, this message translates to:
  /// **'Google sign-in'**
  String get googleSignIn;

  /// No description provided for @appleSignIn.
  ///
  /// In en, this message translates to:
  /// **'Apple sign-in'**
  String get appleSignIn;

  /// No description provided for @facebookSignIn.
  ///
  /// In en, this message translates to:
  /// **'Facebook sign-in'**
  String get facebookSignIn;

  /// No description provided for @legalNotice.
  ///
  /// In en, this message translates to:
  /// **'By continuing, you acknowledge that you have read and agree to our'**
  String get legalNotice;

  /// No description provided for @termsOfUse.
  ///
  /// In en, this message translates to:
  /// **'Terms of Use'**
  String get termsOfUse;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @andLabel.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get andLabel;

  /// No description provided for @enterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone\nnumber'**
  String get enterPhoneNumber;

  /// No description provided for @invalidMyanmarPhone.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid Myanmar phone number.'**
  String get invalidMyanmarPhone;

  /// No description provided for @verifyYourNumber.
  ///
  /// In en, this message translates to:
  /// **'Verify your number'**
  String get verifyYourNumber;

  /// No description provided for @otpSentTo.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent a 6 digit OTP to {phone}'**
  String otpSentTo(String phone);

  /// No description provided for @tooManyIncorrectOtpAttempts.
  ///
  /// In en, this message translates to:
  /// **'Too many incorrect attempts. Resend code to try again.'**
  String get tooManyIncorrectOtpAttempts;

  /// No description provided for @incorrectOtp.
  ///
  /// In en, this message translates to:
  /// **'Incorrect code. Please try again.'**
  String get incorrectOtp;

  /// No description provided for @unregisteredPhone.
  ///
  /// In en, this message translates to:
  /// **'This number is not registered. Register now.'**
  String get unregisteredPhone;

  /// No description provided for @unableToSignIn.
  ///
  /// In en, this message translates to:
  /// **'Unable to sign in. Please try again.'**
  String get unableToSignIn;

  /// No description provided for @tooManyAttemptsResend.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Tap Resend code to try again.'**
  String get tooManyAttemptsResend;

  /// No description provided for @didntReceiveCode.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive the code?'**
  String get didntReceiveCode;

  /// No description provided for @whatsYourName.
  ///
  /// In en, this message translates to:
  /// **'What\'s your\nname?'**
  String get whatsYourName;

  /// No description provided for @invalidFirstName.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid first name.'**
  String get invalidFirstName;

  /// No description provided for @invalidNameCharacters.
  ///
  /// In en, this message translates to:
  /// **'Use letters and spaces only.'**
  String get invalidNameCharacters;

  /// No description provided for @whatsYourDateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'What\'s your\ndate of birth?'**
  String get whatsYourDateOfBirth;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'Month (1–12)'**
  String get month;

  /// No description provided for @day.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get day;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @invalidDateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid date of birth.'**
  String get invalidDateOfBirth;

  /// No description provided for @invalidCalendarDate.
  ///
  /// In en, this message translates to:
  /// **'Enter a real calendar date.'**
  String get invalidCalendarDate;

  /// No description provided for @futureDateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of birth cannot be in the future.'**
  String get futureDateOfBirth;

  /// No description provided for @minimumAgeError.
  ///
  /// In en, this message translates to:
  /// **'You must be at least 13 years old.'**
  String get minimumAgeError;

  /// No description provided for @registrationFailed.
  ///
  /// In en, this message translates to:
  /// **'Unable to complete registration. Please try again.'**
  String get registrationFailed;

  /// No description provided for @featureDemoPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'{feature} is a demo placeholder.'**
  String featureDemoPlaceholder(String feature);

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get resendCode;

  /// No description provided for @resendIn.
  ///
  /// In en, this message translates to:
  /// **'Resend in {time}'**
  String resendIn(String time);

  /// No description provided for @registerNow.
  ///
  /// In en, this message translates to:
  /// **'Register now'**
  String get registerNow;

  /// No description provided for @logoutConfirmationTitle.
  ///
  /// In en, this message translates to:
  /// **'Log out?'**
  String get logoutConfirmationTitle;

  /// No description provided for @logoutConfirmationMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get logoutConfirmationMessage;

  /// No description provided for @logoutFailed.
  ///
  /// In en, this message translates to:
  /// **'Unable to log out. Please try again.'**
  String get logoutFailed;

  /// No description provided for @logoutDescription.
  ///
  /// In en, this message translates to:
  /// **'You will be signed out of this device. You can sign in again anytime.'**
  String get logoutDescription;

  /// No description provided for @loggingOut.
  ///
  /// In en, this message translates to:
  /// **'Logging out...'**
  String get loggingOut;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'my'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'my':
      return AppLocalizationsMy();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
