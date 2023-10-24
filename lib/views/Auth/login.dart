import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:medico_getx_app/Utils/Routes/routes_name.dart';
import 'package:medico_getx_app/Utils/util.dart';
import 'package:medico_getx_app/views/Auth/AuthController.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatelessWidget {
  final authController = Get.put(AuthController());

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome ,",
                style: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    fontFamily: 'Musthafa'
                ),
              ),
              Text(
                "Back",
                style: TextStyle(
                    color: Colors.teal,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    fontFamily: 'Musthafa'
                ),
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                controller: authController.usernameController,
                focusNode: authController.userNameNode,
                onFieldSubmitted: (value) {
                  Util.fieldFocusChange(context, authController.userNameNode, authController.passwordNode);
                },
                decoration: InputDecoration(
                    labelText: 'User ID',
                    hintText: 'email or phone number',
                    border: OutlineInputBorder(),
                    focusColor: Colors.teal,
                    focusedBorder: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.teal)),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return Util.flushBarErrorMessage('Enter your User Id !', context);
                  }else{
                    return null;
                  }
                },

              ),
              SizedBox(height: 16),
              Obx(() {
                return TextFormField(
                  controller: authController.passwordController,
                  obscureText: authController.isPasswordVisible.value,
                  focusNode: authController.passwordNode,
                  onFieldSubmitted: (value) {
                    Util.fieldFocusChange(context, authController.passwordNode, authController.loginBtnNode);
                  },
                  decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.teal),
                      suffixIcon: InkWell(
                          onTap: () {
                            print('eye icon clicked');
                            authController.togglePasswordVisiblity();
                          },
                          child: Icon(
                            authController.isPasswordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.teal,
                          )),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      focusColor: Colors.teal),
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return Util.flushBarErrorMessage('Enter your password!', context);
                    }
                  },
                );
              }),
              SizedBox(height: 20.0),
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: ElevatedButton(
                  focusNode: authController.loginBtnNode,
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                  onPressed: (){
                    if(formKey.currentState!.validate()){
                      authController.login(context);
                    }else{
                      return Util.flushBarErrorMessage('Please fill all fields to continue', context);
                    }
                  },
                  child: Text('Login',style: TextStyle(fontWeight: FontWeight.bold),),
                ),
              ),
              SizedBox(height: 20.0,),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, RoutesName.register);
                },
                child: Text(
                  "Don't have an account? Sign Up",
                  style: TextStyle(
                    color: Colors.teal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
