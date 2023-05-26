import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:seva_auth/bindings.dart';

import 'firebase_options.dart';
import 'ui/main_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  MainBindings.init();
  runApp(const MainApp());
}
