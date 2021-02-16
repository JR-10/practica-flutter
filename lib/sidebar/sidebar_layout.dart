import 'package:flutter/material.dart';
import 'package:replica_ejercicio/pages/home.dart';
import 'package:replica_ejercicio/sidebar/sidebar.dart';

class SideBarLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[HomePage(), SideBar()],
    ));
  }
}
