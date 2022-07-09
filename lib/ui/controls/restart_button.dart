import 'package:flutter/material.dart';

import '../../utils/game_state.dart';

class RestartButton extends StatelessWidget {
  const RestartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const IconButton(
      icon: Icon(
        Icons.restart_alt,
      ),
      onPressed: GameState.restart,
    );
  }
}
