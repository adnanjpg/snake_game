import 'package:flutter/material.dart';

import '../utils/consts.dart';
import '../models/cube_model.dart';

class GameBoardBackground extends StatelessWidget {
  const GameBoardBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        boardSizeY,
        (y) {
          return Row(
            children: List.generate(
              boardSizeX,
              (x) {
                return CubeModel.bgCube(x, y).cube();
              },
            ),
          );
        },
      ),
    );
  }
}
