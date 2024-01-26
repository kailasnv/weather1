import 'dart:ui';

import 'package:flutter/material.dart';

class BlurBackgroundWidget extends StatelessWidget {
  final Widget child;
  const BlurBackgroundWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: const Alignment(0, -0.2),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.black,
                    Colors.black,
                    Colors.deepPurple.withOpacity(0.3),
                    Colors.deepPurple.shade900,
                  ]),
            ),
          ),
        ),

        // blur filter
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
          child: Container(),
        ),
        // child
        child,
      ],
    );
  }
}
