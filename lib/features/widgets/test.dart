import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:edumarshal/features/dashboard/model/attendance_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SwipeCardsScreen extends StatefulWidget {
  const SwipeCardsScreen(
      {super.key,
      required this.overallPercentage,
      required this.totalSubjects,
      required this.subjectsList});
  final double overallPercentage;
  final int totalSubjects;
  final List<Subject> subjectsList;
  @override
  State<SwipeCardsScreen> createState() => _SwipeCardsScreenState();
}

class _SwipeCardsScreenState extends State<SwipeCardsScreen> {
  List<String> cardData = ['First Card', 'Second Card', 'Third Card'];
  int topCardIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: cardData.length,
      onPageChanged: (index) {
        setState(() {
          topCardIndex = index;
        });
      },
      itemBuilder: (context, index) {
        return _buildCard(cardData[index]);
      },
    );
  }

  Widget _buildCard(String text) {
    return Card(
      elevation: 8.0,
      margin: const EdgeInsets.all(16.0),
      color: Colors.blueAccent,
      child: SizedBox(
        width: 300,
        height: 150,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Attendance',
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    '${widget.totalSubjects} Subjects (incl. Labs)',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Subjects:- ',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Container(
                    height: 43,
                    width: 260,
                    child: Expanded(
                        child: AnimatedText(
                      subjectsList: widget.subjectsList,
                    )),
                  ),
                ],
              ),
              const Spacer(
                flex: 2,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    padding: const EdgeInsets.all(16),
                    child: TweenAnimationBuilder(
                        tween: Tween<double>(
                            begin: 0, end: widget.overallPercentage / 100),
                        duration: Duration(milliseconds: 1500),
                        builder: (BuildContext context, double value,
                                Widget? child) =>
                            Stack(
                              fit: StackFit.expand,
                              children: [
                                CircularProgressIndicator(
                                  strokeWidth: 9,
                                  value: value,
                                  backgroundColor: Colors.white,
                                  color: widget.overallPercentage >= 75
                                      ? Colors.greenAccent
                                      : widget.overallPercentage >= 50
                                          ? Colors.orangeAccent
                                          : Colors.redAccent,
                                ),
                              ],
                            )),
                  ),
                  Text(
                    '${widget.overallPercentage}%',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedText extends StatelessWidget {
  final List<Subject> subjectsList;

  AnimatedText({Key? key, required this.subjectsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: subjectsList
          .map(
            (subject) => TyperAnimatedText(
              subject.name,
              speed: const Duration(milliseconds: 70),
            ),
          )
          .toList(),
    );
  }
}
