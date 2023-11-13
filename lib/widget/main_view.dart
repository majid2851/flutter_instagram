

import 'package:flutter/material.dart';
import 'package:flutter_instagram/state/auth/backend/authentication.dart';
import 'package:flutter_instagram/state/auth/providers/auth_state_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../views/components/loading/loading_screen.dart';

class MainView extends StatelessWidget
{
  const MainView({super.key});

  @override
  Widget build(BuildContext context,)
  {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Main View')),
      ),
      body: Consumer(
          builder: (context,ref,child)
          {
            return TextButton(
              child: Text('Logout'),
              onPressed: () async {
                ref.read(authStateProvider.notifier).logOut();
              },
            );
          }
      ),
     );
  }

}

