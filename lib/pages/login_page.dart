import 'package:flutter/material.dart';
import 'package:project_2/components/button_component.dart';
import 'package:project_2/components/text_field_component.dart';

class LoginPage extends StatelessWidget{
  LoginPage({super.key});

  //username and password text controllers
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //login method
  void login(){

  }
  

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(
              Icons.auto_graph,
              size: 50,
            ),

            //username textfield
            const SizedBox(height: 25),

            TextFieldComponent(
              hintText: "Username", 
              controller: userNameController
            ),

            const SizedBox(height: 25),

            //password text field

            TextFieldComponent(
              hintText: "Password", 
              obscureText: true,
              controller: passwordController,
            ),
          
            const SizedBox(height: 25),
            //loginbutton

            ButtonComponent(
              buttonText: "Login",
              onTap: login,
            ),

            //register
            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not Registered? ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary
                  ),
                ),
                
                Text(
                  "Click here", 
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}