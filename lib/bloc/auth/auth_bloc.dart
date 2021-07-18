import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:test_app/model/google_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  late GoogleAuthInfo _currentAuthInfo;

  AuthBloc() : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is GoogleSignInEvent) {
      try {
        _currentAuthInfo = await googleAuth();
        yield GoogleSignInSuccessState();
      } catch (e) {
        debugPrint('GoogleSignInEvent got exception: $e');
        if (e is PlatformException &&
            e.code == GoogleSignIn.kSignInCanceledError) {
          yield GoogleSignInCancelState();
        }
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

  Future<void> _signOutFromGoogle() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  ///

  String? get email => _currentAuthInfo.email;

  String? get googleId => _currentAuthInfo.id;

  String? get photoUrl => _currentAuthInfo.photoUrl;

  String? get displayName => _currentAuthInfo.displayName;
}
