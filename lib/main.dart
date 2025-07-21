import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_library/firebase_options.dart';
import 'package:the_library/screens/splash_screen/splash_screen.dart';
import 'package:the_library/utils/application_controller.dart';
import 'package:the_library/utils/auth/authentication_repository.dart';
import 'package:the_library/utils/auth/database_repository.dart';
import 'package:the_library/utils/constants/colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) async {
    await Get.put(ApplicationController(), permanent: true);
    await Get.put(DatabaseRepository(), permanent: true);
    await ApplicationController.instance.updateBooks();
    await ApplicationController.instance.updateTransactions();
    await ApplicationController.instance.updateCategories();
    await Get.put(AuthenticationRepository(), permanent: true);
  });
  runApp(const TheLibrary());
}

class TheLibrary extends StatelessWidget {
  const TheLibrary({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'The Library',
      home: SplashScreen(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryGreen),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
