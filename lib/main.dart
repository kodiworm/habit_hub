import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:habit_hub/blocs/habit_cubit.dart';
import 'package:habit_hub/config/theme_data.dart';
import 'package:habit_hub/models/habit_hive_model.dart';
import 'package:habit_hub/screens/auth/login/bloc/login_cubit.dart';
import 'package:habit_hub/screens/auth/login/login_screen.dart';
import 'package:habit_hub/screens/auth/signup/bloc/signup_cubit.dart';
import 'package:habit_hub/screens/auth/signup/signup_screen.dart';
import 'package:habit_hub/screens/habit_screen.dart';
import 'package:habit_hub/screens/home_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:theme/theme.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(HabitHiveAdapter());
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);
  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  final _router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/signup', builder: (context, state) => const SignUpScreen()),
      GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
      GoRoute(
        path: '/habits/new',
        builder: (context, state) => BlocProvider(
            create: (context) => NewHabitCubit(),
            child: const HabitScreen(id: null)),
      ),
      GoRoute(
        path: '/habits/:id',
        builder: (context, state) => BlocProvider(
          create: (context) => NewHabitCubit(),
          child: HabitScreen(
            id: state.pathParameters['id'],
          ),
        ),
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
      darkTheme: darkModeTheme,
      theme: lightModeTheme,
      themeMode: ThemeMode.system,
      title: 'Habits Hub',
      builder: (context, child) {
        Locale locale = Localizations.localeOf(context);

        final GetIt getIt = GetIt.I;

        if (!getIt.isRegistered<Locale>()) {
          getIt.registerSingleton<Locale>(locale);
        }

        if (!getIt.isRegistered<LoginCubit>()) {
          getIt.registerSingleton<LoginCubit>(LoginCubit());
        }

        if (!getIt.isRegistered<SignUpCubit>()) {
          getIt.registerSingleton<SignUpCubit>(SignUpCubit());
        }

        // return MediaQuery(
        //   data: MediaQuery.of(context)
        //       .copyWith(textScaler: const TextScaler.linear(1.0)),
        //   child: child!,
        // );

        final _themeData = ThemeDataContainer.main();
        return ThemeResolver(
          data: _themeData,
          child: Theme(data: _themeData.theme, child: child!),
        );
      },
    );
  }
}
