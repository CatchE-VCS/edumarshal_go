import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:edumarshal/features/dashboard/model/attendance_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//
// final initialAttAnimationPod = Provider((ref) => false);
//
// class AttAnimationNotifier extends Notifier<bool>{
//   @override
//   bool build() {
//     return ref.watch(initialAttAnimationPod);
//   }
// }
//
// final attAnimationPod = NotifierProvider<AttAnimationNotifier, bool>(
//   AttAnimationNotifier.new,
//   name: 'attAnimationPod',
// );

final class SwipeCardsScreen extends StatefulWidget {
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
  // static List<String> cardData = ['Only one'];
  double _targetSize = 0;
  late Tween<double> tween;

  @override
  void initState() {
    _targetSize = widget.overallPercentage / 100;
    tween = Tween<double>(begin: 0, end: _targetSize);
    super.initState();
  }

  @override
  void dispose() {
    _targetSize = 0;
    tween = Tween<double>(begin: 0, end: _targetSize);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // int topCardIndex = 0;

    // AnimationController animationController = AnimationController(vsync: this)
    //   ..repeat();
    return Card(
      elevation: 8.0,
      margin: const EdgeInsets.all(16.0),
      color: Colors.blueAccent,
      child: SizedBox(
        width: 300,
        height: 150,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
                    height: 4,
                  ),
                  Text(
                    '${widget.totalSubjects} Subjects (incl. Labs):',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 43,
                    width: 260,
                    child: AnimatedText(
                      subjectsList: widget.subjectsList,
                    ),
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
                    child: TweenAnimationBuilder<double>(
                      onEnd: () {
                        if (_targetSize == 0) {
                          setState(() {
                            _targetSize = widget.overallPercentage / 100;
                          });
                        } else {
                          Future.delayed(
                            const Duration(seconds: 3),
                            () => setState(() {
                              _targetSize = 0;
                            }),
                          );
                        }
                      },
                      tween: tween,
                      duration: const Duration(milliseconds: 2000),
                      builder:
                          (BuildContext context, double value, Widget? child) =>
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
                      ),
                    ),
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

  const AnimatedText({Key? key, required this.subjectsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: subjectsList
          .map(
            (subject) => TyperAnimatedText(
              subject.name ?? '',
              speed: const Duration(milliseconds: 70),
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          )
          .toList(),
    );
  }
}
