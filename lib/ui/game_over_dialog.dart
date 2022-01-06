import 'package:flutter/material.dart';

import '../utils/game_state.dart';

class GameOverDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('game over haha'),
      actions: [
        ElevatedButton(
          onPressed: () {
            // for some reason [Navigator.of(context).pop()]
            // did not wanna pop??
            Navigator.of(context, rootNavigator: true)
                .popUntil((route) => route.isFirst);

            GameState.restart();
          },
          child: Text('restart??'),
        ),
      ],
    );
  }
}
