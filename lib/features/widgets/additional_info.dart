import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdditionalInfo extends StatefulWidget {
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

  @override
  State<AdditionalInfo> createState() => _AdditionalInfoState();
}

class _AdditionalInfoState extends State<AdditionalInfo> {
  Color? get randomColor {
    final colors = [
      Colors.cyanAccent,
      Colors.orangeAccent, // selected
      Colors.pinkAccent,
      Colors.greenAccent, // selected
      Colors.lightBlueAccent,
    ];
    return colors[DateTime.now().microsecond % colors.length];
  }

  List<Color> selectedColor = [
    Colors.orangeAccent,
    Colors.greenAccent,
    Colors.cyanAccent,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 240,
      padding: const EdgeInsets.all(8.0),
      width: 220,
      decoration: BoxDecoration(
        color: selectedColor[widget.index],
        shape: BoxShape.rectangle,
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 60,
            width: 80,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: widget.image,
          ),
          const SizedBox(
            height: 12.0,
          ),
          Text(
            widget.label,
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
            widget.value,
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
