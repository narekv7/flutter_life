import 'dart:math';

/// A world grid is a 2-dimensional list of boolean values, where each element represents a cell in the world.
typedef World = List<List<bool>>;

abstract final class Worlds {
  /// Generates a random world grid.
  ///
  /// The [size] parameter specifies the size of the grid. By default, it is set to 100.
  /// The value of each cell is randomly determined using the `Random` class.
  /// The probability of a cell being `true` is 1/3.
  static World random([int size = 100]) {
    return List.generate(
      size,
      (i) => List.generate(
        size,
        (j) => Random().nextInt(4) == 0,
      ),
    );
  }
}
