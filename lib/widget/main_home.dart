import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ungshoppee/utility/my_constant.dart';

class MainHome extends StatefulWidget {
  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  // Field
  List<Widget> listBanner = List();

  // Method

  @override
  void initState() {
    super.initState();
    readBanner();
  }

  Widget group1() {
    return Card(
      child: Column(
        children: <Widget>[
          Icon(Icons.android),
          Text('Group 1'),
        ],
      ),
    );
  }

  Widget row1Group() {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        group1(),
        group1(),
        group1(),
      ],
    );
  }

  Widget groupProduct() {
    return Column(
      children: <Widget>[
        row1Group(),
        row1Group(),
      ],
    );
  }

  Future<void> readBanner() async {
    Response response = await Dio().get(MyConstant().urlBanner);

    var result = json.decode(response.data);

    for (var map in result) {
      Widget myWidget = Container(
        child: Image.network(map['Url']),
      );
      setState(() {
        listBanner.add(myWidget);
      });
    }
  }

  Widget banner() {
    return Container(
      // color: Colors.grey,
      height: 200.0,
      child: listBanner.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : CarouselSlider(
              items: listBanner,
              aspectRatio: 16 / 9,
              enlargeCenterPage: true,
              pauseAutoPlayOnTouch: Duration(seconds: 3),
              autoPlay: true,
              autoPlayAnimationDuration: Duration(seconds: 3),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        banner(),
        groupProduct(),
      ],
    );
  }
}
