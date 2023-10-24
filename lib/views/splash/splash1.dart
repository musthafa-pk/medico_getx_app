import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medico_getx_app/Utils/Routes/routes_name.dart';

import '../../res/app_colors.dart';

class Splash1 extends StatefulWidget {
  const Splash1({Key? key}) : super(key: key);

  @override
  State<Splash1> createState() => _Splash1State();
}

class _Splash1State extends State<Splash1> {
  double opacity = 1.0;

  changeOpacity(){
    Future.delayed(Duration(seconds: 1),(){
      setState(() {
        opacity = opacity ==0.0 ?1.0 :0.0;
        changeOpacity();
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    changeOpacity();
    Timer(Duration(seconds: 5),
        ()=>Navigator.pushNamed(context, RoutesName.login));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  myteal,
                  mydarkteal
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight
            )
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children:<Widget> [
                  AnimatedOpacity(
                    opacity: opacity,
                    duration: Duration(seconds: 2),
                    child: Center(
                      child: Text('Medico',style: TextStyle(
                          color: Colors.teal,fontFamily: 'Musthafa',fontSize: 30
                      ),),
                    ),
                  ),
                  AnimatedOpacity(
                    opacity: opacity == 1 ? 0 : 1,
                    duration: Duration(seconds: 2),
                    child: Center(
                      child: Text('Medico',style: TextStyle(
                          color: mydarkteal,fontFamily: 'Musthafa',fontSize: 30
                      ),),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
