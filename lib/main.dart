import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ms_store/app/app_refs.dart';

import 'app/app.dart';
import 'app/di.dart';
import 'services/firebase_options.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // if (defaultTargetPlatform == TargetPlatform.android) {
  //   AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  // }
  initAppModel();
  await AppPrefs().initBox();

  runApp(const MyApp());
}
