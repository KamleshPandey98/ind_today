import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:india_today/controllers/agents_page_controller.dart';
import 'package:india_today/controllers/home_page_controller.dart';
import 'package:india_today/views/bottom_navbar.dart';
import 'package:india_today/views/home_page.dart';
import 'package:provider/provider.dart';

import 'custom_styles.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: CustomStyles.mainParentWhiteColor,
    // for Android
    statusBarIconBrightness: Brightness.dark,
    //for iOS
    statusBarBrightness: Brightness.dark,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => HomePageController()),
          ChangeNotifierProvider(create: (_) => AgentsPageController()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const BottomNavScreen(),
        )
    );
  }
}


