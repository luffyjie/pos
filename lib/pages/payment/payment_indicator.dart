import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pos/utils/utils.dart';

class PaymentIndicator extends StatefulWidget {
  @override
  _PaymentIndicatorSate createState() => _PaymentIndicatorSate();
}

class _PaymentIndicatorSate extends State<PaymentIndicator>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  int _count = 10;
  late Timer _timer;

  @override
  void initState() {
    var period = Duration(seconds: 1);
    Timer.periodic(period, (timer) {
      _timer = timer;
      if (this.mounted && _count > 0) {
        setState(() {
          _count--;
        });
      }
    });
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
      child: Column(
        children: [
          Spacer(),
          Stack(
            alignment: Alignment.center,
            children: [
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
              Positioned(
                child: Text(
                  '$_count\s',
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      ?.copyWith(color: Colors.black),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            width: 180,
            child: Text(
              'Waiting for Response from server',
              maxLines: 2,
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 50),
          Spacer(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer.cancel();
    super.dispose();
  }
}
