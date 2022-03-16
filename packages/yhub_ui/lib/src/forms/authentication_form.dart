import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:yhub_ui/l10n/yhub_ui_localizations.dart';

class AuthenticationForm extends StatefulWidget {
  final List<Widget> Function(bool isSignIn) fields;
  final List<Widget> Function(bool isSignIn)? children;

  final bool enabled;

  final Widget logo;
  final Widget? slogan;

  final Function()? onForgot;
  final Function()? onAskTermsOfService;
  final Function()? onAskPrivacyPolicy;
  final Function(bool isSignIn)? onChanged;
  final Function(bool isSignIn) onSubmit;

  const AuthenticationForm({
    Key? key,
    this.enabled = true,
    required this.logo,
    this.slogan,
    required this.fields,
    this.onChanged,
    required this.onSubmit,
    this.onForgot,
    this.onAskTermsOfService,
    this.onAskPrivacyPolicy,
    this.children,
  }) : super(key: key);

  @override
  AuthenticationFormState createState() => AuthenticationFormState();
}

class AuthenticationFormState extends State<AuthenticationForm> {
  bool _isLoading = false;
  bool _isSignIn = true;
  bool _isAgree = false;

  bool get isLoading => _isLoading;
  bool get isSignIn => _isSignIn;

  void showLoading() {
    setState(() {
      _isLoading = true;
    });
  }

  void hideLoading() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: widget.logo,
        ),
        if (widget.slogan != null) widget.slogan!,
        const SizedBox(height: 16),
        ...widget.fields(_isSignIn),
        if (_isSignIn) ...[
          if (widget.onForgot != null)
            Row(
              children: [
                Spacer(),
                TextButton(
                  style: Theme.of(context).textButtonTheme.style,
                  onPressed: widget.onForgot,
                  child: Text(
                    YHubUILocalizations.of(context)!.forgotPassword,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontSize: 14,
                        ),
                  ),
                ),
              ],
            )
          else
            const SizedBox(height: 16.0),
        ] else ...[
          if (widget.onAskTermsOfService != null ||
              widget.onAskPrivacyPolicy != null)
            _buildAgreeCheckbox(),
          const SizedBox(height: 16.0),
        ],
        ElevatedButton.icon(
          icon: _isLoading
              ? SizedBox(
                  height: 28,
                  width: 28,
                  child: CircularProgressIndicator(
                    strokeWidth: 3.0,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor,
                    ),
                  ),
                )
              : SizedBox(),
          label: _isLoading
              ? SizedBox()
              : Text(
                  _isSignIn
                      ? YHubUILocalizations.of(context)!.signIn
                      : YHubUILocalizations.of(context)!.signUp,
                ),
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).primaryColor,
            minimumSize: const Size(double.infinity, 48.0),
            shape: const StadiumBorder(),
          ),
          onPressed: (!widget.enabled || _isLoading)
              ? null
              : () => widget.onSubmit(_isSignIn),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          child: Text(
            _isSignIn
                ? YHubUILocalizations.of(context)!.newHere
                : YHubUILocalizations.of(context)!.alreadyRegistered,
          ),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 48.0),
            primary: Theme.of(context).backgroundColor,
            onPrimary: Theme.of(context).colorScheme.secondary,
            shape: const StadiumBorder(),
          ),
          onPressed: (!widget.enabled || _isLoading) ? null : _onChange,
        ),
        if (widget.children != null) ...widget.children!(_isSignIn),
      ],
    );
  }

  void toggle() {
    setState(() {
      _isSignIn = !_isSignIn;
    });
  }

  _onChange() {
    toggle();

    if (widget.onChanged != null) widget.onChanged!(_isSignIn);
  }

  Widget _buildAgreeCheckbox() {
    return FormField<bool>(
      initialValue: false,
      validator: (value) {
        if (!value!)
          return YHubUILocalizations.of(context)!.errorAcceptTermsOfService;

        return null;
      },
      onSaved: (value) => _isAgree = value!,
      builder: (FormFieldState<bool> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CheckboxListTile(
              dense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
              title: Wrap(
                children: [
                  Text.rich(
                    TextSpan(
                      text: YHubUILocalizations.of(context)!.accept,
                      style: Theme.of(context).textTheme.bodyText2,
                      children: <TextSpan>[
                        if (widget.onAskTermsOfService != null)
                          TextSpan(
                            text:
                                ' ${YHubUILocalizations.of(context)!.termsOfService}',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = widget.onAskTermsOfService,
                          ),
                        if (widget.onAskTermsOfService != null &&
                            widget.onAskPrivacyPolicy != null)
                          TextSpan(
                            text: ' ${YHubUILocalizations.of(context)!.and}',
                          ),
                        if (widget.onAskPrivacyPolicy != null) ...[
                          TextSpan(
                            text:
                                '${widget.onAskTermsOfService == null ? ' ' : ''}${YHubUILocalizations.of(context)!.privacyPolicy}',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = widget.onAskPrivacyPolicy,
                          ),
                        ]
                      ],
                    ),
                  ),
                ],
              ),
              controlAffinity: ListTileControlAffinity.leading,
              value: state.value,
              onChanged: (_) => state.didChange(!state.value!),
            ),
            if (state.hasError)
              Text(
                state.errorText!,
                style: Theme.of(state.context)
                    .textTheme
                    .caption!
                    .copyWith(color: Colors.red),
              ),
          ],
        );
      },
    );
  }
}
