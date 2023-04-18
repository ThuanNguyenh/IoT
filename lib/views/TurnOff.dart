import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TurnOff extends StatefulWidget {
  const TurnOff({Key? key}) : super(key: key);

  @override
  State<TurnOff> createState() => _TurnOffState();
}


class _TurnOffState extends State<TurnOff> {

  final primaryColorLight = const Color(0xFFD8E0ED);
  final primaryColorDark = const Color(0xFF2E3243);

  var isPressed = false;
  var isDark = false;


  late final DatabaseReference databaseReference =
  FirebaseDatabase.instance.ref("/LED/digital/boolean");
  bool value = true;

  // map den vi tri data
  late final DatabaseReference _analog = FirebaseDatabase.instance.reference().child("LED/analog");


  @override
  void initState() {
    super.initState();
    getItems();
    getCounter();
  }
  void getItems() async {
    databaseReference.onValue.listen((event) {
      var snapshot = event.snapshot;
      if (snapshot.exists) {
        setState(() {
          value = snapshot.value as bool;
        });
      }
    });
  }

  void updateItem(val) {
    databaseReference.set(val);
  }

  // counter
  int _counter = 0;
  int _minValue = 0;
  int _maxValue = 255;


  void getCounter(){
    _analog.onValue.listen((event) {
      setState(() {
        _counter = event.snapshot.value as int ?? 0;
      });
    });
  }

  // tang
  void _incre (){
    setState(() {
      if (_counter <_maxValue){
        _analog.set(_counter += 5);
      }
    });
  }

  void _decre (){
    setState(() {
      if(_counter > _minValue){
        _analog.set(_counter -= 5);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final positionShadow = value == false ? -40.0 : -210.0;

    return Scaffold(
      backgroundColor: value == false ? primaryColorDark : primaryColorLight,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  width: 210,
                  height: 210,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: value == false
                          ? [
                        const Color(0xFF30218F),
                        const Color(0xFF8D81DD),
                      ]
                          : [
                        const Color(0xFFFFCC81),
                        const Color(0xFFFF6E30),
                      ],
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 200),
                  top: positionShadow,
                  right: positionShadow,
                  child: Container(
                    width: 210,
                    height: 210,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: value == false ? primaryColorDark : primaryColorLight,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 36),
            // centerText(),
            Text(
              value == false ? 'Light\noff' : 'Light\non',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 44,
                fontWeight: FontWeight.bold,
                color: value == false ? primaryColorLight : primaryColorDark,
              ),
            ),
            const SizedBox(height: 100),

            value == true ? Container(
              width: 70,
              height: 30,
              margin: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFD8E0ED),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 5,
                    blurRadius: 20,
                    offset:const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Center(
                child: Text("$_counter",
                  style: const TextStyle(
                    color: Color(0xFF2E3243),
                    fontSize: 18,
                  ),
                ),
              ),
            ) : const SizedBox.shrink(),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                value == true ? Listener(
                  onPointerDown: (_) => setState(() {
                    isPressed = true;
                    // boolValueRef.set(false);
                  }),
                  onPointerUp: (_) => setState(() {
                    isPressed = false;
                    isDark = !isDark;
                    // boolValueRef.set(true).asStream();


                    SystemChrome.setSystemUIOverlayStyle(
                      SystemUiOverlayStyle(
                        statusBarBrightness:
                        isDark ? Brightness.dark : Brightness.light,
                      ),
                    );
                  }),
                  child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: value == true ? primaryColorLight : primaryColorDark,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(-5, 5),
                            blurRadius: 10,
                            color: value == false
                                ? const Color(0xFF121625)
                                : const Color(0xFFA5B7D6),
                          ),
                          BoxShadow(
                            offset: const Offset(5, -5),
                            blurRadius: 10,
                            color: value == false ? const Color(0x4D9DA7CF) : Colors.white70,
                          ),
                        ],
                      ),
                      child: IconButton(
                        iconSize: 20,
                        color: value == false ? primaryColorLight : primaryColorDark,
                        icon:const Icon(Icons.remove),
                        onPressed: () {
                          _decre();
                        },
                      )
                  ),
                ) : const SizedBox.shrink(),
                


                const SizedBox(width: 20,),

                // bat tat
                Listener(
                  onPointerDown: (_) => setState(() {
                    isPressed = true;
                    // boolValueRef.set(false);
                  }),
                  onPointerUp: (_) => setState(() {
                    isPressed = false;
                    isDark = !isDark;
                    // boolValueRef.set(true).asStream();


                    SystemChrome.setSystemUIOverlayStyle(
                      SystemUiOverlayStyle(
                        statusBarBrightness:
                        value == false ? Brightness.dark : Brightness.light,
                      ),
                    );
                  }),
                  child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 140,
                      height: 140,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: value == true ? primaryColorLight : primaryColorDark,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(-5, 5),
                            blurRadius: 10,
                            color: value == false
                                ? const Color(0xFF121625)
                                : const Color(0xFFA5B7D6),
                          ),
                          BoxShadow(
                            offset: const Offset(5, -5),
                            blurRadius: 10,
                            color: value == false ? const Color(0x4D9DA7CF) : Colors.white70,
                          ),
                        ],
                      ),
                      child: IconButton(
                        iconSize: 48,
                        color: value == false ? primaryColorLight : primaryColorDark,
                        icon: const Icon(Icons.power_settings_new),
                        onPressed: () {
                          setState(() {
                            updateItem(!value);
                          });
                        },
                      )
                  ),
                ),

                const SizedBox(width: 20,),

                value == true ? Listener(
                  onPointerDown: (_) => setState(() {
                    isPressed = true;
                    // boolValueRef.set(false);
                  }),
                  onPointerUp: (_) => setState(() {
                    isPressed = false;
                    isDark = !isDark;
                    // boolValueRef.set(true).asStream();


                    SystemChrome.setSystemUIOverlayStyle(
                      SystemUiOverlayStyle(
                        statusBarBrightness:
                        value == false ? Brightness.dark : Brightness.light,
                      ),
                    );
                  }),
                  child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: value == true ? primaryColorLight : primaryColorDark,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(-5, 5),
                            blurRadius: 10,
                            color: value == false
                                ? const Color(0xFF121625)
                                : const Color(0xFFA5B7D6),
                          ),
                          BoxShadow(
                            offset: const Offset(5, -5),
                            blurRadius: 10,
                            color: value == false ? const Color(0x4D9DA7CF) : Colors.white70,
                          ),
                        ],
                      ),
                      child: IconButton(
                        iconSize: 20,
                        color: value == false ? primaryColorLight : primaryColorDark,
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          _incre();
                        },
                      )
                  ),
                ) : const SizedBox.shrink(),

              ],
            ),
            // powerButton(),

          ],
        ),
      ),
    );
  }
}