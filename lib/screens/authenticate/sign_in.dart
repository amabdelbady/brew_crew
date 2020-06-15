import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/consts.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({Key key, this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final _key = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  String email="";
  String password="";
  String error = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading? Loading() : Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text("Sign In to Brew Crew"),

      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 50.0),
          child: Form(
            key: _key,
            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: (val)=> val.isEmpty? ' Enter your email': null,
                  keyboardType: TextInputType.emailAddress,
                  decoration: textInputDecoration.copyWith(hintText: 'Enter Your Email...'),
                  onChanged: (val){
                    setState(() =>  email = val);
                  },
                ),
                Container(height:32),
                TextFormField(
                  obscureText: true,
                  validator: (val)=> val.length < 8 ? ' Enter password longer than 8 chars': null,
                  decoration: textInputDecoration.copyWith(hintText: 'Enter Your Password...'),
                  onChanged: (val){
                    setState(() => password = val);
                  },
                ),
                Container(height:32),
                RaisedButton(
                  color: Colors.pink,
                  child: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_key.currentState.validate()){
                      setState(()=> loading = true);
                      dynamic result = await _auth.signInEmailAndPassword(email, password);
                      if (result == null){
                        setState(() {
                          error = 'Enter a Valid Credintial';
                          loading=false;
                        } );
                      }
                    }
                  },
                ),
                Container(height:16),
                GestureDetector(
                  onTap: () {
                    widget.toggleView();
                  },
                  child: Text("Don't have account? Register"),
                ),
                Container(height:16),
                Text(error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
              ],
            ),

          ),
        ),
      ),

    );
  }
}
