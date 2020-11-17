import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/text.dart';

class MyButton extends StatelessWidget {
  final color;
  final TextColor;
  final String ButtonText;
  final ButtonTapped;

  MyButton({this.color, this.TextColor, this.ButtonText, this.ButtonTapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ButtonTapped,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                ButtonText,
                style: TextStyle(
                    color: TextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
