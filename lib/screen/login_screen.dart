import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('1-Person Twitter')),
      body: _body,
    );
  }

  /// getter
  ///

  Widget get _body {
    return Center(
      child: ElevatedButton(
        child: Text('Google SignIn'),
        onPressed: () {},
      ),
    );
  }
}
