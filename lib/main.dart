import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:seva_auth/ui/pages/home/home_page.dart';
import 'package:seva_auth/ui/pages/login/login_page.dart';
import 'package:seva_auth/ui/pages/register/register_page.dart';
import 'package:seva_auth/ui/theme/main_theme.dart';
import 'package:seva_auth/utils/routes.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seva Auth',
      theme: MainTheme.customLightTheme(),
      darkTheme: MainTheme.customDarkTheme(),
      initialRoute: Routes.login,
      routes: {
        Routes.register: (context) => const RegisterPage(),
        Routes.login: (context) => const LoginPage(),
        Routes.home: (context) => const HomePage(),
      },
    );
  }
}
