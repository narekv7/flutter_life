import 'dart:ui';

class Cell {
  final bool isAlive;
  final Color color;

  const Cell({
    required this.isAlive,
    required this.color,
  });

  Cell copyWith({
    bool? isAlive,
    Color? color,
  }) {
    return Cell(
      isAlive: isAlive ?? this.isAlive,
      color: color ?? this.color,
    );
  }

  static const dead = Cell(
    isAlive: false,
    color: Color.fromARGB(255, 0, 0, 0),
  );
}

extension MergeCellsX on List<Cell> {
  Cell get merge {
    if (any((e) => !e.isAlive)) {
      return Cell.dead;
    }

    return reduce(
      (value, element) => Cell(
        isAlive: true,
        color: Color.fromARGB(
          255,
          (value.color.red + element.color.red) ~/ 2,
          (value.color.green + element.color.green) ~/ 2,
          (value.color.blue + element.color.blue) ~/ 2,
        ),
      ),
    );
  }
}
