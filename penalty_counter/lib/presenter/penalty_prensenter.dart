import 'package:penalty_counter/model/penalty_model.dart';
import 'package:penalty_counter/view/penalty_view.dart';

abstract class IPenaltyPresenter {
  void getTeamNames();
  void setPenalties();
  void shootNextPenalty();
  void showPenaltyOutcome();
  void hidePenaltyOutcome();
  void resetScores();
}

class PenaltyPresenter implements IPenaltyPresenter {
  PenaltyPresenter(this.view, this.model);

  IPenaltyView view;
  IPenaltyModel model;

  @override
  void getTeamNames() =>
      view.setTeamNames(model.getTeam1.name, model.getTeam2.name);

  @override
  void setPenalties() {
    view.setPenalties(model.getTeam1.penalties, model.getTeam2.penalties);
  }

  @override
  void shootNextPenalty() {
    if (model.allPenaltiesShot) {
      resetScores();
    }

    model.shootNextPenalty();

    if (model.allPenaltiesShot) {
      showPenaltyOutcome();
    }
    setPenalties();
  }

  @override
  void showPenaltyOutcome() {
    bool tie = model.goalsTeam1 == model.goalsTeam2;
    if (tie) {
      view.showOutcomeDialog(
          "Tie", "${model.goalsTeam1} - ${model.goalsTeam2}");
      return;
    }

    bool team1Won = model.goalsTeam1 > model.goalsTeam2;
    if (team1Won) {
      view.showOutcomeDialog("${model.getTeam1.name} Won!",
          "${model.goalsTeam1} - ${model.goalsTeam2}");
    } else {
      view.showOutcomeDialog("${model.getTeam2.name} Won",
          "${model.goalsTeam2} - ${model.goalsTeam1}");
    }
  }

  @override
  void resetScores() {
    model.resetScores();
    hidePenaltyOutcome();
    setPenalties();
  }

  @override
  void hidePenaltyOutcome() => view.hideOutcomeDialog();
}
