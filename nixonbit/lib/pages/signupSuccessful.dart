import 'package:flutter/material.dart';
import 'package:nixonbit/pages/profile.dart';

class signupSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        margin: EdgeInsets.symmetric(vertical: 320, horizontal: 110),
        child: Column(
          children: [
            Text(
              "Registration Successful!",
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                      profilePage()));
                },
                child: Text("Go to Profile")),
          ],
        ),
      ),
    );
  }
}
