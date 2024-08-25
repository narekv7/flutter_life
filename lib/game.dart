import 'dart:async';

import 'package:flutter/material.dart';
import 'package:life/next_gen_x.dart';
import 'package:life/world.dart';
import 'package:life/world_painter.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  Timer? _timer;

  int generation = 0;
  int speed = 100;
  World world = Worlds.random();

  void _reset() {
    _stopTimer();

    setState(() {
      generation = 0;
      world = Worlds.random();
    });
  }

  void _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(
      Duration(milliseconds: speed),
      (_) {
        setState(() {
          generation++;
          world = world.nextGeneration;
        });
      },
    );
  }

  void _stopTimer() {
    _timer?.cancel();

    setState(() {
      _timer = null;
    });
  }

  void _playXpause() {
    if (_timer == null) {
      _startTimer();
    } else {
      _stopTimer();
    }
  }

  void _speedUp() {
    if (speed == 10) return;

    if (speed > 10 && speed <= 100) {
      setState(() {
        speed -= 10;
      });
    } else if (speed > 100 && speed <= 1000) {
      setState(() {
        speed -= 100;
      });
    } else {
      return;
    }

    _startTimer();
  }

  void _speedDown() {
    if (speed == 1000) return;

    if (speed >= 10 && speed < 100) {
      setState(() {
        speed += 10;
      });
    } else if (speed >= 100 && speed < 1000) {
      setState(() {
        speed += 100;
      });
    } else {
      return;
    }
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).viewPadding.top + 10),
          // ========== World ==========
          ColoredBox(
            color: Colors.black,
            child: SizedBox.square(
              dimension: 350,
              child: CustomPaint(
                painter: WorldPainter(world: world),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // ========== Stats ==========
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                const Spacer(),
                const Text(
                  'Generation: ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                Text(
                  generation.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                const Text(
                  'Alive: ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                Text(
                  world.alive.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // ========== Controls ==========
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Row(
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Speed (ms)',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 4),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ': $speed',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: _speedUp,
                            child: const Icon(Icons.remove),
                          ),
                          const SizedBox(width: 4),
                          ElevatedButton(
                            onPressed: _speedDown,
                            child: const Icon(Icons.add),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _playXpause,
                child: _timer == null
                    ? const Icon(Icons.play_arrow)
                    : const Icon(Icons.pause),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _reset,
                child: const Icon(Icons.refresh),
              ),
            ],
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
