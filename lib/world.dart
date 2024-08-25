import 'dart:ui';
import 'dart:math';

import 'package:life/cell.dart';

/// A world grid is a 2-dimensional list of boolean values, where each element represents a cell in the world.
typedef World = List<List<Cell>>;

abstract final class Worlds {
  /// Generates a random world grid.
  ///
  /// The [size] parameter specifies the size of the grid. By default, it is set to 100.
  /// The value of each cell is randomly determined using the `Random` class.
  /// The probability of a cell being `true` is 1/3.
  static World random([int size = 100]) {
    final halfSize = size ~/ 2;

    return List.generate(
      size,
      (i) => List.generate(
        size,
        (j) => Cell(
          isAlive: Random().nextInt(3) == 0,
          color: i >= halfSize && j >= halfSize
              ? const Color.fromRGBO(255, 0, 255, 1)
              : Color.fromARGB(
                  255,
                  (i < halfSize && j < halfSize) ? 255 : 0,
                  (i < halfSize && j >= halfSize) ? 255 : 0,
                  (i >= halfSize && j < halfSize) ? 255 : 0,
                ),
        ),
      ),
    );
  }
}
