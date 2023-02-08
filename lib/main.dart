import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tec/route_manager/binding.dart';
import 'package:tec/route_manager/named_route.dart';
import 'package:tec/route_manager/pages.dart';
import 'package:tec/view/splash_screen.dart';
import 'constant/my_colors.dart';
import 'my_http_override.dart';

 Future<void>main() async {
   HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: SolidColors.statusBarColor,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: SolidColors.systemNavigationBarColor,
      systemNavigationBarIconBrightness: Brightness.dark));
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: RegisterBinding(),
      initialRoute: NamedRouted.initialRoute,
      getPages: Pages.pages,
      title: 'Localizations Sample App',
      locale: const Locale('fa'),
      theme: lightTheme(),
      debugShowCheckedModeBanner: false,
    );
  }

  ThemeData lightTheme() {
    return ThemeData(
      elevatedButtonTheme: buttonStyle(),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            width: 10.0
          )
        )
      ),
        textTheme: TextTheme(
            headline1: TextStyle(
                //fontFamily: ''
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: SolidColors.posterTitle),
            subtitle1: TextStyle(
                //fontFamily: ''
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: SolidColors.posterSubTitle),
            bodyText1: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
            headline2: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w300,
                color: Colors.white),
            headline3: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: SolidColors.seeMore),
            headline4: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 70, 70, 70)),
             headline5: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: SolidColors.hintText,
             )
                ));
  }

  ElevatedButtonThemeData buttonStyle() {
    return ElevatedButtonThemeData(
      style: ButtonStyle(textStyle: MaterialStateProperty.resolveWith(
                (states) {
                  if (states.contains(MaterialState.pressed)) {
                    return const TextStyle(fontSize: 25);
                  }
                  return const TextStyle(fontSize: 20);
                },
              ), backgroundColor: MaterialStateProperty.resolveWith(
                (states) {
                  if (states.contains(MaterialState.pressed)) {
                    return SolidColors.seeMore;
                  }
                  return SolidColors.primeryColor;
                },
              )),);
  }
}
