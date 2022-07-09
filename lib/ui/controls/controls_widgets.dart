import 'package:flutter/material.dart';
import 'settings_button.dart';
import 'restart_button.dart';

class ControlsWidgets extends StatelessWidget {
  const ControlsWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      top: 0,
      child: Column(
        children: const [
          RestartButton(),
          SettingsButton(),
        ],
      ),
    );
  }
}
