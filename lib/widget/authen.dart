import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungshoppee/models/user_model.dart';
import 'package:ungshoppee/utility/normal_dialog.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  // Field
  String user, password;
  bool statusCheck = false;
  UserModel loginUserModel;

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
    // print('response = $response');

    if (response.toString() == 'null') {
      normalDialog(context, 'User False', 'No $user in my Database');
    } else {
      var result = json.decode(response.data);
      // print('result = $result');
      for (var map in result) {
        UserModel userModel = UserModel.fromJson(map);

        if (password == userModel.password) {
          // Password True
          // print('statusCheck = $statusCheck');
          if (statusCheck) {
            saveSharePreferance(userModel);
          } else {
            findLogin(userModel.id);
          }
        } else {
          normalDialog(
              context, 'Password False', 'Please Try Agains Password False');
        }
      }
    }
  }

  Future findLogin(String id) async {
    String url =
        'https://www.androidthai.in.th/ong/getUserWhereIdUng.php?isAdd=true&id=$id';

    Response response = await Dio().get(url);
    if (response.toString() == 'null') {
      normalDialog(context, 'Find Login False', 'Please Try Again');
    } else {
      var result = json.decode(response.data);
      for (var map in result) {

        setState(() {
          loginUserModel = UserModel.fromJson(map);
        });

      }
    }
  }

  Future<void> saveSharePreferance(UserModel userModel) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setBool('Remember', true);
      sharedPreferences.setString('id', userModel.id);
      sharedPreferences.setString('Name', userModel.name);
      

      findLogin(userModel.id);
    } catch (e) {}
  }

  Widget loginButton() {
    return Container(
      width: 250.0,
      child: RaisedButton(
        child: Text('Login'),
        onPressed: () {
          if (user == null ||
              user.isEmpty ||
              password == null ||
              password.isEmpty) {
            normalDialog(context, 'Have Space', 'Please Fill Every Blank');
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
        obscureText: true,
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

  Widget showInfo(){
    return Text('Welcome ${loginUserModel.name}');
  }

  @override
  Widget build(BuildContext context) {
    return loginUserModel == null ? authenForm() : showInfo();
  }
}
