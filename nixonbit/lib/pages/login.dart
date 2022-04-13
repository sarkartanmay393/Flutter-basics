import 'package:flutter/material.dart';
import 'package:nixonbit/pages/registration.dart';
import '../theme.dart';
import '../widgets/loginForm.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: kDefaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 220,
            ),
            Text("Welcome to NixonBit", style: titleText),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("New to the app?", style: subTitle),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegistrationPage()));
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
              ],
            ),
            loginForm(),
          ],
        ),
      ),
    );
  }
}
