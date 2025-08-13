import 'package:flutter/material.dart';

class TitleProducts extends StatelessWidget {
  const TitleProducts({required this.text, this.style, super.key});
  final String text;
  final TextStyle? style;
  @override

  Widget build(BuildContext context) {
    return Text(text, maxLines: 1, overflow: TextOverflow.ellipsis, softWrap: true, textAlign: TextAlign.center, style: style,);
  }
}
