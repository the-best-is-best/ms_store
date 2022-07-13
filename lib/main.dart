import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ms_store/app/app_refs.dart';
import 'app/app.dart';
import 'app/di.dart';
import 'services/firebase_options.dart';

void main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;

    try {
      if (kReleaseMode) {
        observer = FirebaseAnalyticsObserver(analytics: analytics);
      }
    } catch (ex) {
      debugPrint(ex.toString());
    }

    initAppModel();
    await AppPrefs().initBox();

    runApp(const MyApp());
  }, (error, stackTrace) {
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });
}

FirebaseAnalyticsObserver? observer;
