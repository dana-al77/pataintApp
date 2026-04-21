import 'package:flutter/material.dart';

import '../../../core/constant/imageasset.dart';

class LogoAuth extends StatefulWidget {
  const LogoAuth({super.key});

  @override
  State<LogoAuth> createState() => _LogoAuthState();
}

class _LogoAuthState extends State<LogoAuth> with SingleTickerProviderStateMixin {
  double _opacity = 0.0;
  Offset _offset = Offset(0, -0.2);

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      if (!mounted) return;
      setState(() {
        _opacity = 1.0;
        _offset = Offset.zero;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: _offset,
      duration: Duration(milliseconds: 3000),
      curve: Curves.easeOut,
      child: AnimatedOpacity(
        opacity: _opacity,
        duration: Duration(milliseconds: 3000),
        child: Image.asset(
          AppImageAsset.logo2,
          height: 150,
        ),
      ),
    );
  }
}
