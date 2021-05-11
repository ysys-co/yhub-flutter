import 'package:flutter/material.dart';
import 'package:yhub_ui/yhub_ui.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: YHubUILocalizations.localizationsDelegates,
      supportedLocales: YHubUILocalizations.supportedLocales,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => AuthenticationPage())),
              child: Text('Authentication Page'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => VerificationPage())),
              child: Text('Verification Page'),
            ),
          ],
        ),
      ),
    );
  }
}

class AuthenticationPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _authKey = GlobalKey<AuthenticationFormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: AuthenticationForm(
              key: _authKey,
              logo: Text('My Logo'),
              slogan: Text('Hello World'),
              fields: (isSignIn) => [
                if (!_authKey.currentState!.isSignIn)
                  TextFormField(
                    key: Key('name'),
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                TextFormField(
                  key: Key('email'),
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextFormField(
                  key: Key('password'),
                  decoration: InputDecoration(labelText: 'Password'),
                ),
              ],
              onAskPrivacyPolicy: () {},
              onAskTermsOfService: () {},
              onChanged: (_) {
                _formKey.currentState!.reset();
              },
              onSubmit: (isSignIn) async {
                await Future.delayed(Duration(seconds: 3));
                print('Success');
              },
            ),
          ),
        ),
      ),
    );
  }
}

class VerificationPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: VerificationForm(
              username: '9677737472',
              onSumbit: (int a) {
                print('a:$a');
              },
              onCancel: () {},
              resend: VerificationResend(
                onSumbit: () async {
                  await Future.delayed(Duration(seconds: 3));

                  return false;
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
