import 'package:flutter/material.dart';
import 'hud_indicator.dart';

class HudLoading extends StatefulWidget {
  const HudLoading({Key? key}) : super(key: key);

  @override
  HudLoadingState createState() => HudLoadingState();
}

class HudLoadingState extends State<HudLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(seconds: 3), value: 1);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void dismiss() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Opacity(
              opacity: _animationController.value,
              child: IgnorePointer(
                ignoring: false,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            );
          },
        ),
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Opacity(
              opacity: _animationController.value,
              child: HudIndicator(),
            );
          },
        ),
      ],
    );
  }
}
