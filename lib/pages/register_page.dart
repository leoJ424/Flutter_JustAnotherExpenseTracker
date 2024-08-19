import 'package:flutter/material.dart';

import '../components/button_component.dart';
import '../components/text_field_component.dart';

class RegisterPage extends StatelessWidget {
  

  //text controllers
  
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  //tap to go to the login page
  final void Function()? onTap;

  RegisterPage({
    super.key,
    required this.onTap
  });
  //register method
  void register() {

  }

  @override
  Widget build(BuildContext context) {
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

            const SizedBox(height: 50),

            Text(
              "Create an Account",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16
              ),
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

            //email text field
            const SizedBox(height: 25),

            TextFieldComponent(
              hintText: "Email", 
              controller: emailController
            ),

            //First name and last name
            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextFieldComponent(
                    hintText: "First Name", 
                    controller: firstNameController
                  ),
                ),

                Expanded(
                  child: TextFieldComponent(
                    hintText: "Last Name", 
                    controller: firstNameController
                  ),
                ),
              ],
            ),

            //loginbutton
            const SizedBox(height: 25),

            ButtonComponent(
              buttonText: "Register",
              onTap: register,
            ),

            //register
            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already Registered? ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary
                  ),
                ),
                
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "Login here", 
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary
                    ),
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