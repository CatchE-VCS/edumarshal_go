import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/theme/theme_controller.dart';

class Glass extends ConsumerWidget {
  final double? height;
  final double? width;
  final Widget child;
  final Color? color;

  const Glass({
    Key? key,
    this.width,
    required this.child,
    this.height,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var brightness = Theme.of(context).brightness;
    var currentTheme = ref.watch(themecontrollerProvider);
    var isLightMode = brightness == Brightness.light;
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            // for creating blur effect
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 5.0,
                sigmaY: 5.0,
              ),
              child: Container(),
            ),
            Container(
              decoration: BoxDecoration(
                // border: Border.all(color: Colors.white.withOpacity(0.2)),
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: currentTheme == ThemeMode.light
                      ? [
                          Colors.white.withOpacity(0.5),
                          const Color.fromARGB(255, 119, 156, 176)
                              .withOpacity(0.7)
                        ]
                      : currentTheme == ThemeMode.dark
                          ? [
                              Colors.grey.shade800.withOpacity(0.5),
                              Colors.black54.withOpacity(0.5)
                            ]
                          : isLightMode
                              ? [
                                  Colors.white.withOpacity(0.5),
                                  const Color.fromARGB(255, 119, 156, 176)
                                      .withOpacity(0.7)
                                ]
                              : [
                                  Colors.grey.shade800.withOpacity(0.5),
                                  Colors.black54.withOpacity(0.5)
                                ],
                ),
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
