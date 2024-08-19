import 'package:flutter/material.dart';
import 'package:project_2/pages/login_page.dart';
import 'package:project_2/pages/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  
  //show the login page by default
  bool showLoginPage = true;

  //toggle between the login and register page
  void togglePages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return LoginPage();
    }
    
    else{
      return RegisterPage();
    }
  }
} 