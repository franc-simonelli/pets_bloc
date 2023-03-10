// ignore_for_file: must_be_immutable, no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:go_router/go_router.dart';
import 'package:petsguide/service/secure_service.dart';


class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  late Timer timer;
  late bool isLogged = false;
  
  init(context)async {
    SecureService _secureService = Injector().get<SecureService>();
    isLogged = await _secureService.isLogged();

    // timer = Timer(
    //   const Duration(seconds: 3),() {
    //     if(isLogged) {
    //       context.go('/home');
    //       // r.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
    //     } else {
    //       context.go('/init');
    //       // Navigator.of(context).push(MaterialPageRoute(builder: (context) => InitScreen()));
    //     }
    //   }
    // );
  }


  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    init(context);
    timer = Timer(
      const Duration(seconds: 3),() {
        if(isLogged) {
          context.go('/dashboard');
        } else {
          context.go('/init');
        }
      }
    );
    
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('contents/images/logo.png', height: 80,),
            Text('Gattolandia', style: theme.textTheme.displaySmall),
            
          ],
        ),
      ),    
    );
  }
}

