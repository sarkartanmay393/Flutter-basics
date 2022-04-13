import 'package:flutter/material.dart';
import 'package:nixonbit/pages/signupSuccessful.dart';
import '../theme.dart';

class registrationForm extends StatefulWidget {
  @override
  State<registrationForm> createState() => _registrationFormState();
}

class _registrationFormState extends State<registrationForm> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
            labelText: "First Name",
          ),
          keyboardType: TextInputType.name,
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: "Last Name",
          ),
          keyboardType: TextInputType.name,
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: "Email",
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: "Phone Number",
          ),
          keyboardType: TextInputType.phone,
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: "Password",
          ),
          keyboardType: TextInputType.visiblePassword,
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: "Confirm Password",
          ),
          keyboardType: TextInputType.visiblePassword,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
              value: isChecked,
              onChanged: (value) {
                setState(() {
                  isChecked = value;
                });
              },
            ),
            Text("Agree to terms and conditions."),
          ],
        ),
        SizedBox(height: 15),
        ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => signupSuccess()));
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(kPrimaryColor),
            ),
            child: Text(
              "Sign Up",
              style: textButton,
            )),
      ],
    );
  }
}
