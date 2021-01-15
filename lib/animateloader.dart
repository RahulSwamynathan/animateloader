library animateloader;

import 'package:flutter/material.dart';

class AnimateLoader extends StatefulWidget {
  final bool startAnimate;
  final Widget child;

  const AnimateLoader({Key key, @required this.startAnimate, @required this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AnimateLoaderState();
}

class AnimateLoaderState extends State<AnimateLoader> with TickerProviderStateMixin {
  Animation<double> _fadeInFadeOut;
  AnimationController animation;

  AnimateLoaderState() {
    animation = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    _fadeInFadeOut = Tween<double>(begin: 0.2, end: 0.8).animate(animation);
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animation.reverse();
      } else if (status == AnimationStatus.dismissed) {
        animation.forward();
      }
    });
    animation.forward();
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.startAnimate
        ? FadeTransition(
            opacity: _fadeInFadeOut,
            child: AbsorbPointer(absorbing: true, child: widget.child),
          )
        : widget.child;
  }
}
