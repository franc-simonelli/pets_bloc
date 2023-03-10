import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsguide/bloc/drawer_bloc/bloc/drawer_bloc.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key, this.openAndCloseDrawer});

  final openAndCloseDrawer;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 80),
      child: BlocProvider(
        create: (context) => DrawerBloc()..add(const LoadUserEvent()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            build_avatar_widget(context, theme),
            const SizedBox(height: 10),
            BlocBuilder<DrawerBloc, DrawerState>(
              builder: (context, state) {
                if (state is UserState) {
                  return Text(state.user.email!, style: theme.textTheme.bodySmall!.copyWith(color: Colors.white));
                } else {
                  return const Text('');
                }
              },
            ),
            const SizedBox(height: 20),
            Divider(
              color: theme.secondaryHeaderColor.withOpacity(0.5),
              indent: 0,
              endIndent: 0,
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget build_avatar_widget(BuildContext context, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white
            // color: MediaQuery.platformBrightnessOf(context) == Brightness.light
            //     ? Colors.grey.shade800
            //     : Colors.grey.shade100,
          ),
          child: BlocBuilder<DrawerBloc, DrawerState>(
            builder: (context, state) {
              if(state is UserState) {
                return Center(
                  child: Text(state.user.userInitial!, style: theme.textTheme.titleSmall!.copyWith(color: theme.primaryColor),),
                );
              }
              else {
                return const Text('');
              }
              
            },
          ),
        ),
        // GestureDetector(
        //   onTap: openAndCloseDrawer,
        //   child: Container(
        //     height: 40,
        //     width: 40,
        //     decoration: BoxDecoration(
        //       shape: BoxShape.circle,
        //       color: Colors.grey.shade500
        //     ),
        //     child: Center(
        //       child: Icon(Icons.close, color: theme.primaryColor,),
        //     ),
        //   ),
        // )
      ],
    );
  }
}
