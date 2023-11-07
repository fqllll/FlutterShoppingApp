import 'package:flutter/material.dart';

// 背景
BoxDecoration background1 = BoxDecoration(
  image: DecorationImage(
    image: AssetImage('images/background.png'), 
    fit: BoxFit.cover,
    colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.3),BlendMode.dstATop)
  ),
);

BoxDecoration background2 = BoxDecoration(
  image: DecorationImage(
    image: AssetImage('images/background2.png'), 
    fit: BoxFit.cover,
    colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.3),BlendMode.dstATop)
  ),
);