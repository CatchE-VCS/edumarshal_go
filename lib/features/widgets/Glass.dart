import 'dart:ui';
import 'package:flutter/material.dart';

class Glass extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;

  Glass({
    Key? key,
    required this.height,
    required this.width,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: width,
        height: height,
        child: Stack(
          children: [
            // for create blur effect
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 5.0, // Change this to double
                sigmaY: 5.0, // Change this to double
              ),
              child: Container(),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: Theme.of(context).brightness == Brightness.light
                        ? [
                            Colors.white.withOpacity(0.5),
                            Color.fromARGB(255, 118, 152, 170).withOpacity(0.7)
                          ]
                        : [
                            Colors.grey.shade800.withOpacity(0.5),
                            Colors.black54.withOpacity(0.5)
                          ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
