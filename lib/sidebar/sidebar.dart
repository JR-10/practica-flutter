import 'dart:async';

import 'package:flutter/material.dart';
import 'package:replica_ejercicio/sidebar/menu_item.dart';
import 'package:rxdart/rxdart.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  AnimationController _animationController;
  StreamController<bool> isSidebarOpenedStreamController;
  Stream<bool> isSidebarOpenedStream;
  StreamSink<bool> isSidebarOpenedSink;

  // final bool isSidebarOpened = true;
  final _animationDuaration = const Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuaration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  // Metodo para presionar el Icono
  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpenedStream,
      builder: (context, isSideBarOpenedAsync) {
        return AnimatedPositioned(
          duration: _animationDuaration,
          top: 0,
          bottom: 0,
          left: isSideBarOpenedAsync.data ? 0 : -screenWidth,
          right: isSideBarOpenedAsync.data ? 0 : screenWidth - 45,
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      color: Color(0xFF303030), // barra lateral
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 100,
                          ),
                          ListTile(
                            title: Text('Jonathan Rivera',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w800)),
                            subtitle: Text('arbeyjr@gmail.com',
                                style: TextStyle(
                                    color: Color(0xFF1BB5FD), fontSize: 20)),
                            leading: CircleAvatar(
                              child: Icon(Icons.perm_identity,
                                  color: Colors.white),
                              radius: 40,
                            ),
                          ),
                          //================ Linea divisoeia ===============
                          Divider(
                            height: 64,
                            thickness: 0.5,
                            color: Colors.white.withOpacity(0.3),
                            indent: 32,
                            endIndent: 32,
                          ),
                          MenuItem(
                            icon: Icons.home,
                            title: "Home",
                          ),
                          MenuItem(icon: Icons.person, title: "My Account"),
                          MenuItem(
                              icon: Icons.shopping_basket, title: "My Orders"),
                          MenuItem(icon: Icons.card_giftcard, title: "List"),
                          Divider(
                            height: 64,
                            thickness: 0.5,
                            color: Colors.white.withOpacity(0.3),
                            indent: 32,
                            endIndent: 32,
                          ),
                          MenuItem(icon: Icons.settings, title: "Settings"),
                          MenuItem(icon: Icons.exit_to_app, title: "Logout"),
                        ],
                      ))),
              Align(
                alignment: Alignment(0, -0.9),
                child: GestureDetector(
                  onTap: () {
                    onIconPressed(); // metodo al presionar el icono
                  },
                  child: Container(
                      width: 35,
                      height: 110,
                      color: Color(0xFF303030), // Color del espacio del menu
                      alignment:
                          Alignment.centerLeft, // posicionamiento del menu
                      // Animacion del menu
                      child: AnimatedIcon(
                        progress: _animationController.view,
                        icon: AnimatedIcons.menu_close,
                        color: Colors.white,
                        size: 25,
                      )),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
