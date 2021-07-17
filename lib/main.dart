import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/bloc/auth/auth_bloc.dart';
import 'package:test_app/bloc/tweet/tweet_bloc.dart';
import 'package:test_app/screen/login_screen.dart';
import 'package:test_app/screen/twitter_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<AuthBloc>(
        create: (_) => AuthBloc(),
        child: Builder(
          builder: (providerContext) => BlocListener<AuthBloc, AuthState>(
            bloc: BlocProvider.of<AuthBloc>(providerContext),
            listener: (authContext, authState) {
              print('BlocListener got authState: $authState');
            },
            child: BlocBuilder<AuthBloc, AuthState>(
              bloc: BlocProvider.of<AuthBloc>(providerContext),
              builder: (authContext, authState) {
                if (authState is AuthInitial) {}
                if (authState is NoneAuthState) {}
                if (authState is GoogleSignInSuccessState) {
                  return BlocProvider(
                    create: (providerContext) => TweetBloc(providerContext),
                    child: TwitterScreen(),
                  );
                }
                return LoginScreen();
              },
            ),
          ),
        ),
      ),
    );
  }
}
