import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
class Sensor extends StatefulWidget {
  const Sensor({Key? key}) : super(key: key);

  @override
  State<Sensor> createState() => _SensorState();
}

class _SensorState extends State<Sensor> {

  final DatabaseReference _tempRef = FirebaseDatabase.instance.reference().child('Sensor/Temperature');
  final DatabaseReference _humRef = FirebaseDatabase.instance.reference().child('Sensor/Humidity');
  final DatabaseReference _ldrRef = FirebaseDatabase.instance.reference().child('Sensor/ldr_data');
  final DatabaseReference _volRef = FirebaseDatabase.instance.reference().child('Sensor/voltage');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Sensor'),
      ),
      drawer: AlertDialog(),

      body: CustomScrollView(
        primary: false,
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverGrid.count(
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              crossAxisCount: 2,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: const Color(0xFFD8E0ED),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.device_thermostat_outlined,
                          color: Colors.red,
                          size: 40,
                        ),
                        StreamBuilder<DatabaseEvent>(
                          stream: _tempRef.onValue,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              // Lấy dữ liệu từ snapshot và hiển thị lên màn hình
                              var data = snapshot.data!.snapshot.value;
                              return TextButton(onPressed: (){},child: Text('$data ℃',
                                style:const TextStyle(
                                    color: Colors.red,
                                    fontSize: 18
                                ),
                              ));
                            } else {
                              return const SizedBox(
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator(
                                  color: Colors.red,
                                  strokeWidth: 1,
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: const Color(0xFFD8E0ED),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.opacity_outlined,
                          color: Colors.blue,
                          size: 40,
                        ),
                        StreamBuilder(
                          stream: _humRef.onValue,
                          builder: (context, snapshot){
                            if (snapshot.hasData){
                              var data = snapshot.data!.snapshot.value;
                              return TextButton(onPressed: (){}, child: Text('$data %',
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ));
                            } else {
                              return const SizedBox(
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator(
                                  color: Colors.blue,
                                  strokeWidth: 1,
                                ),
                              );
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: const Color(0xFFD8E0ED),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.light_mode_outlined,
                          color: Colors.amber[700],
                          size: 40,),
                        StreamBuilder(
                          stream: _ldrRef.onValue,
                          builder: (context, snapshot){
                            if (snapshot.hasData){
                              var data = snapshot.data!.snapshot.value;
                              return TextButton(onPressed: (){}, child: Text('$data  Ω',
                                style: TextStyle(
                                    color: Colors.amber[700],
                                    fontSize: 18
                                ),
                              ));
                            } else {
                              return SizedBox(
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator(
                                  color: Colors.amber[700],
                                  strokeWidth: 1,
                                ),
                              );
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: const Color(0xFFD8E0ED),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.bolt_outlined,
                          size: 40,
                        ),
                        StreamBuilder(
                          stream: _volRef.onValue,
                          builder: (context, snapshot){
                            if(snapshot.hasData){
                              var data = snapshot.data!.snapshot.value;
                              return TextButton(onPressed: (){}, child: Text('$data  V',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18
                                ),
                              ));
                            } else {
                              return const SizedBox(
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                  strokeWidth: 1,
                                ),
                              );
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
