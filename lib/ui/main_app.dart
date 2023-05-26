import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:seva_auth/domain/usecases/get_state_auth.dart';
import 'package:seva_auth/ui/pages/home/home_page.dart';
import 'package:seva_auth/ui/pages/login/login_page.dart';
import 'package:seva_auth/ui/pages/register/register_page.dart';
import 'package:seva_auth/ui/theme/main_theme.dart';
import 'package:seva_auth/utils/routes.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = GetIt.I<GetStateAuth>();
    return MaterialApp(
      title: 'Seva Auth',
      theme: MainTheme.customLightTheme(),
      darkTheme: MainTheme.customDarkTheme(),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: auth(),
        builder: (context, snap) {
          if (snap.hasData) {
            return const HomePage();
          } else {
            return const LoginPage();
          }
        },
      ),
      routes: {
        Routes.register: (context) => const RegisterPage(),
        Routes.login: (context) => const LoginPage(),
        Routes.home: (context) => const HomePage(),
      },
    );
  }
}
