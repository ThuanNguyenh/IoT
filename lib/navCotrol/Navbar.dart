import 'dart:async';

import 'package:flutter/material.dart';
import 'package:led_controller/navCotrol/navigationBar.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {

  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 4), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => navigationBar(),));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Image.asset("assets/banner.jpg"),
          ),

          SizedBox(height: 30,),

          Text("Tomorrow's technology today.",
          style: TextStyle(
            fontSize: 18,
            color: Color.fromRGBO(62, 76, 79, 1),
            fontWeight: FontWeight.w500
          ),
          ),

          SizedBox(height: 30,),

          CircularProgressIndicator(color: Color.fromRGBO(1, 185, 239, 94),
            strokeWidth: 1,
          ),
        ],
      ),
    );
  }
}
