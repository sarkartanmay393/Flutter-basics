import 'package:flutter/material.dart';
import '../pages/profile.dart';
import '../theme.dart';

class loginForm extends StatefulWidget {
  @override
  State<loginForm> createState() => _loginFormState();
}

class _loginFormState extends State<loginForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: "Email",
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: "Pasword",
          ),
          keyboardType: TextInputType.visiblePassword,
        ),
        SizedBox(height: 15),
        ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => profilePage()));
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(kPrimaryColor),
            ),
            child: Text(
              "Log In",
              style: textButton,
            )
        ),

      ],
    );
  }
}
