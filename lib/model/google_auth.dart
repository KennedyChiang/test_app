import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<GoogleAuthInfo> googleAuth() async {
  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );
  final result = await googleSignIn.signIn();
  if (false == result is GoogleSignInAccount) {
    throw PlatformException(code: GoogleSignIn.kSignInCanceledError);
  }
  GoogleSignInAuthentication? authentication = await result!.authentication;

  return GoogleAuthInfo(
    displayName: result.displayName,
    email: result.email,
    id: result.id,
    photoUrl: result.photoUrl,
    authentication: authentication,
  );
}

class GoogleAuthInfo {
  final String? displayName;
  final String email;
  final String id;
  final String? photoUrl;
  final GoogleSignInAuthentication authentication;
  GoogleAuthInfo({
    required this.displayName,
    required this.email,
    required this.id,
    required this.photoUrl,
    required this.authentication,
  });
}
