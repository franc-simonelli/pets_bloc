// ignore_for_file: empty_catches, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:petsguide/screen/preferiti/preferiti_screen.dart';
import 'package:petsguide/service/login_service.dart';
import 'widget/user_info_widget.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key, this.functionOpenClose, this.functionNavigatePreferiti, this.functionNavigatePunteggi});
  final functionOpenClose;
  final functionNavigatePreferiti;
  final functionNavigatePunteggi;

  @override
  Widget build(BuildContext context) {
    // final LoginController loginController = Get.put(LoginController());
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            UserInfo(
              openAndCloseDrawer: () {
                functionOpenClose();
              }
            ),
            // SizedBox(height: 60),
            build_option_widget(theme, context, functionNavigatePreferiti, functionNavigatePunteggi),
            
            build_logout_widget(theme, context)
          ],
        ),
      ),
    );
  }

  Widget build_logout_widget(ThemeData theme, context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, bottom: 30),
        child: GestureDetector(
          onTap: () {
            showDialog<void>(
              context: context,
              barrierDismissible: false, // user must tap button!
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: theme.backgroundColor,
                  contentTextStyle: theme.textTheme.labelMedium,
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(FontAwesomeIcons.circleQuestion, size: 40,),
                        const SizedBox(height: 40),
                        Text('Sei sicuro di voler uscire?', style: theme.textTheme.bodyMedium,),
                        const SizedBox(height: 80),
                        Column(
                          children: [
                            const Divider(),
                            const SizedBox(height: 10,),
                            GestureDetector(
                              onTap: () async{
                                try{
                                  LoginService loginService = Injector().get<LoginService>();
                                  await loginService.signOut();
                                  context.go('/init');
                                }
                                catch(err){
                                }
                              },
                              child: Text('Conferma', style: theme.textTheme.bodySmall)
                            ),
                            const SizedBox(height: 10),
                            const Divider(),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: (() {
                                Navigator.pop(context);
                              }),
                              child: Text('Annulla', style: theme.textTheme.bodySmall)
                            )
                          ],
                        )
                      ],
                    ),
                  )
                );
              },
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                color: theme.secondaryHeaderColor.withOpacity(0.5),
                indent: 0,
                endIndent: 30,
                thickness: 1,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.logout_outlined, color: Colors.white,),
                  const SizedBox(width: 20,),
                  Text('Logout', style: theme.textTheme.bodySmall!.copyWith(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                ],
              
              )
            ]
          )
        ),
      ),
    );
  }

  Widget build_option_widget(ThemeData theme, context, functionNavigatePreferiti, functionNavigatePunteggi) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 300),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            color: theme.secondaryHeaderColor.withOpacity(0.2),
            indent: 0,
            endIndent: 30,
            thickness: 1,
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: functionNavigatePreferiti,
            child: build_row_widget(theme, Icons.favorite_border_outlined, 'I tuoi preferiti')
          ),
          const SizedBox(height: 10),
          Divider(
            color: theme.secondaryHeaderColor.withOpacity(0.2),
            indent: 0,
            endIndent: 30,
            thickness: 1,
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: functionNavigatePunteggi,
            child: build_row_widget(theme, Icons.star_border_outlined, 'I tuoi punteggi')
          ),
          const SizedBox(height: 10),
          Divider(
            color: theme.secondaryHeaderColor.withOpacity(0.2),
            indent: 0,
            endIndent: 30,
            thickness: 1,
          ),
        ],
      ),
    );
  }

  Widget build_row_widget(theme, icon, label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.white,),
        const SizedBox(width: 20,),
        Text(label, style: theme.textTheme.displayMedium!.copyWith(color: Colors.white, fontSize: 16.0))
      ],
    );
  }

  
}