import 'dart:ui';

import 'package:flutter/material.dart';

class GlassText extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;

  const GlassText({
    super.key,
    required this.height,
    required this.width,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 15.0,
                sigmaY: 15.0,
              ),
              child: Container(),
            ),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    Colors.white.withOpacity(0.4),
                    Colors.white.withOpacity(0.1),
                  ])),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: child,
            )
          ],
        ),
      ),
    );
  }
}
