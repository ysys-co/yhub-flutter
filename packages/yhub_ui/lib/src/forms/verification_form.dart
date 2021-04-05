import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:yhub_ui/l10n/yhub_ui_localizations.dart';
import 'package:yhub_ui/yhub_ui.dart';

enum VerificationMethod { phone, email }

class VerificationResend {
  final Future Function() onSumbit;
  final Duration duration;
  final int Function()? attempts;

  const VerificationResend({
    required this.onSumbit,
    this.attempts,
    this.duration = const Duration(seconds: 60),
  });
}

class VerificationForm extends StatefulWidget {
  final GlobalKey<FormState>? formKey;

  final int? length;
  final String username;
  final VerificationMethod? method;

  final Function() onCancel;
  final Function(int code) onSumbit;
  final VerificationResend? resend;

  const VerificationForm({
    Key? key,
    this.formKey,
    this.method = VerificationMethod.phone,
    this.length = 6,
    required this.username,
    required this.onCancel,
    this.resend,
    required this.onSumbit,
  })   : assert(length != null),
        super(key: key);

  @override
  _VerificationFormState createState() => _VerificationFormState();
}

class _VerificationFormState extends State<VerificationForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              widget.method == VerificationMethod.phone
                  ? YHubUILocalizations.of(context)!.verifyYourPhone
                  : YHubUILocalizations.of(context)!.verifyYourEmail,
              style: Theme.of(context).textTheme.headline6,
            ),
            subtitle: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: YHubUILocalizations.of(context)!
                        .enterOTP(widget.username),
                  ),
                  TextSpan(
                    text: ' ${YHubUILocalizations.of(context)!.change}',
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                    recognizer: TapGestureRecognizer()..onTap = widget.onCancel,
                  ),
                ],
              ),
            ),
          ),
          OTPTextField(
            length: widget.length!,
            width: MediaQuery.of(context).size.width,
            fieldWidth: 28,
            style: TextStyle(fontSize: 20),
            textFieldAlignment: MainAxisAlignment.spaceAround,
            fieldStyle: FieldStyle.underline,
            onCompleted: (value) => widget.onSumbit(int.parse(value)),
          ),
          const SizedBox(height: 8.0),
          if (widget.resend != null) _ResendCounter(widget.resend!)
        ],
      ),
    );
  }
}

class _ResendCounter extends StatefulWidget {
  final VerificationResend resend;

  const _ResendCounter(this.resend);

  @override
  _ResendCounterState createState() => _ResendCounterState();
}

class _ResendCounterState extends State<_ResendCounter> {
  int _timeout = 0;
  int _attempts = 0;
  Timer? _timer;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.resend.attempts != null) _attempts = widget.resend.attempts!();
    _countdown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  _countdown() {
    _timeout = widget.resend.duration.inSeconds * (++_attempts);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        --_timeout;
      });

      if (_timeout == 0) timer.cancel();
    });
  }

  String get remaining {
    int seconds = _timeout;
    int hours = (seconds / 3600).truncate();
    seconds = (seconds % 3600).truncate();
    int minutes = (seconds / 60).truncate();

    String hoursStr = (hours).toString().padLeft(2, '0');
    String minutesStr = (minutes).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    if (hours == 0) {
      return '$minutesStr:$secondsStr';
    }

    return '$hoursStr:$minutesStr:$secondsStr';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton.icon(
          label: Text(
            YHubUILocalizations.of(context)!.resend,
          ),
          icon: _isLoading
              ? SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                )
              : SizedBox(),
          onPressed: (_isLoading || _timeout == 0)
              ? () {
                  setState(() {
                    _isLoading = true;
                  });

                  widget.resend.onSumbit().whenComplete(() {
                    _countdown();

                    setState(() {
                      _isLoading = false;
                    });
                  });
                }
              : null,
        ),
        if (_timeout > 0) Text(' • $remaining'),
      ],
    );
  }
}
