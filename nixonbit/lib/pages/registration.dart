import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/registrationForm.dart';

class RegistrationPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: kDefaultPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
            ),
            Text("Create Account", style: titleText),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Already a member?", style: subTitle),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Log In",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
              ],
            ),
            registrationForm(),


          ],
        ),
      ),
    );
  }
}
