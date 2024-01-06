import 'dart:async';

import 'package:flutter/material.dart';

class AppNameAnimationWidget extends StatefulWidget {
  final String text;
  final TextStyle textStyle;
  final Duration duration;
  final Color startColor;

  const AppNameAnimationWidget({
    Key? key,
    required this.text,
    required this.textStyle,
    required this.duration,
    required this.startColor,
  }) : super(key: key);

  @override
  _AppNameAnimationWidgetState createState() => _AppNameAnimationWidgetState();
}

class _AppNameAnimationWidgetState extends State<AppNameAnimationWidget> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;
  late List<Color> _randomColors;
  late String _visibleText;
  late List<Timer> _timers;

  @override
  void initState() {
    super.initState();

    // Animasyon kontrolcüleri ve animasyonları oluştur
    _controllers = List.generate(widget.text.length, (index) {
      return AnimationController(
        vsync: this,
        duration: widget.duration,
      );
    });

    _animations = _controllers.map((controller) {
      return Tween<double>(begin: 0, end: 1).animate(controller);
    }).toList();

// Başlangıç rengi üzerinden tonlar arasında geçiş yap
    _randomColors = List.generate(widget.text.length, (index) {
      double opacity = (index + 3) / widget.text.length;
      return widget.startColor.withOpacity(opacity > 1.0 ? 1.0 : opacity);
    });

    // Görünen metni sıfırla
    _visibleText = '';

    // Timer'ları başlat
    _timers = [];
    for (int i = 0; i < widget.text.length; i++) {
      _timers.add(Timer(Duration(milliseconds: (i + 1) * 100), () {
        _controllers[i].forward();
        setState(() {
          _visibleText += widget.text[i];
        });
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.text.length, (index) {
        return FadeTransition(
          opacity: _animations[index],
          child: Text(
            _visibleText.length > index ? _visibleText[index] : '',
            style: widget.textStyle.copyWith(color: _randomColors[index]),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    // Timer'ları ve animasyon kontrolcülerini temizle
    for (int i = 0; i < widget.text.length; i++) {
      _timers[i].cancel();
      _controllers[i].dispose();
    }
    super.dispose();
  }
}
