
// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'yhub_ui_localizations.dart';

// ignore_for_file: unnecessary_brace_in_string_interps

/// The translations for Arabic (`ar`).
class YHubUILocalizationsAr extends YHubUILocalizations {
  YHubUILocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get signIn => 'تسجيل الدخول';

  @override
  String get signUp => 'إنشاء حساب';

  @override
  String get signOut => 'تسجيل الخروج';

  @override
  String get forgotPassword => 'نسيت كلمة المرور؟';

  @override
  String get newHere => 'جديد؟ إنشاء حساب';

  @override
  String get alreadyRegistered => 'لدي حساب مسبقاً';

  @override
  String get accept => 'أوافق على';

  @override
  String get termsOfService => 'شروط الخدمة';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get and => 'و';

  @override
  String get resend => 'إعادة ارسال';

  @override
  String get code => 'رمز التحقق';

  @override
  String get change => 'تغيير؟';

  @override
  String get errorAcceptTermsOfService => 'عذراً، لا يمكنك المتابعه دون الموافقه';

  @override
  String get verifyYourPhone => 'التحقق من رقم الهاتف';

  @override
  String get verifyYourEmail => 'التحقق من البريد الالكتروني';

  @override
  String enterOTP(String username) {
    return 'ادخل الرمز المرسل الى ${username}';
  }
}
