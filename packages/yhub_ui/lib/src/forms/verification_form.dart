import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:yhub_ui/l10n/yhub_ui_localizations.dart';
import 'package:yhub_ui/yhub_ui.dart';

enum VerificationMethod { phone, email }

class VerificationForm extends StatefulWidget {
  final GlobalKey<FormState>? formKey;

  final int? length;
  final String username;
  final VerificationMethod? method;

  final Function() onCancel;
  final Function()? onResend;
  final Function(int code) onSumbit;

  const VerificationForm({
    Key? key,
    this.formKey,
    this.method = VerificationMethod.phone,
    this.length = 6,
    required this.username,
    required this.onCancel,
    this.onResend,
    required this.onSumbit,
  })   : assert(length != null),
        super(key: key);

  @override
  _VerificationFormState createState() => _VerificationFormState();
}

class _VerificationFormState extends State<VerificationForm> {
  int? _timeout;

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
            onChanged: (_) {},
          ),
          const SizedBox(height: 8.0),
          TextButton(
            onPressed: () {},
            child: Text(
              YHubUILocalizations.of(context)!.resend,
            ),
          ),
          if (widget.onResend != null)
            StatefulBuilder(
              builder: (context, setState) {
                return ListTile(
                  leading: Icon(Icons.textsms_outlined),
                  title: Text(YHubUILocalizations.of(context)!.resend),
                  trailing: _timeout != null ? Text(_timeout.toString()) : null,
                  onTap: widget.onResend!,
                  enabled: _timeout == 0,
                );
              },
            ),
        ],
      ),
    );
  }
}
