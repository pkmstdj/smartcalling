import 'package:flutter/material.dart';

class itemCheckBoxText extends StatelessWidget {
  const itemCheckBoxText({
    Key? key,
    required this.width,
    required this.text,
    required this.value,
    required this.onChanged,
  }) : super(key: key);
  final double width;
  final Widget text;
  final bool value;
  final Function(bool?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.fromLTRB(3, 1.5, 3, 1.5),
      child: Row(
        children: [
          SizedBox(width: 24, height: 24, child: Checkbox(value: value, onChanged: onChanged)),
          Container(width: 5,),
          text
        ],
      )
    );
  }
}