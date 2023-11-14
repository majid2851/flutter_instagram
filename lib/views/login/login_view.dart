import 'package:flutter/material.dart';
import 'package:flutter_instagram/state/auth/providers/auth_state_provider.dart';
import 'package:flutter_instagram/views/login/divider_with_margin.dart';
import 'package:flutter_instagram/views/login/google_button.dart';
import 'package:flutter_instagram/views/login/login_view_signup_links.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../constatns/app_colors.dart';
import '../constatns/strings.dart';

class LoginView extends ConsumerWidget
{
  const LoginView({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref)
  {
    return Scaffold(
      appBar: AppBar(title:Text(Strings.appName),),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 40,),
              Text(
                Strings.welcomeToAppName,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const DivierWithWidget(),
              Text(
                Strings.logIntoYourAccount,
                style: Theme.of(context)
                  .textTheme.subtitle1?.copyWith(height: 1.5),
              ),
              const SizedBox(height: 20,),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.loginButtonColor,
                  foregroundColor: AppColors.loginButtonTextColor,
                ),
                onPressed: () {
                  ref.read(authStateProvider.notifier).loginWithGoogle();
                },
                child:const GoogleButton() ,
              ),
              const DivierWithWidget(),
              const LoginViewSignupLinks()

            ],
          ),
        ),
      ),
    );
  }
}
