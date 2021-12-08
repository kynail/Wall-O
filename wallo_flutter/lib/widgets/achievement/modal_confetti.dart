import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

class ModalConfetti extends StatefulWidget {
  const ModalConfetti({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  State<ModalConfetti> createState() => ModalConfettiState();
}

class ModalConfettiState extends State<ModalConfetti>
    with TickerProviderStateMixin {
  final _modalAnimationDuration = Duration(milliseconds: 500);

  AnimationController _modalController;
  Animation<double> _animation;

  ConfettiController _confettiController;
  bool _showModal = false;

  @override
  void initState() {
    _confettiController = ConfettiController(duration: Duration(seconds: 1));

    _modalController = AnimationController(
      duration: _modalAnimationDuration,
      vsync: this,
    );

    _animation =
        CurvedAnimation(parent: _modalController, curve: Curves.fastOutSlowIn);

    super.initState();
  }

  playNewAchievement() {
    _confettiController.play();
    _modalController.forward();
    setState(() {
      _showModal = true;
    });
  }

  stopConfetti() {
    _confettiController.stop();
  }

  closeModal() async {
    _modalController.reverse();

    await Future.delayed(_modalAnimationDuration, () {
      setState(() {
        _showModal = false;
      });
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _modalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (_showModal == true)
          Opacity(
            opacity: 0.4,
            child: SizedBox(
              child:
                  const ModalBarrier(dismissible: false, color: Colors.black),
            ),
          ),
        if (_showModal == true)
          Padding(
            padding: const EdgeInsets.all(38.0),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ScaleTransition(
                    scale: _animation,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: widget.child,
                    ),
                  ),
                ],
              ),
            ),
          ),
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confettiController,
            emissionFrequency: 0.04,
            numberOfParticles: 30,
            blastDirectionality: BlastDirectionality.explosive,
          ),
        ),
      ],
    );
  }
}
