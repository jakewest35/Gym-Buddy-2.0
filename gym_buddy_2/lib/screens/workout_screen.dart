import 'package:flutter/material.dart';
import 'package:gym_buddy_2/screens/previous_workouts_screen.dart';
import 'package:gym_buddy_2/utilities/workout_utility.dart';
import 'package:provider/provider.dart';

import 'new_workout_screen.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(
            Icons.fitness_center_sharp,
            size: 100.0,
          ),
          SizedBox(
            height: 120.0,
          ),
        ]),
        const Padding(
          padding: EdgeInsets.only(bottom: 45.0),
          child: Text(
            "Workout Log",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                          create: (context) => WorkoutUtility(),
                          builder: (context, child) => const WorkoutScreen(),
                        )));
          },
          child: const Text("Today's workout"),
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PreviousWorkoutsPage(),
                  ));
            },
            child: const Text("View previous workouts")),
      ],
    );
  }
}
