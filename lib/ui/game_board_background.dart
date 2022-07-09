import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/board_size_provider.dart';

import '../models/cube_model.dart';

class GameBoardBackground extends StatelessWidget {
  const GameBoardBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BoardDimensionsProvider>(
      builder: (context, val, _) {
        return Column(
          children: List.generate(
            val.y,
            (y) {
              return Row(
                children: List.generate(
                  val.x,
                  (x) {
                    return CubeModel.bgCube(x, y).cube();
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
