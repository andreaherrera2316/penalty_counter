import 'package:penalty_counter/module/team.dart';
import 'package:penalty_counter/model/team_data.dart';

abstract class IPenaltyModel {
  void shootNextPenalty();
  void resetScores();
  bool get allPenaltiesShot;
  int get goalsTeam1;
  int get goalsTeam2;
  TeamData get getTeam1;
  TeamData get getTeam2;
}

class PenaltyModel implements IPenaltyModel {
  bool firstTeamsTurn = true;
  var team1 = Team(name: "Team Red");
  var team2 = Team(name: "Team Blue");

  @override
  TeamData get getTeam1 =>
      TeamData(name: team1.name, penalties: team1.penalties);

  @override
  TeamData get getTeam2 =>
      TeamData(name: team2.name, penalties: team2.penalties);
  @override
  int get goalsTeam1 => team1.goals;

  @override
  int get goalsTeam2 => team2.goals;

  @override
  bool get allPenaltiesShot => team1.allPenaltiesShot && team2.allPenaltiesShot;

  @override
  void shootNextPenalty() {
    if (firstTeamsTurn) {
      team1.shootNextPenalty();
      firstTeamsTurn = false;
    } else {
      team2.shootNextPenalty();
      firstTeamsTurn = true;
    }
  }

  @override
  void resetScores() {
    firstTeamsTurn = true;
    team1.resetPenalties();
    team2.resetPenalties();
  }
}
