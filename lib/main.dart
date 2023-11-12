import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_instagram/state/auth/models/auth_result.dart';
import 'package:flutter_instagram/state/auth/providers/auth_state_provider.dart';
import 'package:flutter_instagram/state/auth/providers/is_logged_in_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'firebase_options.dart';

import 'widget/main_view.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child:MyApp(),));
}

class MyApp extends StatelessWidget
{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
        indicatorColor: Colors.blueGrey
      ),
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch:Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Consumer(
        builder: (context,ref,child){
          final isLoggedIn=ref.watch(authStateProvider).result
            == AuthResult.success;
          if(isLoggedIn){
            return MainView();
          }else{
            return LoginView();
          }
        },
      ),

    );
  }
}

