import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthBloc() : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is GoogleSignInEvent) {
      try {
        var result = await _googleAuth();
        if (result is GoogleSignInAuthentication) {
          yield GoogleSignInSuccessState();
        } else {
          yield GoogleSignInFailState(result);
        }
      } catch (e) {
        debugPrint('GoogleSignInEvent got exception: $e');
        yield GoogleSignInFailState(e);
      }
    }
    if (event is GoogleSignOutEvent) {
      try {
        await _signOutFromGoogle();
        yield NoneAuthState();
      } catch (e) {
        debugPrint('GoogleSignInEvent got exception: $e');
        yield NoneAuthState();
      }
    }
  }

  /// private method
  ///

  Future<GoogleSignInAuthentication> _googleAuth() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );
    final gSignIn = await googleSignIn.signIn();
    return await gSignIn!.authentication;
  }

  Future<void> _signOutFromGoogle() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  ///

  String? get email => _googleSignIn.currentUser?.email;

  String? get googleId => _googleSignIn.currentUser?.id;

  String? get photoUrl => _googleSignIn.currentUser?.photoUrl;
}
