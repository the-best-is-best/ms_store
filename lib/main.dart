import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ms_store/app/app_refs.dart';

import 'app/app.dart';
import 'app/di.dart';
import 'services/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initAppModel();
  await AppPrefs().initBox();
  runApp(const MyApp());
}
