import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/constants/color.dart';
import 'package:recipe_app/provider/favorite_provider.dart';
import 'package:recipe_app/provider/my_recipes_provider.dart';
import 'package:recipe_app/screens/splash_screen.dart';
//import 'package:recipe_app/screens/bottom_navigation_bar.dart';
//import 'package:recipe_app/screens/login_page.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => FavoriteProvider()),
          ChangeNotifierProvider(create: (context) => MyRecipesProvider()),
        ],
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primaryColor: HexColor(backgroundColor),
            fontFamily: "Hellix",
          ),
          home: const SplashScreen(),
          //home: LoginPage(),
          //home: const BottomnavigationBar(),
        ),
      );
}
