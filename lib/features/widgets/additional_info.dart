import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdditionalInfo extends StatelessWidget {
  final Image image;
  final String label;
  final String value;
  final int index;

  const AdditionalInfo({
    super.key,
    required this.image,
    required this.label,
    required this.value,
    required this.index,
  });

// Color? get randomColor {
  //   final colors = [
  //     Colors.cyanAccent,
  //     Colors.orangeAccent, // selected
  //     Colors.pinkAccent,
  //     Colors.greenAccent, // selected
  //     Colors.lightBlueAccent,
  //   ];
  //   return colors[DateTime.now().microsecond % colors.length];
  // }

  static List<Color> selectedColor = [
    Colors.orangeAccent,
    Colors.greenAccent,
    Colors.cyan,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 245,
      padding: const EdgeInsets.all(10.0),
      width: 220,
      decoration: BoxDecoration(
        boxShadow: [
          //dark shadow at bottom right
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.dark
                ? const Color.fromARGB(255, 151, 150, 150)
                : const Color.fromARGB(255, 103, 102, 102),
            blurRadius: 5,
            offset: const Offset(1, 1),
          ),
          // white shadow at left
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.dark
                ? const Color.fromARGB(255, 35, 35, 35)
                : const Color.fromARGB(255, 231, 229, 229),
            blurRadius: 5,
            offset: const Offset(-1, -1),
          ),
        ],
        color: selectedColor[index],
        // shape: BoxShape.rectangle,
        border: Border.all(
          color: Theme.of(context).brightness == Brightness.dark
              ? const Color.fromARGB(31, 19, 18, 18)
              : const Color.fromARGB(255, 230, 228, 228),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 75,
            width: 80,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: image,
          ),
          const SizedBox(
            height: 12.0,
          ),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
          ),
        ],
      ),
    );
  }
}
