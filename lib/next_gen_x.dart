import 'package:life/world.dart';

extension NextGenX on World {
  World get nextGeneration {
    final nextGen = List.generate(length, (i) => List.filled(length, false));

    for (int i = 1; i < length; i++) {
      if (i == length - 1) continue;

      for (int j = 1; j < this[i].length; j++) {
        if (j == this[i].length - 1) continue;

        int neighbors = 0;

        for (int x = -1; x <= 1; x++) {
          for (int y = -1; y <= 1; y++) {
            if (x == 0 && y == 0) continue;

            if (this[i + x][j + y]) {
              neighbors++;
            }
          }
        }

        final isAlive = this[i][j];

        if (isAlive) {
          if (neighbors < 2 || neighbors > 3) {
            nextGen[i][j] = false;
          } else {
            nextGen[i][j] = true;
          }
        } else if (neighbors == 3) {
          nextGen[i][j] = true;
        }
      }
    }

    return nextGen;
  }

  int get alive {
    int count = 0;

    for (int i = 0; i < length; i++) {
      for (int j = 0; j < this[i].length; j++) {
        if (this[i][j]) {
          count++;
        }
      }
    }

    return count;
  }
}
