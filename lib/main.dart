import 'package:flutter/material.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  //create global key for led class
  GlobalKey<_LedState> key1 = new GlobalKey<_LedState>();
  GlobalKey<_LedState> key2 = new GlobalKey<_LedState>();
  GlobalKey<_LedState> key3 = new GlobalKey<_LedState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //ledPad
            LedPad(
                value: 0,
                max: 10,
                min: 0,
                padSize: 25,
                onValueChange: (v) {
                  print("got active");
                  print(v);
                  //led1.setValue(value);
                  key1.currentState!.setValue(v);
                  key2.currentState!.setValue(v);
                  key3.currentState!.setValue(v);
                }),
            //led
            Led(
              value: 0,
              key: key1,
            ),
            SizedBox(
              height: 20,
            ),
            Led(
              value: 0,
              key: key2,
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                "----- Assignment -----",
                textScaleFactor: 1.5,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Led(
              value: 0,
              key: key3,
            ),
          ],
        ),
      ),
    );
  } //ef
}

class LedPad extends StatelessWidget {
  //create information for LedPad
  double value;
  double padSize;
  double min;
  double max;
  //event trigger caller
  Function(double value) onValueChange;
  LedPad({
    required this.value,
    required this.max,
    required this.min,
    required this.padSize,
    required this.onValueChange,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.blue[100],
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      icon: Icon(
                        Icons.home_mini,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        //let the outside workd know the value has change
                        //be calling the caller
                        if (value == 0) {
                          return;
                        }
                        value = 0;
                        onValueChange(value);
                      },
                      label: Text("MIN       ",
                          style: TextStyle(
                              fontSize: padSize, color: Colors.white)),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      icon: Icon(Icons.home_max, color: Colors.white),
                      onPressed: () {
                        if (value == max) {
                          return;
                        }
                        value = max;
                        onValueChange(value);
                      },
                      label: Text("MAX   ",
                          style: TextStyle(
                              fontSize: padSize, color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      icon: Icon(Icons.arrow_upward, color: Colors.white),
                      onPressed: () {
                        if (value == max) {
                          return;
                        }
                        value += 1;
                        onValueChange(value);
                      },
                      label: Text("UP",
                          style: TextStyle(
                              fontSize: padSize, color: Colors.white)),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.yellow[900],
                      ),
                      icon: Icon(Icons.arrow_downward, color: Colors.white),
                      onPressed: () {
                        if (value == 0) {
                          return;
                        }
                        value -= 1;
                        onValueChange(value);
                      },
                      label: Text("DOWN",
                          style: TextStyle(
                              fontSize: padSize, color: Colors.white)),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  } //ef
} //ec

class Led extends StatefulWidget {
  double value;
  Key key;
  Led({required this.key, required this.value}) : super(key: key);

  @override
  _LedState createState() => _LedState();
}

class _LedState extends State<Led> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: colour(widget.value),
      child: Container(
        height: 60,
        child: Text(
          widget.value.toString(),
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
    );
  } //ef

  colour(double input1) {
    if (input1 == 0) {
      return Colors.black;
    } //end of if
    else if (input1 == 10.0) {
      return Colors.red[400];
    } //end of else if
    else if (input1 <= 9 || input1 >= 1) {
      //hash map
      //Map<double, int> map1 = Map();
      //map1[1.0] = 100;
      //map1[2.0] = 200;
      //map1[3.0] = 300;
      //map1[4.0] = 400;
      //map1[5.0] = 500;
      //map1[6.0] = 600;
      //map1[7.0] = 700;
      //map1[8.0] = 800;
      //map1[9.0] = 900;
      //map1[key]
      //this will return the value based on the given key
      return Colors.green[(input1 * 100).toInt()];
    } //end of else if
  } //end of function colour

  void setValue(v) {
    setState(() {
      widget.value = v;
    });
  }
} //ec
