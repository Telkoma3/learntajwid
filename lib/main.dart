import 'package:doctor_appointment/app/modules/main/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/logic/controller/appointment controller/appointment_controller.dart';

import 'app/modules/splash/splash_screen.dart';
import 'firebase_options.dart';
import 'utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.lazyPut(() => AppointmentController()); 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Learn Tajwid App',
      theme: AppTheme.light(context),
      home: currentUser == null ? const SplashScreen() : MainScreen(),
     
    );
  }
}
