import 'dart:io';

import 'package:notes_app/layout/cubit/cubit.dart';
import 'package:notes_app/modules/social_login/social_login_screen.dart';
import 'package:notes_app/shared/components/componets.dart';
import 'package:notes_app/shared/network/local/cache_helper.dart';


String ?token = '';
String ?uId = '';


void signOut(context) {

  CacheHelper.removeData(key:'uId');
  // uId = CacheHelper.getData(key: 'uId');
  navigateAndFinish(
    context,
    SocialLoginScreen(),
  );
  SocialCubit.get(context).currentIndex=0;
  SocialCubit.get(context).users=[];
  SocialCubit.get(context).posts=[];
  SocialCubit.get(context).postsId=[];
  SocialCubit.get(context).likes=[];
}

String getOS(){
  return Platform.operatingSystem;
}

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
