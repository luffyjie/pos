import 'package:flutter/material.dart';
import 'package:pos/utils/utils.dart';

class HudIndicator extends StatefulWidget {
  @override
  _HudIndicatorSate createState() => _HudIndicatorSate();
}

class _HudIndicatorSate extends State<HudIndicator>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      value: 0,
      vsync: this,
      duration: Duration(
        milliseconds: 800,
      ),
    );
    _animationController.forward();
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reset();
        _animationController.forward();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 52.5,
                maxHeight: 52.5,
              ),
              child: Image.asset(assetsIcon('loading_circle_logo')),
            ),
          ),
          Positioned(
            child: RotationTransition(
              alignment: Alignment.center,
              turns: _animationController,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 98,
                  maxHeight: 97,
                ),
                child: Image.asset(assetsIcon('loading_indicator')),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
