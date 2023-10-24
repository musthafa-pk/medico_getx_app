import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:medico_getx_app/Utils/Routes/routes_name.dart';
import 'package:medico_getx_app/Utils/util.dart';
import 'package:medico_getx_app/res/app_urls.dart';
import 'package:http/http.dart' as http;
import 'package:medico_getx_app/res/components/bottomNavigationBar1.dart';
import 'package:medico_getx_app/views/Auth/login.dart';
class AuthController extends GetxController{

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final regUserName = TextEditingController();
  final regBussinessName = TextEditingController();
  final regPhoneNumber = TextEditingController();
  final regEmail = TextEditingController();
  final regPassword = TextEditingController();

  final userNameNode = FocusNode();
  final passwordNode = FocusNode();
  final loginBtnNode = FocusNode();

  final regUserNameNode = FocusNode();
  final regBussinessNameNode = FocusNode();
  final regPhoneNumberNode = FocusNode();
  final regEmailNode = FocusNode();
  final regPasswordNode = FocusNode();
  final regBtnNode = FocusNode();

  final RxBool isPasswordVisible = true.obs;

  void togglePasswordVisiblity(){
    isPasswordVisible.toggle();
    print('Password visiblity:${isPasswordVisible.value}');
  }


  Future<void> login(context) async{
    print('function called');
    var apiUrl = Uri.parse(AppUrls.login);
    var requestbody = {
      'userid':usernameController.text,
      'password':passwordController.text
    };
    try{
      var response = await http.post(apiUrl,
          headers: {'Content-Type': 'application/json'},
          body:jsonEncode(requestbody));
      print(response.statusCode);
      if(response.statusCode == 200){
        var responsedata = jsonDecode(response.body);
        Util.userLoggedName = responsedata['data']['name'].toString();
        Util.userLoggedId = responsedata['data']['id'];
        Get.to(BottomNavigationBar1());
        Util.flushBarErrorMessage('Hey ${Util.userLoggedName} Welcome Back ,', context);
      }else{
        var responsedata = jsonDecode(response.body);
        Util.flushBarErrorMessage(responsedata['message'], context);
        // Util.toastMessage(responsedata['data']['message']);
      }
    }catch(e){
      Util.flushBarErrorMessage(e.toString(), context);
    }
    // If authentication is successful, you can navigate to the next screen using Get.to(NextScreen());
  }

  Future<void> register(context) async{
    print('function called');
    var apiUrl = Uri.parse(AppUrls.register);
    var requestBody = {
      'name': regUserName.text,
      'business_name':regBussinessName.text,
      'phone':regPhoneNumber.text,
      'email':regEmail.text,
      'password': regPassword.text
    };
    try{
      var response = await http.post(apiUrl,
          headers: {'Content-Type': 'application/json'},
          body:jsonEncode(requestBody));
      print(response.statusCode);
      if(response.statusCode == 200){
        var responsedata = jsonDecode(response.body);
        Get.offNamed(RoutesName.login);
        Util.flushBarErrorMessage('User Registered successfully ! ,', context);
      }else{
        var responsedata = jsonDecode(response.body);
        Util.flushBarErrorMessage(responsedata['message'], context);
        // Util.toastMessage(responsedata['data']['message']);
      }
    }catch(e){
      Util.flushBarErrorMessage(e.toString(), context);
    }
    // If authentication is successful, you can navigate to the next screen using Get.to(NextScreen());
  }



}