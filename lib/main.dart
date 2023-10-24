import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medico_getx_app/Utils/Routes/routes.dart';
import 'package:medico_getx_app/Utils/Routes/routes_name.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'views/HomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveApp(
      builder: (context) {
        return GetMaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
          onGenerateRoute: Routes.generateRoute,
          initialRoute: RoutesName.splash,
        );
      }
    );
  }
}

