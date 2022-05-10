import 'package:flutter/material.dart';
import 'package:recrutmenttest/ui/router.dart' as router_manager;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        color: Colors.black,
        theme: ThemeData(
          brightness: Brightness.light,
          backgroundColor: Colors.white60,
          bottomAppBarColor: Colors.white60,
          appBarTheme: const AppBarTheme(color: Colors.white60),
          bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.white60, modalBackgroundColor: Colors.white60),
          bottomAppBarTheme: const BottomAppBarTheme(color: Colors.white60),
          textTheme: Theme.of(context)
              .textTheme
              .apply(fontFamily: 'Roboto', displayColor: Colors.white60),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: router_manager.RoutePaths.home,
        onGenerateRoute: router_manager.Router.generateRoute,
        themeMode: ThemeMode.dark,
      );
  }
}