

import 'package:flutter/material.dart';
import 'package:flutter_instagram/views/components/dialog/alert_dialog_model.dart';
import 'package:flutter_instagram/views/components/dialog/logout_dialog.dart';
import 'package:flutter_instagram/views/tabs/users_posts/user_posts_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../state/auth/providers/auth_state_provider.dart';
import '../constatns/strings.dart';

class MainView extends ConsumerStatefulWidget
{
  const MainView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView>
{
  @override
  Widget build(BuildContext context)
  {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(Strings.appName),
            actions: [
              IconButton(
                  onPressed:() async{

                  },
                  icon: FaIcon(FontAwesomeIcons.film),
              ),
              IconButton(
                onPressed:() async{

                },
                icon: Icon(Icons.add_photo_alternate_outlined),
              ),
              IconButton(
                onPressed:() async{
                  final shouldLogout=await LogoutDialog().present(context)
                    .then((value)=>value ?? false);

                  if(shouldLogout){
                    await ref.read(authStateProvider.notifier).logOut();
                  }
                },
                icon: Icon(Icons.logout),
              ),
            ],
            bottom:const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.person,)),
                Tab(icon: Icon(Icons.search),),
                Tab(icon: Icon(Icons.home),),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              UserPostsView(),
              UserPostsView(),
              UserPostsView(),

            ],
          ),
        )
    );
  }
}
