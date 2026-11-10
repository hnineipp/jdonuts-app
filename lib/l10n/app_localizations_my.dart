// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Burmese (`my`).
class AppLocalizationsMy extends AppLocalizations {
  AppLocalizationsMy([String locale = 'my']) : super(locale);

  @override
  String get appName => 'J\'Donuts';

  @override
  String get login => 'အကောင့်ဝင်ရန်';

  @override
  String get register => 'အကောင့်ဖွင့်ရန်';

  @override
  String get logout => 'အကောင့်မှ ထွက်မည်';

  @override
  String get welcome => 'ကြိုဆိုပါတယ်';

  @override
  String get phoneNumber => 'ဖုန်းနံပါတ်';

  @override
  String get firstName => 'အမည်';

  @override
  String get lastName => 'မျိုးရိုးအမည်';

  @override
  String get dateOfBirth => 'မွေးသက္ကရာဇ်';

  @override
  String get continueLabel => 'ဆက်လုပ်ရန်';

  @override
  String get cancel => 'မလုပ်တော့ပါ';

  @override
  String get retry => 'ပြန်ကြိုးစားရန်';

  @override
  String get offlineMessage =>
      'အင်တာနက်ချိတ်ဆက်မှု မရှိပါ · သိမ်းဆည်းထားသော အကြောင်းအရာကို ပြသနေသည်';

  @override
  String get loading => 'ဖွင့်နေသည်...';

  @override
  String get emptyProducts => 'ကုန်ပစ္စည်း မရှိသေးပါ';

  @override
  String get productNotFound => 'ကုန်ပစ္စည်းကို ရှာမတွေ့ပါ။';

  @override
  String get somethingWentWrong => 'တစ်ခုခု မှားယွင်းနေပါသည်။ ထပ်မံကြိုးစားပါ။';

  @override
  String get nearYou => 'အနီးအနားရှိ ဆိုင်များ 😊';

  @override
  String get exploreNow => 'ဆိုင်များကို ကြည့်ရန်';

  @override
  String pointsLeftToTier(String points, String tier) {
    return '$tier Member ဖြစ်ရန် $points မှတ် လိုသေးသည်';
  }

  @override
  String memberTier(String tier) {
    return '$tier အဖွဲ့ဝင်';
  }

  @override
  String notificationCount(String count) {
    return 'အသိပေးချက် $count ခု';
  }

  @override
  String get noPromotionsAvailable => 'ပရိုမိုးရှင်း မရှိသေးပါ';

  @override
  String get homeRetry => 'ထပ်မံကြိုးစားရန်';

  @override
  String get seasonalSpecials => 'ရာသီအလိုက် အထူးအစီအစဉ်များ';

  @override
  String get popular => 'လူကြိုက်များသော 🔥';

  @override
  String get orderAgain => 'ထပ်မံမှာယူရန်';

  @override
  String nearbyShopCount(String count) {
    return 'အနီးအနားတွင် J’Donut ဆိုင် $count ဆိုင် ရှိပါသည်';
  }

  @override
  String get homeError => 'သိမ်းဆည်းထားသော ပင်မစာမျက်နှာဒေတာကို ဖွင့်မရပါ။';

  @override
  String get sectionLoadError => 'ဤအပိုင်းကို ဖွင့်မရပါ။';

  @override
  String get noNearbyShops => 'အနီးအနားတွင် ဆိုင်မတွေ့ပါ';

  @override
  String get orderOnline => 'အွန်လိုင်းမှာယူရန်';

  @override
  String get home => 'ပင်မ';

  @override
  String get rewards => 'ဆုလက်ဆောင်';

  @override
  String get order => 'မှာယူရန်';

  @override
  String get nearby => 'အနီးအနား';

  @override
  String get settings => 'ဆက်တင်များ';

  @override
  String get noProductsAvailableYet => 'ကုန်ပစ္စည်း မရှိသေးပါ';

  @override
  String discountOff(String discount) {
    return '$discount% လျှော့ဈေး';
  }

  @override
  String get account => 'အကောင့်';

  @override
  String get wallet => 'ပိုက်ဆံအိတ်';

  @override
  String get productUnavailable => 'ကုန်ပစ္စည်းကို မရရှိနိုင်ပါ။';

  @override
  String get newBadge => 'အသစ်';

  @override
  String get whatsThis => 'ဒါကဘာလဲ။';

  @override
  String get addToCart => 'ခြင်းထဲထည့်ရန်';

  @override
  String addedToCart(int quantity, String productName) {
    return '$quantity × $productName ကို ဈေးဝယ်ခြင်းတောင်းထဲ ထည့်ပြီးပါပြီ။';
  }

  @override
  String get onboardingTagline => 'စိတ်ခံစားချက်တိုင်းအတွက်\nဒိုးနတ်လေးတွေ';

  @override
  String get getStarted => 'စတင်ကြရအောင်';

  @override
  String get alreadyHaveAccount => 'အကောင့်ရှိပြီးသားလား။';

  @override
  String get googleSignIn => 'Google ဖြင့် ဝင်ရန်';

  @override
  String get appleSignIn => 'Apple ဖြင့် ဝင်ရန်';

