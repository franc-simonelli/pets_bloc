import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:petsguide/model/logged_user_mode.dart';
import 'package:petsguide/service/secure_service.dart';

class DrawerService {
  
  Future getUser() async {
    SecureService secureService = Injector().get<SecureService>();
    LoggedUser? user = await secureService.getLoggedUser();

    if(user!.displayName!.isNotEmpty) {
      var name = getWord(user.displayName!, 0);
      var surname = getWord(user.displayName!, 1);
      user.userInitial = name[0]+surname[0];
    }

    return user;
    
  }

  getWord(String inputString, index) {
    List<String> wordList = inputString.split(" ");
    if (wordList.isNotEmpty) {
      return wordList[index].toUpperCase();
    } else {
      return ' ';
    }
  }


}