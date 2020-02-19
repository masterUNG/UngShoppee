import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ungshoppee/models/user_model.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {

  // Field
  String user, password;
  bool statusCheck = false;

  // Method

  Widget authenForm() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          userForm(),
          passwordForm(),
          rememberMe(),
          loginButton(),
         
        ],
      ),
    );
  }

  Widget rememberMe() {
    return Container(
      width: 250.0,
      child: CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        title: Text('Remember Me'),
        onChanged: (bool value) {
          setState(() {
            statusCheck = value;
            print('statusCheck = $statusCheck');
          });
        },
        value: statusCheck == null ? false : statusCheck,
      ),
    );
  }

  

  Future<void> checkAuthen() async {
    String url =
        'https://www.androidthai.in.th/ong/getUserWhereUser.php?isAdd=true&User=$user';
    Response response = await Dio().get(url);

    if (response.toString() == 'null') {
      print('User False');
    } else {
      var result = json.decode(response.data);
      for (var map in result) {
        UserModel userModel = UserModel.fromJson(map);
      }
    }
  }

  Widget loginButton() {
    return Container(
      width: 250.0,
      child: RaisedButton(
        child: Text('Login'),
        onPressed: () {
          if (user.isEmpty || password.isEmpty) {
            print('Have Space');
          } else {
            checkAuthen();
          }
        },
      ),
    );
  }


  Widget passwordForm() {
    return Container(
      child: TextField(
        onChanged: (String string) {
          password = string.trim();
        },
        decoration: InputDecoration(
          hintText: 'Password:',
          prefixIcon: Icon(Icons.lock),
        ),
      ),
      width: 250.0,
    );
  }


  Widget userForm() {
    return Container(
      child: TextField(
        onChanged: (String string) {
          user = string.trim();
        },
        decoration: InputDecoration(
          hintText: 'User:',
          prefixIcon: Icon(Icons.account_box),
        ),
      ),
      width: 250.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return authenForm();
  }
}