

import 'package:flutter/material.dart';
import 'package:flutter_instagram/state/image_upload/helpers/image_picker_helper.dart';
import 'package:flutter_instagram/state/image_upload/models/file_type.dart';
import 'package:flutter_instagram/state/post_settings/providers/post_setting_provider.dart';
import 'package:flutter_instagram/views/components/dialog/alert_dialog_model.dart';
import 'package:flutter_instagram/views/components/dialog/logout_dialog.dart';
import 'package:flutter_instagram/views/create_new_post/create_new_post_view.dart';
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
                    final videoFile = await ImagePickerHelper.pickVideoFromGallery();
                    if(videoFile==null){
                      return;
                    }
                    ref.refresh(postSettingProvider);
                    //if we don't do that,the next time previous setting
                    //will set for the recent post

                    //go to the screen to create a new post
                    if(!mounted){
                      // In the code you provided, the mounted check
                      // is used to ensure that the widget is still
                      // in the widget tree before attempting to
                      // navigate to another screen using Navigator.
                      // push. If a widget is not in the widget tree
                      // (i.e., it has been disposed of),
                      // attempting to perform actions on it,
                      // such as navigating to another screen,
                      // can lead to errors.
                      return;
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                           builder: (_) => CreateNewPostView(
                               fileToPost: videoFile,
                               fileType: FileType.video
                           )
                        ),

                    );

                  },
                  icon: FaIcon(FontAwesomeIcons.film),
              ),
              IconButton(
                onPressed:() async{
                  final imageFile = await ImagePickerHelper.pickImageFromGallery();
                  if(imageFile==null){
                    return;
                  }
                  ref.refresh(postSettingProvider);
                  //if we don't do that,the next time previous setting
                  //will set for the recent post

                  //go to the screen to create a new post
                  if(!mounted){
                    return;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => CreateNewPostView(
                            fileToPost: imageFile,
                            fileType: FileType.image
                        )
                    ),

                  );
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
