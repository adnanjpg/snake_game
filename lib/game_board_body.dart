import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'snake_provider.dart';
import 'consts.dart';
import 'cube_model.dart';

class GameBoardBody extends StatefulWidget {
  const GameBoardBody({Key? key}) : super(key: key);

  @override
  _GameBoardBodyState createState() => _GameBoardBodyState();
}

class _GameBoardBodyState extends State<GameBoardBody> {
  late SnakeProvider w;
  @override
  void initState() {
    w = Provider.of<SnakeProvider>(context, listen: false);
    // Random rand = Random.secure();
    Future.microtask(() {
      Timer.periodic(
        Duration(milliseconds: 1000),
        (_) {
          w.forward();

          if (w.gameOver) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('game over haha'),
                );
              },
            );
            _.cancel();
          }
        },
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SnakeProvider>(
      builder: (context, val, child) {
        return Stack(
          children: [
            child!,
            ...snk(val.cubes),
          ],
        );
      },
      child: bg(),
    );
  }

  List<Widget> snk(List<CubeModel> cubes) {
    return cubes
        .map(
          (e) => Positioned(
            left: e.x * size,
            top: e.y * size,
            child: e.cube(),
          ),
        )
        .toList();
  }

  Widget bg() {
    return Column(
      children: List.generate(
        boardSizeY,
        (y) => Row(
          children: List.generate(
            boardSizeX,
            (x) => CubeModel.bgCube(x, y).cube(),
          ),
        ),
      ),
    );
  }
}
