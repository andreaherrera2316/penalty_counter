import 'package:flutter/material.dart';
import 'package:penalty_counter/view/rounded_elevated_button.dart';

class ScoresDialog extends StatelessWidget {
  const ScoresDialog(
      {required this.results,
      required this.scores,
      required this.onReplayPressed,
      super.key});
  final String results;
  final String scores;
  final Function onReplayPressed;

  @override
  Widget build(BuildContext context) {
    var s = MediaQuery.of(context).size;
    var p4 = SizedBox(height: s.height * 0.04);
    var p5 = SizedBox(height: s.height * 0.05);

    var result = Text(results,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.blueGrey[600],
            fontSize: 40,
            fontWeight: FontWeight.w700));

    var score = Text(
      scores,
      style: TextStyle(
          color: Colors.blueGrey[800],
          fontSize: 55,
          fontWeight: FontWeight.w800),
    );

    var replay = RoundedElevatedButton(
      title: "Replay",
      icon: Icons.restart_alt_rounded,
      buttonColor: Colors.deepPurpleAccent[700],
      onPressed: () {
        Navigator.of(context).pop();
        onReplayPressed();
      },
    );

    return AlertDialog(
        content: SizedBox(
      height: s.height * 0.4,
      child: Column(
        children: [p5, result, p4, score, p5, replay],
      ),
    ));
  }
}
