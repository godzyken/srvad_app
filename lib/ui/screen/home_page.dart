import 'package:flutter/material.dart';
import 'package:srvad_app/core/viewmodels/views/home_model.dart';
import 'package:srvad_app/ui/screen/base_page.dart';
import 'package:srvad_app/ui/shared/app_colors.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return BasePage<HomeModel>(
      builder: (context, model, child) => Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: Text('home page'),
        ),
        backgroundColor: backgroundColor,
        body: Container(),
      ),
    );
  }
}
