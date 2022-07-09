import 'package:flutter/material.dart';

import '../utils/consts.dart';

class SettingsDialog extends StatelessWidget {
  const SettingsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Dialog(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(defPaddingSize),
          child: IntrinsicWidth(
            child: _Body(),
          ),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column();
  }
}