  @override
  String get facebookSignIn => 'Facebook ဖြင့် ဝင်ရန်';

  @override
  String get legalNotice =>
      'ဆက်လက်လုပ်ဆောင်ခြင်းဖြင့် ကျွန်ုပ်တို့၏ အောက်ပါစည်းကမ်းချက်များကို ဖတ်ရှုပြီး သဘောတူကြောင်း အတည်ပြုပါသည်';

  @override
  String get termsOfUse => 'အသုံးပြုမှု စည်းကမ်းချက်များ';

  @override
  String get privacyPolicy => 'ကိုယ်ရေးအချက်အလက် မူဝါဒ';

  @override
  String get andLabel => 'နှင့်';

  @override
  String get enterPhoneNumber => 'ဖုန်းနံပါတ်\nထည့်ပါ';

  @override
  String get invalidMyanmarPhone => 'မှန်ကန်သော မြန်မာဖုန်းနံပါတ်ကို ထည့်ပါ။';

  @override
  String get verifyYourNumber => 'သင့်ဖုန်းနံပါတ်ကို အတည်ပြုပါ';

  @override
  String otpSentTo(String phone) {
    return '$phone သို့ ဂဏန်း ၆ လုံးပါ OTP ပို့ထားပါသည်';
  }

  @override
  String get tooManyIncorrectOtpAttempts =>
      'မှားယွင်းသော ကုဒ်ကို အကြိမ်များစွာ ထည့်သွင်းထားပါသည်။ ကုဒ်အသစ် ပြန်တောင်းပါ။';

  @override
  String get incorrectOtp => 'ကုဒ်မှားနေပါသည်။ ထပ်မံကြိုးစားပါ။';

  @override
  String get unregisteredPhone =>
      'ဤဖုန်းနံပါတ်ဖြင့် အကောင့်ဖွင့်ထားခြင်း မရှိသေးပါ။ ယခုပင် အကောင့်ဖွင့်ပါ။';

  @override
  String get unableToSignIn => 'အကောင့်ဝင်၍ မရပါ။ ထပ်မံကြိုးစားပါ။';

  @override
  String get tooManyAttemptsResend =>
      'ကြိုးစားမှု အကြိမ်ရေများနေပါသည်။ ကုဒ်အသစ် ပြန်တောင်းပြီး ထပ်ကြိုးစားပါ။';

  @override
  String get didntReceiveCode => 'ကုဒ်မရရှိဘူးလား။';

  @override
  String get whatsYourName => 'သင့်အမည်က\nဘာလဲ။';

  @override
  String get invalidFirstName => 'မှန်ကန်သော အမည်ကို ထည့်ပါ။';

  @override
  String get invalidNameCharacters => 'အက္ခရာများနှင့် space ကိုသာ အသုံးပြုပါ။';

  @override
  String get whatsYourDateOfBirth => 'သင့်မွေးသက္ကရာဇ်က\nဘယ်နေ့လဲ။';

  @override
  String get month => 'လ (1–12)';

  @override
  String get day => 'ရက်';

  @override
  String get year => 'နှစ်';

  @override
  String get invalidDateOfBirth => 'မှန်ကန်သော မွေးသက္ကရာဇ်ကို ထည့်ပါ။';

  @override
  String get invalidCalendarDate => 'ပြက္ခဒိန်အရ မှန်ကန်သော ရက်စွဲကို ထည့်ပါ။';

  @override
  String get futureDateOfBirth => 'မွေးသက္ကရာဇ်သည် ယနေ့ထက် နောက်ကျ၍ မရပါ။';

  @override
  String get minimumAgeError => 'အသက် ၁၃ နှစ်နှင့်အထက် ဖြစ်ရပါမည်။';

  @override
  String get registrationFailed => 'အကောင့်ဖွင့်၍ မရပါ။ ထပ်မံကြိုးစားပါ။';

  @override
  String featureDemoPlaceholder(String feature) {
    return '$feature သည် စမ်းသပ်ပြသရန်အတွက်သာ ဖြစ်ပါသည်။';
  }

  @override
  String get resendCode => 'ကုဒ်အသစ် ပြန်ပို့ရန်';

  @override
  String resendIn(String time) {
    return '$time ကြာလျှင် ကုဒ်အသစ် ပြန်ပို့နိုင်ပါသည်';
  }

  @override
  String get registerNow => 'ယခုပင် အကောင့်ဖွင့်ပါ';

  @override
  String get logoutConfirmationTitle => 'အကောင့်မှ ထွက်မှာ သေချာပါသလား?';

  @override
  String get logoutConfirmationMessage => 'သင့်အကောင့်မှ ထွက်ရန် သေချာပါသလား?';

  @override
  String get logoutFailed => 'အကောင့်မှ ထွက်၍မရပါ။ ထပ်မံကြိုးစားပါ။';

  @override
  String get logoutDescription =>
      'သင့်အကောင့်မှ ထွက်သွားပါမည်။ အချိန်မရွေး ပြန်လည်ဝင်ရောက်နိုင်ပါသည်။';

  @override
  String get loggingOut => 'အကောင့်မှ ထွက်နေပါသည်...';
}
