import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petsguide/bloc/drawer_bloc/bloc/drawer_bloc.dart';


class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key, this.function});
  final function;
  @override
  Widget build(BuildContext context) {
    

    // final LoginController loginController = Get.put(LoginController());
    var theme = Theme.of(context);
    var isThemeLight = MediaQuery.platformBrightnessOf(context) == Brightness.light ? true : false;
    return BlocProvider(
      create: (context) => DrawerBloc()..add(const LoadUserEvent()),
      child: SliverAppBar(
        elevation: 0,
        automaticallyImplyLeading:false,
        actions: <Widget>[Container()],
        backgroundColor: theme.backgroundColor,
        pinned: false,
        floating: true,
        snap: true,
        title: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 70,
          child: Stack(
            children: [
              Positioned(
                top: 15,
                left: -10,
                child: SizedBox(
                  width: 45,
                  height: 45,
                  child: Image.asset('contents/images/logo.png'),
                ),
              ),
              Positioned(
                top: 10,
                left: 40,
                right: 50,
                child: GestureDetector(
                  // onTap: () {Get.to(const SearchScreen());},
                  child: Container(
                    width: 270,
                    height: 50,
                    decoration: BoxDecoration(
                      color: isThemeLight ? Colors.grey.shade100 : Color.fromARGB(255, 29, 29, 29),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: Colors.grey,),
                          const SizedBox(width: 10),
                          Text('Cerca...', style: theme.textTheme.bodyMedium)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                child: SizedBox(
                  height: 70,
                  child: InkWell(
                    onTap: function,
                    child: Container(
                      width: 40,
                      decoration: BoxDecoration(
                        color: isThemeLight ? Colors.grey.shade100 : Color.fromARGB(255, 29, 29, 29),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: BlocBuilder<DrawerBloc, DrawerState>(
                          builder: (context, state) {
                            if(state is UserState) {
                              return Text(state.user.userInitial!, style: theme.textTheme.bodyMedium,);
                            }
                            else {
                              return const Text('');
                            }
                          },
                        ),
                      ),
                    ),
                  )
                ),
              )
            ]
            ),
        )
      ),
    );
  }
}