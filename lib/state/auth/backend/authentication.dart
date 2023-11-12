

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../posts/typedefs/user_id.dart';
import '../constants/constants.dart';
import '../models/auth_result.dart';

class Authenticator
{
  const Authenticator();

  UserId ? get userId
  {
    return FirebaseAuth.instance
        .currentUser?.uid;
  }
  bool get isAlreadyLoggedIn{
    return userId !=null;
  }

  String get displayName
  {
    return FirebaseAuth.instance.
      currentUser?.displayName ?? '';
  }
  String? get email {
    FirebaseAuth.instance.currentUser?.email ?? '';
  }

  Future<void> logOut() async
  {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    // await FacebookAuth.instance.logOut();

  }
  Future<AuthResult> loginWithGoogle() async
  {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        Constants.emailScope,
      ],
    );
    final signInAccount = await googleSignIn.signIn();
    if(signInAccount==null){
      return AuthResult.aborted;
    }
    final googleAuth = await signInAccount.authentication;
    final oauthCredential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    try{
      await FirebaseAuth.
        instance.signInWithCredential(oauthCredential);

      return AuthResult.success;
    }catch(e){
      print("Error during Google Sign-In: $e");
      return AuthResult.failure;
    }

  }







}