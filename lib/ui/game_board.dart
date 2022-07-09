import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../models/board_dimensions_model.dart';
import '../providers/board_size_provider.dart';
import '../utils/game_state.dart';
import 'controls/controls_widgets.dart';
import 'game_board_body.dart';

class GameBoard extends StatefulWidget {
  const GameBoard({Key? key}) : super(key: key);

  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  @override
  void initState() {
    GameState.setDefaults();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        SchedulerBinding.instance.addPostFrameCallback(
          (_) {
            Provider.of<BoardDimensionsProvider>(context, listen: false).size =
                // BoardDimensionsModel.fromSize(MediaQuery.of(context).size);
                BoardDimensionsModel.fromConstraints(constraints);
          },
        );
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: const [
                GameBoardBody(),
                ControlsWidgets(),
              ],
            ),
          ),
        );
      },
    );
  }
}
