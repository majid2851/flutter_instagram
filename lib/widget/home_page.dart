

import 'package:flutter/material.dart';
import 'package:flutter_instagram/state/auth/backend/authentication.dart';

class HomePage extends StatelessWidget
{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Instagram')),
      ),
      body: Column(
        children: [
          TextButton(
            onPressed:() async
            {
              final result = await Authenticator().loginWithGoogle();
              print(result);
            },
            child: const Text(
                'Sign In With Google'
            )
          )
        ],
      ),
    );
  }
}
