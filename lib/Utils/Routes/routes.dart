import 'package:flutter/material.dart';
import 'package:medico_getx_app/Utils/Routes/routes_name.dart';
import 'package:medico_getx_app/res/components/bottomNavigationBar1.dart';
import 'package:medico_getx_app/views/Auth/login.dart';
import 'package:medico_getx_app/views/Auth/register.dart';
import 'package:medico_getx_app/views/HomePage.dart';
import 'package:medico_getx_app/views/offersPage/offersPage.dart';
import 'package:medico_getx_app/views/splash/splash1.dart';

class Routes{
  static Route<dynamic> generateRoute(RouteSettings settings){

    switch (settings.name){
      case RoutesName.bottombar:
        return MaterialPageRoute(builder: (BuildContext context)=> BottomNavigationBar1());

      case RoutesName.splash:
        return MaterialPageRoute(builder: (BuildContext context)=>Splash1());

      case RoutesName.home:
        return MaterialPageRoute(builder: (BuildContext context)=>HomePage());

      case RoutesName.login:
        return MaterialPageRoute(builder: (BuildContext context)=>LoginPage());

      case RoutesName.register:
        return MaterialPageRoute(builder: (BuildContext context)=>RegisterPage());

      case RoutesName.offersPage:
        return MaterialPageRoute(builder: (BuildContext context)=>OffersPage());


      default:
        return MaterialPageRoute(builder: (_){
          return const Scaffold(
            body: Center(child: Text('No Route defined'),),
          );
        });

    }
  }
}