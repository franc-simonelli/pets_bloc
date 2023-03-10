import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:petsguide/model/logged_user_mode.dart';
import 'package:petsguide/service/google_service.dart';
import 'package:petsguide/service/secure_service.dart';

class LoginService {

  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth auth = FirebaseAuth.instance;

  loginWithEmailAndPassword(email, password) async{
    try {
      var result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      LoggedUser user = LoggedUser();
      user.email = result.user!.email;
      user.userId = result.user!.uid;
      user.emailVerified = result.user!.emailVerified;
      SecureService secureService = Injector().get<SecureService>();
      await secureService.setLoggedUser(user);
      // Get.snackbar('OK', 'OK');
      // Get.to(const HomeScreen());
      return true;
    }
    on FirebaseAuthException catch (e) {
      // Get.snackbar('Errore', e.message.toString());
    }
  }

  Future signInwithGoogle() async {
    // loadingGoogle.value = true;
    // loadingGoogle.refresh();
    GoogleService loginGoogleService = Injector().get<GoogleService>();
    final result = await loginGoogleService.signInwithGoogle();
    
    SecureService secureService = Injector().get<SecureService>();
    LoggedUser user = LoggedUser();
    user.displayName = result.user.displayName;
    user.email = result.user.email;
    user.emailVerified = result.user.emailVerified;
    user.photoURL = result.user.photoURL;
    user.userId = result.user.uid;
    await secureService.setLoggedUser(user);
    
    // loadingGoogle.value = false;
    // loadingGoogle.refresh();
  }

  Future<void> signOut() async{
    await googleSignIn.signOut();
    await auth.signOut();
    await FirebaseAuth.instance.signOut();
    SecureService secureService = Injector().get<SecureService>();
    secureService.setLoggedUser(null);
  }

}