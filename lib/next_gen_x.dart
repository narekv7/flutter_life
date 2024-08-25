import 'package:life/cell.dart';
import 'package:life/world.dart';

extension NextGenX on World {
  World get nextGeneration {
    final World nextGen = List.generate(
      length,
      (i) => List.filled(
        length,
        Cell.dead,
      ),
    );

    for (int i = 1; i < length; i++) {
      if (i == length - 1) continue;

      for (int j = 1; j < this[i].length; j++) {
        if (j == this[i].length - 1) continue;

        List<Cell> neighbors = [];

        for (int x = -1; x <= 1; x++) {
          for (int y = -1; y <= 1; y++) {
            if (x == 0 && y == 0) continue;

            if (this[i + x][j + y].isAlive) {
              neighbors.add(this[i + x][j + y]);
            }
          }
        }

        final isAlive = this[i][j].isAlive;

        if (isAlive) {
          if (neighbors.length < 2 || neighbors.length > 3) {
            nextGen[i][j] = Cell.dead;
          } else {
            nextGen[i][j] = this[i][j].copyWith();
          }
        } else if (neighbors.length == 3) {
          nextGen[i][j] = neighbors.merge;
        }
      }
    }

    return nextGen;
  }

  int get alive {
    int count = 0;

    for (int i = 0; i < length; i++) {
      for (int j = 0; j < this[i].length; j++) {
        if (this[i][j].isAlive) {
          count++;
        }
      }
    }

    return count;
  }
}
