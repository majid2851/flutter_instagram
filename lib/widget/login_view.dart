
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../state/auth/providers/auth_state_provider.dart';

class LoginView extends ConsumerWidget
{
  @override
  Widget build(BuildContext context,WidgetRef ref)
  {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('LoginView'),),
        ),
        body: TextButton(onPressed:() async {
          await ref.read(authStateProvider.notifier).loginWithGoogle();
        },
        child: const Text(
            'Sign In With Google'
        )
      ),
    );
  }

}