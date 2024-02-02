import 'dart:ui';

import 'package:flutter/material.dart';

class GlassText extends StatelessWidget {
  final height;
  final width;
  final child;
  const GlassText({ 
    required this.height, 
    required this.width, 
    required this.child,
    });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        
        width: width,
        height: height,
        child:Stack(
          children: [
            BackdropFilter(
              filter:ImageFilter.blur(
                sigmaX: 15.0,
                sigmaY: 15.0,

              ),
              child: Container(
                


              ),
               ),

               Container(

                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors:[ 
                      Colors.white.withOpacity(0.4),
                      Colors.white.withOpacity(0.1),
                    ]
                    )
                ),
               ),
               Padding(
                padding: EdgeInsets.all(8),
                child: child,
                )
            
      
          ],
        ),
      ),
    );
  }
}