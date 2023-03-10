import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';
import 'package:go_router/go_router.dart';
import 'package:petsguide/bloc/details/bloc/details_bloc.dart';
import 'package:petsguide/bloc/drawer_bloc/bloc/drawer_bloc.dart';
import 'package:petsguide/bloc/home_bloc/home_bloc.dart';
import 'package:petsguide/bloc/login_bloc/login_bloc.dart';
import 'package:petsguide/bloc/preferiti_bloc/preferiti_bloc.dart';
import 'package:petsguide/bloc/punteggi/punteggi_bloc.dart';
import 'package:petsguide/constants/theme.dart';
import 'package:petsguide/repository/repository.dart';
import 'package:petsguide/screen/dashboard/dashboard_screen.dart';
import 'package:petsguide/screen/home/home_screen.dart';
import 'package:petsguide/screen/init_screen/init_screen.dart';
import 'package:petsguide/screen/login/login_screen.dart';
import 'package:petsguide/screen/sign-up/register_test.dart';
import 'package:petsguide/screen/splash_screen/splash_screen.dart';
import 'package:petsguide/service/details_service.dart';
import 'package:petsguide/service/drawer_service.dart';
import 'package:petsguide/service/firebase_query_service.dart';
import 'package:petsguide/service/google_service.dart';
import 'package:petsguide/service/login_service.dart';
import 'package:petsguide/service/preferiti_service.dart';
import 'package:petsguide/service/punteggi_service.dart';
import 'package:petsguide/service/secure_service.dart';
import 'package:petsguide/service/utils_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  ModuleContainer().initialise(Injector());
  runApp(const MyApp());

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeBloc(),),
        BlocProvider(create: (context) => DetailsBloc(),),
        BlocProvider(create: (context) => DrawerBloc(),),
        BlocProvider(create: (context) => LoginBloc(),),
        BlocProvider(create: (context) => PunteggiBloc(),),
        BlocProvider(create: (context) => PreferitiBloc(),)
      ],
      child: MaterialApp.router(
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
        theme: MyTheme.themeLight,
        darkTheme: MyTheme.themeDark,
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return SplashScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'init',
          builder: (BuildContext context, GoRouterState state) {
            return const InitScreen();
          },
        ),
        GoRoute(
          path: 'dashboard',
          builder: (BuildContext context, GoRouterState state) {
            return DashBoardScreen();
          },
        ),
        GoRoute(
          path: 'login',
          builder: (BuildContext context, GoRouterState state) {
            return LoginScreen();
          },
        ),
        GoRoute(
          path: 'register',
          builder: (BuildContext context, GoRouterState state) {
            return RegisterTEST();
          },
        ),
      ],
    ),
  ],
);

class ModuleContainer {
  Injector initialise(Injector injector) {
    injector.map<GoogleService>((i) => GoogleService(),isSingleton: false);
    injector.map<SecureService>((i) => SecureService(), isSingleton: false);
    injector.map<UtilsService>((i) => UtilsService(), isSingleton: false);
    injector.map<FirebaseQueryService>((i) => FirebaseQueryService(),isSingleton: false);
    injector.map<Repository>((i) => Repository(), isSingleton: false);
    injector.map<DetailsService>((i) => DetailsService(), isSingleton: false);
    injector.map<DrawerService>((i) => DrawerService(), isSingleton: false);
    injector.map<LoginService>((i) => LoginService(), isSingleton: false);    
    injector.map<PunteggiService>((i) => PunteggiService(), isSingleton: false);    
    injector.map<PreferitiService>((i) => PreferitiService(), isSingleton: false);    

    return injector;
  }
}
