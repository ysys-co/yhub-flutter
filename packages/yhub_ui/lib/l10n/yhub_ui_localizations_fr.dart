


import 'yhub_ui_localizations.dart';

/// The translations for French (`fr`).
class YHubUILocalizationsFr extends YHubUILocalizations {
  YHubUILocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get signIn => 'S\'identifier';

  @override
  String get signUp => 'S\'inscrire';

  @override
  String get signOut => 'Déconnexion';

  @override
  String get forgotPassword => 'Mot de passe oublié?';

  @override
  String get newHere => 'Nouveau ici? S\'inscrire';

  @override
  String get alreadyRegistered => 'Déjà enregistré';

  @override
  String get accept => 'J\'accepte';

  @override
  String get termsOfService => 'Conditions de Service';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get and => 'et ';

  @override
  String get resend => 'Renvoyer';

  @override
  String get code => 'Code';

  @override
  String get change => ' changement?';

  @override
  String get errorAcceptTermsOfService => 'Désolé, vous ne pouvez pas continuer sans accepter';

  @override
  String get verifyYourPhone => 'Vérifiez votre téléphone';

  @override
  String get verifyYourEmail => 'Vérifiez votre e-mail';

  @override
  String enterOTP(String username) {
    return 'Saisissez l\'OTP envoyé à $username ';
  }
}
