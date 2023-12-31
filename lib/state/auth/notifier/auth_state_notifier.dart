
import 'package:flutter_instagram/state/auth/backend/authentication.dart';
import 'package:flutter_instagram/state/auth/models/auth_result.dart';
import 'package:flutter_instagram/state/posts/typedefs/user_id.dart';
import 'package:flutter_instagram/state/user_info/backend/user_info_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/auth_state.dart';

class AuthStateNotifier extends StateNotifier<AuthState>
{
  final _authenticator = const Authentication();
  final _userInfoStorage = const UserInfoStorage();

  AuthStateNotifier():super(const AuthState.unknown())
  {
    if(_authenticator.isAlreadyLoggedIn)
    {
      state = AuthState(
          result: AuthResult.success,
          isLoading:false,
          userId:_authenticator.userId,
      );
    }
  }
  Future<void> logOut() async
  {
    state = state.copiedWithIsLoading(true);
    await _authenticator.logOut();
    state=const AuthState.unknown();
  }
  Future<void> loginWithGoogle() async
  {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.loginWithGoogle();
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(userId: userId);
    }
    state=AuthState(
        result: result,
        isLoading: false,
        userId: userId
    );
  }

  Future<void> saveUserInfo({
    required UserId userId,
  }){
    return _userInfoStorage.saveUserInfo(
        userId: userId,
        displayName: _authenticator.displayName,
        email: _authenticator.email,
    );

  }



}









