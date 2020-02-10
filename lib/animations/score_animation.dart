import 'package:flutter/material.dart';

class ScoreAnimation extends StatefulWidget {
  @override
  _ScoreAnimationState createState() => _ScoreAnimationState();
}

class _ScoreAnimationState extends State<ScoreAnimation>
    with TickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationController;
  double startValue = 0.0;
  double endValue = 1.0;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _animation = Tween(
      begin: startValue,
      end: endValue,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutSine,
      ),
    );
    _animation.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed){
          _animationController.reverse();
        } else if (status == AnimationStatus.dismissed){
          _animationController.forward(from: 0);
        }
      },
    );
    _animationController.forward();
  }
  @override
  void dispose(){
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildAnimation();
  }
  buildAnimation(){
    Color _color = Colors.white10.withOpacity(.01);

    return  AnimatedBuilder(
      animation: _animation,
      builder: (context,child){
        return Container(
          height: 7,
          width: 70,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              colors: [_color,_color,Colors.green[300],_color,_color],
              stops: [0,_animation.value-.15,_animation.value,_animation.value+.15,1],
            ),
          ),
          child: child,
        );
      },
      child: Container(
      ),

    );
  }
}

