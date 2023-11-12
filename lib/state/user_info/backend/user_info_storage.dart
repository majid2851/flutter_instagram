import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram/state/constants/firebase_collection_name.dart';
import 'package:flutter_instagram/state/constants/firebase_field_name.dart';
import 'package:flutter_instagram/state/posts/typedefs/user_id.dart';
import 'package:flutter_instagram/state/user_info/models/user_info_payload.dart';

@immutable
class UserInfoStorage
{
  const UserInfoStorage();

  Future<bool> saveUserInfo({
    required UserId userId,
    required String displayName,
    required String? email,
  }) async{
    try{

      //first we check that we already have user or not
      final userInfo=await FirebaseFirestore
          .instance
          .collection(FirebaseCollectionName.users)
          .where(FirebaseFieldName.userId,isEqualTo: userId)
          .limit(1)
          .get();

      if(userInfo.docs.isNotEmpty)
      {
        //if not empty then users exists already
        await userInfo.docs.first.reference.update({
          FirebaseFieldName.displayName : displayName,
          FirebaseFieldName.email : email ?? '',
        });
        return true;
      }

      //user doesn't exist
      final payload = UserInfoPayload(
          userId: userId,
          displayName: displayName,
          email: email
      );
      await FirebaseFirestore.instance.collection(
          FirebaseCollectionName.users
      ).add(payload);

      return true;
    }catch(e){
      return false;
    }





  }

}