import 'package:flutter/material.dart';
import 'package:led_controller/views/Sensor.dart';
import 'package:led_controller/views/TurnOff.dart';
import 'package:top_notch_bottom_bar/top_notch_bottom_bar.dart';
class navigationBar extends StatefulWidget {
  const navigationBar({Key? key}) : super(key: key);

  @override
  State<navigationBar> createState() => _navigationBarState();
}

class _navigationBarState extends State<navigationBar> {

  static const TextStyle txtstyle = TextStyle(fontSize: 30);

  List<Widget> screens = [
    const TurnOff(),
    // const Chart(),
    const Sensor(),
    // const Center(child: Text('Messages', style: txtstyle)),

  ];

  int index = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: TopNotchBottomBar(
        backgroundColor: const Color(0xFF2E3243),
          activeColor: const Color(0xFFD8E0ED),
          height: 56, // changes the bottom bar height -> default = 50
          onTap: ((value) => setState(() {
            index = value;
          })),
          items: [
            TopNotchItem(icon: const Icon(Icons.lightbulb), name: 'Led'),
            // TopNotchItem(icon: const Icon(Icons.device_thermostat_outlined), name: 'Temp'),
            TopNotchItem(icon: const Icon(Icons.message), name: 'Sensor'),
            // TopNotchItem(icon: const Icon(Icons.settings), name: 'Settings'),
          ]),
    );
  }
}
