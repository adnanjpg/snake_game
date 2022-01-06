import 'package:flutter/material.dart';

import '../utils/game_state.dart';

class RestartButton extends StatelessWidget {
  const RestartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      top: 0,
      child: IconButton(
        icon: const Icon(
          Icons.restart_alt,
        ),
        onPressed: () {
          GameState.restart();
        },
      ),
    );
  }
}
