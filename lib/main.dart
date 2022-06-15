import 'package:flutter/material.dart';
import 'package:motion_sensors/motion_sensors.dart';

void main() {
  runApp(const App());
}

double rad2deg(double rad) {
  return rad * 180 / 3.14159;
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Shimmer Demo',
        home: Scaffold(
          body: Shimmer(),
          backgroundColor: Colors.black,
        ));
  }
}

class Shimmer extends StatefulWidget {
  const Shimmer({Key? key}) : super(key: key);

  @override
  State<Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> {
  @override
  void initState() {
    super.initState();

    motionSensors.absoluteOrientationUpdateInterval =
        Duration.microsecondsPerSecond ~/ 60;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AbsoluteOrientationEvent>(
        stream: motionSensors.absoluteOrientation,
        builder: (context, snapshot) {
          final orientation = snapshot.data;
          final deg = orientation == null
              ? 0
              : rad2deg(orientation.pitch + orientation.roll + orientation.yaw);
          final hsl = HSLColor.fromAHSL(1.0, deg % 360, 1.0, 0.5);
          return Center(
              child: Text(
            'Shimmer',
            style: TextStyle(
                fontSize: 96,
                fontWeight: FontWeight.bold,
                color: hsl.toColor()),
          ));
        });
  }
}
