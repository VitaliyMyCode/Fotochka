import 'package:flutter/material.dart';
import 'package:photo_editor_photochka/providers/app_images_provider.dart';
import 'package:photo_editor_photochka/screens/crop_screen.dart';
import 'package:photo_editor_photochka/screens/home_screen.dart';
import 'package:photo_editor_photochka/screens/start_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppImageProvider())
      ],
      child: const MyApp())
  );


}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Editor',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xff1e1e1e),
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          color: Colors.black,
          centerTitle: true,
          elevation: 0
        )
      ),
      routes: <String, WidgetBuilder>{
        '/': (_) => const StartScreen(),
        '/home': (_) => const HomeScreen(),
        '/crop': (_) => const CropScreen()
      },
      initialRoute: '/',
    );
  }
}


