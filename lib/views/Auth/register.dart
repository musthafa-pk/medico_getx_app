import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:medico_getx_app/views/Auth/AuthController.dart';

import '../../Utils/Routes/routes_name.dart';
import '../../Utils/util.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final authController = Get.put(AuthController());

  final formKeyReg = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKeyReg,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 250,
                        child: Lottie.asset('assets/lottie/homeasset.json')),
                    SizedBox(height: 10.0,),
                    TextFormField(
                      controller: authController.regUserName,
                      focusNode: authController.regUserNameNode,
                      onFieldSubmitted: (value) {
                        Util.fieldFocusChange(context, authController.regUserNameNode, authController.regBussinessNameNode);
                      },
                      decoration: InputDecoration(
                          labelText: 'User Name',
                          hintText: 'User Name',
                          border: OutlineInputBorder(),
                          focusColor: Colors.teal,
                          focusedBorder: OutlineInputBorder(),
                          labelStyle: TextStyle(color: Colors.teal)),
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return Util.flushBarErrorMessage('Enter your name !', context);
                        }else{
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 10.0,),
                    TextFormField(
                      controller: authController.regBussinessName,
                      focusNode: authController.regBussinessNameNode,
                      onFieldSubmitted: (value) {
                        Util.fieldFocusChange(context, authController.regBussinessNameNode, authController.regPhoneNumberNode);
                      },
                      decoration: InputDecoration(
                          labelText: 'Bussiness Name',
                          hintText: 'your bussiness name',
                          border: OutlineInputBorder(),
                          focusColor: Colors.teal,
                          focusedBorder: OutlineInputBorder(),
                          labelStyle: TextStyle(color: Colors.teal)),
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return Util.flushBarErrorMessage('Enter your Bussiness name !', context);
                        }else{
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 10.0,),
                    TextFormField(
                      controller: authController.regPhoneNumber,
                      focusNode: authController.regPhoneNumberNode,
                      onFieldSubmitted: (value) {
                        Util.fieldFocusChange(context, authController.regPhoneNumberNode, authController.regEmailNode);
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Phone Number',
                          hintText: 'your phone number',
                          border: OutlineInputBorder(),
                          focusColor: Colors.teal,
                          focusedBorder: OutlineInputBorder(),
                          labelStyle: TextStyle(color: Colors.teal)),
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return Util.flushBarErrorMessage('Enter your Phone Number !', context);
                        }else if(value.length < 10 || value.length > 10){
                          return Util.flushBarErrorMessage('Enter 10 digit phone number !', context);
                        }
                        else{
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 10.0,),
                    TextFormField(
                      controller: authController.regEmail,
                      focusNode: authController.regEmailNode,
                      onFieldSubmitted: (value) {
                        Util.fieldFocusChange(context, authController.regEmailNode, authController.regPasswordNode);
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'Email ID',
                          hintText: 'Enter your email id',
                          border: OutlineInputBorder(),
                          focusColor: Colors.teal,
                          focusedBorder: OutlineInputBorder(),
                          labelStyle: TextStyle(color: Colors.teal)),
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return Util.flushBarErrorMessage('Enter your Email Id !', context);
                        }else{
                          return null;
                        }
                      },

                    ),
                    SizedBox(height: 10.0,),
                    TextFormField(
                      controller: authController.regPassword,
                      focusNode: authController.regPasswordNode,
                      onFieldSubmitted: (value) {
                        Util.fieldFocusChange(context, authController.regPasswordNode, authController.regBtnNode);
                      },
                      decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Password',
                          border: OutlineInputBorder(),
                          focusColor: Colors.teal,
                          focusedBorder: OutlineInputBorder(),
                          labelStyle: TextStyle(color: Colors.teal)),
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return Util.flushBarErrorMessage('Enter your password !', context);
                        }else{
                          return null;
                        }
                      },

                    ),
                    SizedBox(height: 10.0,),
                    SizedBox(
                      width: MediaQuery.of(context).size.width/3,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal
                        ),
                        onPressed: (){
                          if(formKeyReg.currentState!.validate()){
                            authController.register(context);
                          }else{
                            return Util.flushBarErrorMessage('Please fill all fields !', context);
                          }
                        },
                          child: Text('Sign Up',style: TextStyle(fontWeight: FontWeight.bold),)),
                    ),
                    SizedBox(height: 20.0,),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RoutesName.login);
                      },
                      child: Text(
                        "Already have an account? Login",
                        style: TextStyle(
                          color: Colors.teal,
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
