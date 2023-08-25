import 'dart:async';

import 'package:flutter/material.dart';
import 'package:penalty_counter/model/penalty_model.dart';
import 'package:penalty_counter/presenter/penalty_prensenter.dart';
import 'package:penalty_counter/view/counter.dart';
import 'package:penalty_counter/view/rounded_elevated_button.dart';
import 'package:penalty_counter/view/scores_dialog.dart';

abstract class IPenaltyView {
  void setPenalties(List<bool?> team1, List<bool?> team2);
  void setTeamNames(String name1, String name2);
  void showOutcomeDialog(String result, String score);
  void hideOutcomeDialog();
}

class PenaltyView extends StatefulWidget {
  const PenaltyView({super.key});

  @override
  State<PenaltyView> createState() => _PenaltyViewState();
}

class _PenaltyViewState extends State<PenaltyView> implements IPenaltyView {
  bool showOutcome = false;
  String team1 = '';
  String team2 = '';
  String results = 'Win';
  String scores = '5';
  List<bool?> penaltiesTeam1 = [];
  List<bool?> penaltiesTeam2 = [];
  IPenaltyPresenter? _presenter;

  @override
  void hideOutcomeDialog() {
    showOutcome = false;
  }

  @override
  void setPenalties(List<bool?> team1, List<bool?> team2) {
    setState(() {
      penaltiesTeam1 = team1;
      penaltiesTeam2 = team2;
    });
  }

  @override
  void setTeamNames(String name1, String name2) {
    setState(() {
      team1 = name1;
      team2 = name2;
    });
  }

  @override
  void showOutcomeDialog(String result, String score) {
    showOutcome = true;
    results = result;
    scores = score;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _presenter = PenaltyPresenter(this, PenaltyModel());
      _presenter!.getTeamNames();
      _presenter!.setPenalties();
    });
  }

  @override
  Widget build(BuildContext context) {
    var s = MediaQuery.of(context).size;
    var counterW = s.width * 0.8;
    var counterH = s.height * 0.1;

    var p5 = SizedBox(height: s.height * 0.05);

    var football = SizedBox(
        height: s.height * 0.3, child: Image.asset('assets/soccer.png'));

    var counterT1 = Center(
      child: Counter(
        width: counterW,
        height: counterH,
        teamName: team1,
        penalties: penaltiesTeam1,
        teamColor: Colors.pinkAccent[400]!.withOpacity(0.75),
      ),
    );

    var counterT2 = Center(
      child: Counter(
        width: counterW,
        height: counterH,
        teamName: team2,
        penalties: penaltiesTeam2,
        teamColor: Colors.blueAccent[400]!.withOpacity(0.85),
      ),
    );

    var btnColor = const Color.fromARGB(255, 16, 220, 114);

    var shootBtn = RoundedElevatedButton(
      title: "Shoot!",
      onPressed: _presenter!.shootNextPenalty,
      buttonColor: btnColor,
    );

    if (showOutcome) {
      Timer(
          const Duration(seconds: 1),
          () => showDialog(
              context: context,
              builder: (context) {
                return ScoresDialog(
                    results: results,
                    scores: scores,
                    onReplayPressed: _presenter!.resetScores);
              }));
    }

    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [p5, p5, football, p5, counterT1, p5, counterT2, p5, shootBtn],
    )));
  }
}

//bridge here
//find a way to make it update
//maybe use createState
//either way
//read about a widgets lifecycle
//try whatever comes to mind
//and if not add a callback that will exeute once the widget build once
//then finish the ui
//finish the article
//do the ui for drooti screens
//and read up on clean architecture
//especially the presenter part
//then do the backend for the ui screens you did
//and make them all work
//by this point the only thing missing in drooti should be the game screen
//start simple just make the screen start moving parallax effect
//make drooti move
//do the year thing
//and keep count
//then figure out the power ups and damage objects
