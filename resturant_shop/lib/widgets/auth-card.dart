import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth-provider.dart';
import '../models/HttpException.dart';

enum AuthMode {
  Login,
  Signup,
}

class AuthCard extends StatefulWidget {
  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  AuthMode _currentMode = AuthMode.Login;
  final _passwordController = TextEditingController();

  AnimationController _animateController;

  // Animation<Size> _heightAnimate;
  Animation<double> _fadeAnimation;
  Animation<Offset> _slideAnimation;

  // Form input holders.
  Map<String, String> _authInfo = {
    'email': "",
    'password': "",
  };

  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    _animateController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    // _heightAnimate = Tween<Size>(
    //         begin: Size(double.infinity, 260), end: Size(double.infinity, 320))
    //     .animate(
    //         CurvedAnimation(parent: _animateController, curve: Curves.linear));
    _fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _animateController, curve: Curves.easeOut));
    _slideAnimation =
        Tween<Offset>(begin: Offset(0.0, -0.4), end: Offset(0.0, 0.0)).animate(
            CurvedAnimation(parent: _animateController, curve: Curves.easeOut));
    // _heightAnimate.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _animateController.dispose();
  }

  void _errorDialog({String message, String title}) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text("Okay"),
                ),
              ],
            ));
  }

  void _modeSwitcher() {
    if (_currentMode == AuthMode.Login) {
      setState(() {
        _currentMode = AuthMode.Signup;
      });
      _animateController.forward();
    } else {
      setState(() {
        _currentMode = AuthMode.Login;
      });
      _animateController.reverse();
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    setState(() {
      _isLoading = true;
    });

    try {
      if (_currentMode == AuthMode.Login) {
        await Provider.of<Auth>(context, listen: false)
            .login(_authInfo['email'], _authInfo['password']);
        // Navigator.of(context).pushNamed(TabScreen.routeName); found a better approach.
      } else {
        await Provider.of<Auth>(context, listen: false)
            .signup(_authInfo['email'], _authInfo['password']);
        _errorDialog(message: "Signup Successful.", title: "Go ahead");
        setState(() {
          _currentMode = AuthMode.Login;
        });
      }
    } on HttpException catch (error) {
      var errorMessage = "Authentication Failed";
      if (error.message.contains('EMAIL_EXISTS')) {
        errorMessage = "This email address is already in use.";
      } else if (error.message.contains("INVALID_EMAIL")) {
        errorMessage = "This is not a valid email address.";
      } else if (error.message.contains("WEAK_PASSWORD")) {
        errorMessage = "The password is too weak.";
      } else if (error.message.contains("EMAIL_NOT_FAILED")) {
        errorMessage = "Couldn't find a user with this email.";
      } else if (error.message.contains("INVALID_PASSWORD")) {
        errorMessage = "Invalid Password.";
      }
      _errorDialog(message: errorMessage, title: "An error occurred.");
    } catch (error) {
      const errorMessage = "Could not authenticate, Please try again later.";
      _errorDialog(message: errorMessage, title: "An error occurred.");
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 5,
      margin: EdgeInsets.only(left: 15, right: 15),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.linear,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        height: _currentMode == AuthMode.Login ? 260 : 320,
        // _heightAnimate.value.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: "Email"),
                      keyboardType: TextInputType.emailAddress,
                      validator: (inputText) {
                        if (inputText.isEmpty) {
                          return "Enter email address";
                        }
                        if (!inputText.contains('@')) {
                          return "Enter a valid address.";
                        }
                        return null;
                      },
                      onSaved: (inputText) {
                        _authInfo['email'] = inputText;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Password"),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      controller: _passwordController,
                      validator: (inputText) {
                        if (inputText.isEmpty) {
                          return "Enter password.";
                        }
                        if (inputText.length < 6) {
                          return "Minimum length is 6";
                        }
                        return null;
                      },
                      onSaved: (inputText) {
                        _authInfo['password'] = inputText;
                      },
                    ),
                    AnimatedContainer(
                      constraints: BoxConstraints(
                          minHeight: _currentMode == AuthMode.Signup ? 60 : 0,
                          maxHeight: _currentMode == AuthMode.Signup ? 120 : 0),
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: TextFormField(
                            decoration:
                                InputDecoration(labelText: "Confirm Password"),
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            validator: (inputText) {
                              if (_currentMode == AuthMode.Signup) {
                                if (inputText != _passwordController.text) {
                                  return 'Passwords do not match!';
                                }
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _submit,
                      child: Text("${_currentMode.name}"),
                    ),
              SizedBox(height: 5),
              TextButton(
                onPressed: _modeSwitcher,
                child: Text(
                  (_currentMode == AuthMode.Login)
                      ? "SIGNUP INSTEAD"
                      : "LOGIN INSTEAD",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
