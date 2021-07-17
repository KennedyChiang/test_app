import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:test_app/bloc/auth/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _body),
    );
  }

  /// getter
  ///

  Widget get _body {
    return Column(
      children: [
        Container(
          constraints: BoxConstraints.tightFor(
            width: double.infinity,
            height: kToolbarHeight,
          ),
          child: Center(
            child: FaIcon(
              FontAwesomeIcons.twitter,
              color: Colors.blue,
              size: 28.0,
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: ElevatedButton.icon(
              icon: FaIcon(
                FontAwesomeIcons.googlePlusG,
              ),
              label: Text('SignIn'),
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(GoogleSignInEvent());
              },
            ),
          ),
        ),
      ],
    );
  }
}
