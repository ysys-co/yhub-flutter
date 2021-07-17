


import 'yhub_ui_localizations.dart';

/// The translations for English (`en`).
class YHubUILocalizationsEn extends YHubUILocalizations {
  YHubUILocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get signIn => 'Sign in';

  @override
  String get signUp => 'Sign up';

  @override
  String get signOut => 'Sign out';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get newHere => 'New here? Sign up';

  @override
  String get alreadyRegistered => 'Already registered';

  @override
  String get accept => 'I Accept';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get and => 'and ';

  @override
  String get resend => 'Resend';

  @override
  String get code => 'Code';

  @override
  String get change => 'change?';

  @override
  String get errorAcceptTermsOfService => 'Sorry, you can\'t continue without accept';

  @override
  String get verifyYourPhone => 'Verify your phone';

  @override
  String get verifyYourEmail => 'Verify your email';

  @override
  String enterOTP(String username) {
    return 'Enter the OTP sent to $username';
  }
}
