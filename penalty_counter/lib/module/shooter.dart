import 'dart:math';

class Shooter {
  // Left = 0
  // Middle = 1
  // Right = 2

  bool shootPenalty() {
    var random = Random();
    int shotDirection = random.nextInt(2);
    int goalKeeperDirection = random.nextInt(2);

    bool goal = shotDirection != goalKeeperDirection;
    if (goal) {
      return true;
    }
    return false;
  }
}
