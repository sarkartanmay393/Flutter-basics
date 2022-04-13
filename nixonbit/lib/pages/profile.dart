import 'package:flutter/material.dart';
import 'package:nixonbit/theme.dart';

class profilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        //padding: EdgeInsets.only(top: 50),
        child: Card(
          margin: EdgeInsets.only(top: 200), // supposing 200 is the middle off all screen sizes.
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/pic.jpeg"),
                    ),
                  ),
                ),
                Text(
                  "Tanmay Sarkar",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 30),
                Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.email_outlined),
                        SizedBox(
                          width: 10,
                        ),
                        Text("emailaddress@nixobnit.in")
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Icon(Icons.verified_user),
                        SizedBox(
                          width: 10,
                        ),
                        Text("username"),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.edit),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Icon(Icons.call),
                        SizedBox(
                          width: 10,
                        ),
                        Text("xxx87987889")
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
