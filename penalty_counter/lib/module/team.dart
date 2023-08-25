import 'package:penalty_counter/module/shooter.dart';

class Team {
  Team({
    required this.name,
  }) : penalties = List.filled(5, null);

  String name;

  List<bool?> penalties;

  int get goals => penalties.where((penalty) => penalty == true).length;

  bool get allPenaltiesShot => !penalties.contains(null);

  void shootNextPenalty() {
    int nextPenaltyIndex = penalties.indexOf(null);
    bool allPenaltiesShot = nextPenaltyIndex >= penalties.length;

    if (!allPenaltiesShot) {
      penalties[nextPenaltyIndex] = Shooter().shootPenalty();
    }
  }

  void resetPenalties() => penalties = List.filled(5, null);
}
